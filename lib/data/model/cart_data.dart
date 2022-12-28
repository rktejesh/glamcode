import 'dart:convert';
/// coupon_id : 1234
/// user_id : 1234
/// booking_date_time : "2022-12-28 17:30:00"
/// status : "pending"
/// payment_gateway : "cash"
/// original_amount : 123.40
/// discount : 123.4
/// coupon_discount : 123.4
/// discount_percent : 20.2
/// tax_name : ""
/// tax_percent : 14.5
/// extra_fees : 1234.0
/// distance_fee : 1234.0
/// amount_to_pay : 1234.0
/// payment_status : "cash"
/// source : "online"
/// additional_notes : ""

CartData cartDataFromJson(String str) => CartData.fromJson(json.decode(str));
String cartDataToJson(CartData data) => json.encode(data.toJson());
class CartData {
  CartData({
      this.couponId, 
      this.userId, 
      this.bookingDateTime, 
      this.status, 
      this.paymentGateway, 
      this.originalAmount, 
      this.discount, 
      this.couponDiscount, 
      this.discountPercent, 
      this.taxName, 
      this.taxPercent, 
      this.extraFees, 
      this.distanceFee, 
      this.amountToPay, 
      this.paymentStatus, 
      this.source, 
      this.additionalNotes,});

  CartData.fromJson(dynamic json) {
    couponId = json['coupon_id'];
    userId = json['user_id'];
    bookingDateTime = json['booking_date_time'];
    status = json['status'];
    paymentGateway = json['payment_gateway'];
    originalAmount = json['original_amount'];
    discount = json['discount'];
    couponDiscount = json['coupon_discount'];
    discountPercent = json['discount_percent'];
    taxName = json['tax_name'];
    taxPercent = json['tax_percent'];
    extraFees = json['extra_fees'];
    distanceFee = json['distance_fee'];
    amountToPay = json['amount_to_pay'];
    paymentStatus = json['payment_status'];
    source = json['source'];
    additionalNotes = json['additional_notes'];
  }
  num? couponId;
  num? userId;
  String? bookingDateTime;
  String? status;
  String? paymentGateway;
  num? originalAmount;
  num? discount;
  num? couponDiscount;
  num? discountPercent;
  String? taxName;
  num? taxPercent;
  num? extraFees;
  num? distanceFee;
  num? amountToPay;
  String? paymentStatus;
  String? source;
  String? additionalNotes;
CartData copyWith({  num? couponId,
  num? userId,
  String? bookingDateTime,
  String? status,
  String? paymentGateway,
  num? originalAmount,
  num? discount,
  num? couponDiscount,
  num? discountPercent,
  String? taxName,
  num? taxPercent,
  num? extraFees,
  num? distanceFee,
  num? amountToPay,
  String? paymentStatus,
  String? source,
  String? additionalNotes,
}) => CartData(  couponId: couponId ?? this.couponId,
  userId: userId ?? this.userId,
  bookingDateTime: bookingDateTime ?? this.bookingDateTime,
  status: status ?? this.status,
  paymentGateway: paymentGateway ?? this.paymentGateway,
  originalAmount: originalAmount ?? this.originalAmount,
  discount: discount ?? this.discount,
  couponDiscount: couponDiscount ?? this.couponDiscount,
  discountPercent: discountPercent ?? this.discountPercent,
  taxName: taxName ?? this.taxName,
  taxPercent: taxPercent ?? this.taxPercent,
  extraFees: extraFees ?? this.extraFees,
  distanceFee: distanceFee ?? this.distanceFee,
  amountToPay: amountToPay ?? this.amountToPay,
  paymentStatus: paymentStatus ?? this.paymentStatus,
  source: source ?? this.source,
  additionalNotes: additionalNotes ?? this.additionalNotes,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coupon_id'] = couponId;
    map['user_id'] = userId;
    map['booking_date_time'] = bookingDateTime;
    map['status'] = status;
    map['payment_gateway'] = paymentGateway;
    map['original_amount'] = originalAmount;
    map['discount'] = discount;
    map['coupon_discount'] = couponDiscount;
    map['discount_percent'] = discountPercent;
    map['tax_name'] = taxName;
    map['tax_percent'] = taxPercent;
    map['extra_fees'] = extraFees;
    map['distance_fee'] = distanceFee;
    map['amount_to_pay'] = amountToPay;
    map['payment_status'] = paymentStatus;
    map['source'] = source;
    map['additional_notes'] = additionalNotes;
    return map;
  }

}