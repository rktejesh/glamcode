import 'dart:convert';
/// status : "success"
/// message : "Coupons List Records"
/// couponData : [{"id":11,"title":"gcnew","start_date_time":"2022-03-12 00:02:00","end_date_time":"2022-12-31 00:02:00","uses_limit":100,"used_time":6,"amount":200,"percent":5,"minimum_purchase_amount":900,"days":"[\"Monday\",\"Tuesday\",\"Wednesday\",\"Thursday\",\"Friday\",\"Saturday\"]","status":"active","description":null,"created_at":"2022-03-12 11:44:15","updated_at":"2022-12-16 10:26:28"},{"id":13,"title":"xmas10","start_date_time":"2022-12-24 09:18:00","end_date_time":"2023-01-01 09:18:00","uses_limit":100,"used_time":32,"amount":100,"percent":null,"minimum_purchase_amount":1599,"days":"[\"Sunday\",\"Monday\",\"Tuesday\",\"Wednesday\",\"Thursday\",\"Friday\",\"Saturday\"]","status":"active","description":null,"created_at":"2022-08-07 15:19:00","updated_at":"2022-12-24 12:46:47"}]

Coupons couponsFromJson(String str) => Coupons.fromJson(json.decode(str));
String couponsToJson(Coupons data) => json.encode(data.toJson());
class Coupons {
  Coupons({
      this.status, 
      this.message, 
      this.couponData,});

  Coupons.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['couponData'] != null) {
      couponData = [];
      json['couponData'].forEach((v) {
        couponData?.add(CouponData.fromJson(v));
      });
    }
  }
  String? status;
  String? message;
  List<CouponData>? couponData;
Coupons copyWith({  String? status,
  String? message,
  List<CouponData>? couponData,
}) => Coupons(  status: status ?? this.status,
  message: message ?? this.message,
  couponData: couponData ?? this.couponData,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (couponData != null) {
      map['couponData'] = couponData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 11
/// title : "gcnew"
/// start_date_time : "2022-03-12 00:02:00"
/// end_date_time : "2022-12-31 00:02:00"
/// uses_limit : 100
/// used_time : 6
/// amount : 200
/// percent : 5
/// minimum_purchase_amount : 900
/// days : "[\"Monday\",\"Tuesday\",\"Wednesday\",\"Thursday\",\"Friday\",\"Saturday\"]"
/// status : "active"
/// description : null
/// created_at : "2022-03-12 11:44:15"
/// updated_at : "2022-12-16 10:26:28"

CouponData couponDataFromJson(String str) => CouponData.fromJson(json.decode(str));
String couponDataToJson(CouponData data) => json.encode(data.toJson());
class CouponData {
  CouponData({
      this.id, 
      this.title, 
      this.startDateTime, 
      this.endDateTime, 
      this.usesLimit, 
      this.usedTime, 
      this.amount, 
      this.percent, 
      this.minimumPurchaseAmount, 
      this.days, 
      this.status, 
      this.description, 
      this.createdAt, 
      this.updatedAt,});

  CouponData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
    usesLimit = json['uses_limit'];
    usedTime = json['used_time'];
    amount = json['amount'];
    percent = json['percent'];
    minimumPurchaseAmount = json['minimum_purchase_amount'];
    days = json['days'];
    status = json['status'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? title;
  String? startDateTime;
  String? endDateTime;
  num? usesLimit;
  num? usedTime;
  num? amount;
  num? percent;
  num? minimumPurchaseAmount;
  String? days;
  String? status;
  dynamic description;
  String? createdAt;
  String? updatedAt;
CouponData copyWith({  num? id,
  String? title,
  String? startDateTime,
  String? endDateTime,
  num? usesLimit,
  num? usedTime,
  num? amount,
  num? percent,
  num? minimumPurchaseAmount,
  String? days,
  String? status,
  dynamic description,
  String? createdAt,
  String? updatedAt,
}) => CouponData(  id: id ?? this.id,
  title: title ?? this.title,
  startDateTime: startDateTime ?? this.startDateTime,
  endDateTime: endDateTime ?? this.endDateTime,
  usesLimit: usesLimit ?? this.usesLimit,
  usedTime: usedTime ?? this.usedTime,
  amount: amount ?? this.amount,
  percent: percent ?? this.percent,
  minimumPurchaseAmount: minimumPurchaseAmount ?? this.minimumPurchaseAmount,
  days: days ?? this.days,
  status: status ?? this.status,
  description: description ?? this.description,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['start_date_time'] = startDateTime;
    map['end_date_time'] = endDateTime;
    map['uses_limit'] = usesLimit;
    map['used_time'] = usedTime;
    map['amount'] = amount;
    map['percent'] = percent;
    map['minimum_purchase_amount'] = minimumPurchaseAmount;
    map['days'] = days;
    map['status'] = status;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}