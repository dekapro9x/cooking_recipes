/// Model cho API:
/// GET https://696a54653a2b2151f847cce9.mockapi.io/api/v1/featured_recipe_list/recipe_home_page
/// Response là 1 mảng JSON, mỗi phần tử có các field:
/// createdAt, name, avatar, title, timeCooking, id
class RecipeMealModel {
  final int createdAt; // epoch seconds
  final String name;
  final String avatar;
  final String title;
  final int timeCooking;
  final String id;

  const RecipeMealModel({
    required this.createdAt,
    required this.name,
    required this.avatar,
    required this.title,
    required this.timeCooking,
    required this.id,
  });

  /// Tiện ích: đổi createdAt (epoch seconds) sang DateTime
  DateTime get createdAtDateTime =>
      DateTime.fromMillisecondsSinceEpoch(createdAt * 1000, isUtc: true);

  RecipeMealModel copyWith({
    int? createdAt,
    String? name,
    String? avatar,
    String? title,
    int? timeCooking,
    String? id,
  }) {
    return RecipeMealModel(
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      title: title ?? this.title,
      timeCooking: timeCooking ?? this.timeCooking,
      id: id ?? this.id,
    );
  }

  factory RecipeMealModel.fromJson(Map<String, dynamic> json) {
    return RecipeMealModel(
      createdAt: _asInt(json['createdAt']) ?? 0,
      name: (json['name'] ?? '').toString(),
      avatar: (json['avatar'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      timeCooking: _asInt(json['timeCooking']) ?? 0,
      id: (json['id'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'name': name,
      'avatar': avatar,
      'title': title,
      'timeCooking': timeCooking,
      'id': id,
    };
  }

  /// Parse nhanh response dạng List<dynamic>
  static List<RecipeMealModel> listFromJson(List<dynamic> raw) {
    return raw
        .map((e) => e as Map<String, dynamic>)
        .map(RecipeMealModel.fromJson)
        .toList();
  }

  static int? _asInt(dynamic v) {
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is String) return int.tryParse(v);
    return null;
  }
}
