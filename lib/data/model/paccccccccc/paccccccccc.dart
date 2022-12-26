import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'category.dart';
import 'main_category.dart';

class Paccccccccc extends Equatable {
  final String? status;
  final String? message;
  final MainCategory? mainCategory;
  final List<Category>? categories;

  const Paccccccccc({
    this.status,
    this.message,
    this.mainCategory,
    this.categories,
  });

  factory Paccccccccc.fromMap(Map<String, dynamic> data) => Paccccccccc(
        status: data['status'] as String?,
        message: data['message'] as String?,
        mainCategory: data['mainCategory'] == null
            ? null
            : MainCategory.fromMap(
                data['mainCategory'] as Map<String, dynamic>),
        categories: (data['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'mainCategory': mainCategory?.toMap(),
        'categories': categories?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Paccccccccc].
  factory Paccccccccc.fromJson(String data) {
    return Paccccccccc.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Paccccccccc] to a JSON string.
  String toJson() => json.encode(toMap());

  Paccccccccc copyWith({
    String? status,
    String? message,
    MainCategory? mainCategory,
    List<Category>? categories,
  }) {
    return Paccccccccc(
      status: status ?? this.status,
      message: message ?? this.message,
      mainCategory: mainCategory ?? this.mainCategory,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [status, message, mainCategory, categories];
}
