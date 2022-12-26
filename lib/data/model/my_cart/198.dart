import 'dart:convert';

import 'package:equatable/equatable.dart';

class 198 extends Equatable {
	final String? serviceId;
	final String? servicePrice;
	final String? serviceName;
	final String? serviceDiscount;
	final String? serviceOriginalPrice;
	final String? type;
	final String? serviceImage;
	final String? serviceQuantity;

	const 198({
		this.serviceId, 
		this.servicePrice, 
		this.serviceName, 
		this.serviceDiscount, 
		this.serviceOriginalPrice, 
		this.type, 
		this.serviceImage, 
		this.serviceQuantity, 
	});

	factory 198.fromMap(Map<String, dynamic> data) => 198(
				serviceId: data['serviceID'] as String?,
				servicePrice: data['servicePrice'] as String?,
				serviceName: data['serviceName'] as String?,
				serviceDiscount: data['serviceDiscount'] as String?,
				serviceOriginalPrice: data['serviceOriginalPrice'] as String?,
				type: data['type'] as String?,
				serviceImage: data['serviceImage'] as String?,
				serviceQuantity: data['serviceQuantity'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'serviceID': serviceId,
				'servicePrice': servicePrice,
				'serviceName': serviceName,
				'serviceDiscount': serviceDiscount,
				'serviceOriginalPrice': serviceOriginalPrice,
				'type': type,
				'serviceImage': serviceImage,
				'serviceQuantity': serviceQuantity,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [198].
	factory 198.fromJson(String data) {
		return 198.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [198] to a JSON string.
	String toJson() => json.encode(toMap());

	198 copyWith({
		String? serviceId,
		String? servicePrice,
		String? serviceName,
		String? serviceDiscount,
		String? serviceOriginalPrice,
		String? type,
		String? serviceImage,
		String? serviceQuantity,
	}) {
		return 198(
			serviceId: serviceId ?? this.serviceId,
			servicePrice: servicePrice ?? this.servicePrice,
			serviceName: serviceName ?? this.serviceName,
			serviceDiscount: serviceDiscount ?? this.serviceDiscount,
			serviceOriginalPrice: serviceOriginalPrice ?? this.serviceOriginalPrice,
			type: type ?? this.type,
			serviceImage: serviceImage ?? this.serviceImage,
			serviceQuantity: serviceQuantity ?? this.serviceQuantity,
		);
	}

	@override
	List<Object?> get props {
		return [
				serviceId,
				servicePrice,
				serviceName,
				serviceDiscount,
				serviceOriginalPrice,
				type,
				serviceImage,
				serviceQuantity,
		];
	}
}
