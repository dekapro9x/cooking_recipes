import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpMethod {
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
}

class PublicApiClient {
  final Dio _dio;
  final SharedPreferences _prefs;

  PublicApiClient(String baseUrl, this._prefs) : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    // NOTE: Không phụ thuộc Env/Environment để tránh lỗi build.
    // Nếu bạn muốn tắt log ở production, hãy điều khiển bằng biến config riêng.
    _dio.interceptors.addAll([_authInterceptor(), _loggingInterceptor()]);
  }

  Future<T> apiCall<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return result;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception(
            "Kết nối đến máy chủ bị gián đoạn. Vui lòng thử lại.",
          );
        case DioExceptionType.receiveTimeout:
          throw Exception(
            "Máy chủ phản hồi quá chậm. Vui lòng kiểm tra kết nối mạng.",
          );
        case DioExceptionType.sendTimeout:
          throw Exception(
            "Không thể gửi yêu cầu đến máy chủ. Vui lòng thử lại sau.",
          );
        case DioExceptionType.badCertificate:
          throw Exception("Không thể xác minh kết nối bảo mật với máy chủ.");
        case DioExceptionType.badResponse:
          _handleBadResponse(e.response, e.error);
          throw Exception(
            "Máy chủ phản hồi không hợp lệ. Vui lòng thử lại sau.",
          );
        case DioExceptionType.cancel:
          throw Exception("Yêu cầu đã bị hủy.");
        case DioExceptionType.connectionError:
          throw Exception(
            "Không có kết nối mạng. Vui lòng kiểm tra Internet và thử lại.",
          );
        case DioExceptionType.unknown:
          throw Exception(
            "Đã xảy ra lỗi không xác định. Vui lòng thử lại sau.",
          );
        default:
          throw Exception("Đã xảy ra lỗi. Vui lòng thử lại.");
      }
    } catch (e) {
      throw Exception(
        "Đã xảy ra lỗi trong quá trình xử lý. Vui lòng thử lại sau.",
      );
    }
  }

  String? getErrorMessage(Response? response) {
    if (response == null) {
      return 'Không nhận được phản hồi từ máy chủ';
    }

    if (response.data == null) {
      return 'Dữ liệu phản hồi bị thiếu';
    }

    if (response.data is! Map) {
      return response.data.toString();
    }

    if (!(response.data as Map).containsKey('message')) {
      return 'Không tìm thấy thông báo lỗi trong phản hồi';
    }

    final dynamic message = response.data['message'];
    if (message == null) {
      return 'Không tìm thấy tài nguyên yêu cầu';
    }

    return message is String ? message : null;
  }

  void _handleBadResponse(Response? response, dynamic error) {
    switch (response?.statusCode) {
      case 400:
        throw Exception(getErrorMessage(response) ?? 'Yêu cầu không hợp lệ.');
      case 401:
        throw AuthenticationException(
          getErrorMessage(response) ??
              'Bạn chưa đăng nhập hoặc phiên làm việc đã hết hạn. Vui lòng đăng nhập lại!',
        );
      case 403:
        throw Exception(
          getErrorMessage(response) ??
              'Bạn không có quyền truy cập tài nguyên này. Vui lòng liên hệ với quản trị viên hệ thống!',
        );
      case 404:
        throw Exception(getErrorMessage(response));
      case 500:
        throw Exception(
          getErrorMessage(response) ??
              'Lỗi máy chủ nội bộ. Vui lòng thử lại sau!',
        );
      default:
        throw Exception('Đã xảy ra lỗi không xác định. Vui lòng thử lại sau!');
    }
  }

  Future<T> request<T>({
    required String path,
    required T Function(dynamic data) parser,
    String method = HttpMethod.get,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    return apiCall(() async {
      final response = await _dio.request(
        path,
        options: Options(method: method),
        queryParameters: queryParameters,
        data: data,
      );

      return parser(response.data);
    });
  }

  Future<Response> get(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) async {
    return apiCall(() async {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    });
  }

  Future<Response> patch(
    String path,
    dynamic data, [
    Map<String, dynamic>? queryParameters,
  ]) async {
    return apiCall(() async {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    });
  }

  Future<Response> post(
    String path, [
    dynamic data,
    Map<String, dynamic>? queryParameters,
  ]) async {
    return apiCall(() async {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    });
  }

  Future<Response> delete(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) async {
    return apiCall(() async {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
      );
      return response;
    });
  }

  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = _prefs.getString('accessToken');
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          try {
            await _refreshToken();
            final retryResponse = await _dio.request(
              error.requestOptions.path,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
              options: Options(
                method: error.requestOptions.method,
                headers: _dio.options.headers,
              ),
            );
            return handler.resolve(retryResponse);
          } catch (e) {
            _prefs.remove('accessToken');
            _prefs.remove('refreshToken');
          }
        }
        return handler.next(error);
      },
    );
  }

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        // logWithColor(
        //     '🌐 ================== REQUEST API ==================: ${options.uri} ',
        //     yellow);
        // _logRequest(options);
        return handler.next(options);
      },
      onResponse: (response, handler) {
        _logDivider('RESPONSE API: ${response.realUri}');
        _logResponse(response);
        return handler.next(response);
      },
      onError: (error, handler) {
        _logDivider('ERROR API: ${error.requestOptions.uri}');
        _logError(error);
        return handler.next(error);
      },
    );
  }

  void _logDivider(String title) {
    debugPrint('\n🌐 ================== $title ==================');
  }

  void _logRequest(RequestOptions options) {
    debugPrint('URL: ${options.uri}');
    debugPrint('Method: ${options.method}');
    debugPrint('Headers: ${_formatMapForLog(options.headers)}');
    if (options.data != null) {
      debugPrint('Body: ${_truncateAndFormat(options.data)}');
    }
  }

  void _logResponse(Response response) {
    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Headers: ${_formatMapForLog(response.headers.map)}');
    if (response.data != null) {
      debugPrint('Body: ${_truncateAndFormat(response.data)}');
    }
  }

  void _logError(DioException error) {
    debugPrint('Error: ${error.error}');
    debugPrint('Error Response: ${error.response}');
  }

  String _truncateAndFormat(dynamic data) {
    const int maxLength = 1000;
    String formatted = '';

    if (data is Map || data is List) {
      try {
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        formatted = encoder.convert(data);
      } catch (e) {
        formatted = data.toString();
      }
    } else {
      formatted = data.toString();
    }

    if (formatted.length > maxLength) {
      return '${formatted.substring(0, maxLength)}... (truncated, total length: ${formatted.length})';
    }
    return formatted;
  }

  String _formatMapForLog(Map<String, dynamic> map) {
    return map.entries.map((e) => '\n  ${e.key}: ${e.value}').join(',');
  }

  Future<void> _refreshToken() async {
    final refreshToken = _prefs.getString('refreshToken');
    if (refreshToken == null) throw Exception('No refresh token');

    // TODO: Thay path này bằng endpoint refresh token thật của dự án bạn.
    // Ví dụ: '/auth/refresh-token' hoặc '/v1/auth/refresh-token'
    const refreshPath = '/auth/refresh-token';

    final response = await _dio.post(
      refreshPath,
      data: {'refreshToken': refreshToken},
    );

    final data = response.data;
    if (data is! Map) {
      throw Exception('Refresh token response không đúng định dạng');
    }

    final tokens = (data['data'] as Map?)?['tokens'] as Map?;
    final accessToken = (tokens?['access'] as Map?)?['token']?.toString();
    final newRefreshToken = (tokens?['refresh'] as Map?)?['token']?.toString();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Không lấy được accessToken mới');
    }

    await _prefs.setString('accessToken', accessToken);
    if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
      await _prefs.setString('refreshToken', newRefreshToken);
    }
  }
}

/// Exception riêng cho trường hợp 401 để UI có thể điều hướng về màn đăng nhập.
class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);

  @override
  String toString() => message;
}
