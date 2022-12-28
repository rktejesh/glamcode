import 'dart:convert';

/// status : "success"
/// message : "Data Found"
/// addonData : [{"name":"I don't require any add-ons","price":"0"},{"name":"Chin & Jawline wax","price":"99"},{"name":"Sidelocks wax","price":"99"},{"name":"Hair Color Application- Root Touchup","price":"199"},{"name":"Face & Neck Detan Pack","price":"199"}]

AddonsModel addonsModelFromJson(String str) =>
    AddonsModel.fromJson(json.decode(str));
String addonsModelToJson(AddonsModel data) => json.encode(data.toJson());

class AddonsModel {
  AddonsModel({
    this.status,
    this.message,
    this.addonData,
  });

  AddonsModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['addonData'] != null) {
      addonData = [];
      json['addonData'].forEach((v) {
        addonData?.add(AddonData.fromJson(v));
      });
    }
  }
  String? status;
  String? message;
  List<AddonData>? addonData;
  AddonsModel copyWith({
    String? status,
    String? message,
    List<AddonData>? addonData,
  }) =>
      AddonsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        addonData: addonData ?? this.addonData,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (addonData != null) {
      map['addonData'] = addonData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// name : "I don't require any add-ons"
/// price : "0"

AddonData addonDataFromJson(String str) => AddonData.fromJson(json.decode(str));
String addonDataToJson(AddonData data) => json.encode(data.toJson());

class AddonData {
  AddonData({
    this.name,
    this.price,
  });

  AddonData.fromJson(dynamic json) {
    name = json['name'];
    price = json['price'];
  }
  String? name;
  String? price;
  AddonData copyWith({
    String? name,
    String? price,
  }) =>
      AddonData(
        name: name ?? this.name,
        price: price ?? this.price,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['price'] = price;
    return map;
  }
}
