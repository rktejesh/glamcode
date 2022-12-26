import 'dart:convert';

import 'package:equatable/equatable.dart';

import '189.dart';
import '198.dart';

class ProductsArray extends Equatable {
	final 189? 189;
	final 198? 198;

	const ProductsArray({this.189, this.198});

	factory ProductsArray.fromMap(Map<String, dynamic> data) => ProductsArray(
				189: data['189'] == null
						? null
						: 189.fromMap(data['189'] as Map<String, dynamic>),
				198: data['198'] == null
						? null
						: 198.fromMap(data['198'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toMap() => {
				'189': 189?.toMap(),
				'198': 198?.toMap(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductsArray].
	factory ProductsArray.fromJson(String data) {
		return ProductsArray.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [ProductsArray] to a JSON string.
	String toJson() => json.encode(toMap());

	ProductsArray copyWith({
		189? 189,
		198? 198,
	}) {
		return ProductsArray(
			189: 189 ?? this.189,
			198: 198 ?? this.198,
		);
	}

	@override
	List<Object?> get props => [189, 198];
}
