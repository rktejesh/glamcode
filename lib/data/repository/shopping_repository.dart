import 'dart:convert';

import 'package:glamcode/data/model/packages_model/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_helper.dart';
import '../model/auth.dart';

class ShoppingRepository {
  Auth auth = Auth.instance;
  DioClient dioClient = DioClient.instance;
  SharedPreferences sharedPreferences;
  ShoppingRepository(
      {required this.auth,
      required this.dioClient,
      required this.sharedPreferences});

  Future<Map<ServicePackage, int>> loadCartItems() async {
    Map<ServicePackage, int> cart = {};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("cart")) {
        cart = cartDecode(prefs.getString("cart") ?? "{}");
      } else {
        cart = {};
        prefs.setString("cart", cartEncode(cart));
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return cart;
  }

  Future<void> addItemToCart(ServicePackage servicePackage) async {
    Map<ServicePackage, int> cart = {};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("cart")) {
        cart = cartDecode(prefs.getString("cart") ?? "{}");
        if (cart.containsKey(servicePackage)) {
          cart[servicePackage] = (cart[servicePackage] ?? 0) + 1;
        } else {
          cart[servicePackage] = 1;
        }
        prefs.setString("cart", cartEncode(cart));
      } else {
        cart = {};
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> removeItemFromCart(ServicePackage servicePackage) async {
    Map<ServicePackage, int> cart = {};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("cart")) {
        cart = cartDecode(prefs.getString("cart") ?? "{}");
        if (cart.containsKey(servicePackage) && cart[servicePackage]! > 0) {
          cart[servicePackage] = (cart[servicePackage] ?? 1) - 1;
        }
        prefs.setString("cart", cartEncode(cart));
      } else {
        cart = {};
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  num getTotalPrice() {
    Map<ServicePackage, int> cart = {};
    num total = 0;
    try {
      if (sharedPreferences.containsKey("cart")) {
        cart = cartDecode(sharedPreferences.getString("cart") ?? "{}");
        cart.forEach((key, value) {
          total += key.discountedPrice! * value;
        });
      } else {
        cart = {};
        sharedPreferences.setString("cart", cartEncode(cart));
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return total;
  }

  num getTotalDiscount() {
    Map<ServicePackage, int> cart = {};
    num total = 0;
    try {
      if (sharedPreferences.containsKey("cart")) {
        cart = cartDecode(sharedPreferences.getString("cart") ?? "{}");
        cart.forEach((key, value) {
          total += key.discountedPrice! * value;
        });
      } else {
        cart = {};
        sharedPreferences.setString("cart", cartEncode(cart));
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return total;
  }
}

String cartEncode(Map<ServicePackage, int> cart) {
  Map<String, dynamic> res = {};
  cart.forEach((key, value) {
    res[jsonEncode(key.toMap())] = value;
  });
  return jsonEncode(res);
}

Map<ServicePackage, int> cartDecode(String cart) {
  Map<String, dynamic> mp = jsonDecode(cart);
  Map<ServicePackage, int> res = {};
  mp.forEach((key, value) {
    res[ServicePackage.fromMap(jsonDecode(key))] = value as int;
  });
  return res;
}
