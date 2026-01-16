import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  /// Nhận baseUrl từ bên ngoài (setupDI/AppConfig) để tránh hardcode.
  DioClient(String baseUrl)
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      );
}
