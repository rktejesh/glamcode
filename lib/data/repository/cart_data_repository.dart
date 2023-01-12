import 'package:glamcode/data/model/coupons.dart';
import 'package:glamcode/data/repository/shopping_repository.dart';

import '../api/api_helper.dart';
import '../model/auth.dart';
import '../model/cart_data.dart';
import 'coupon_repository.dart';

class CartDataRepository {
  Auth auth = Auth.instance;
  DioClient dioClient = DioClient.instance;
  ShoppingRepository shoppingRepository;
  CouponRepository couponRepository;
  CartDataRepository({
    required this.auth,
    required this.dioClient,
    required this.shoppingRepository,
    required this.couponRepository
  });

  Future<CartData> loadItems() async {
    num? couponId;
    num? userId;
    num? originalAmount;
    num? discount;
    num? couponDiscount;
    num? discountPercent;
    num? mincheck;
    String? taxName;
    num? taxPercent;
    num? extraFees;
    final num? distanceFee;
    final num? amountToPay;
    try {
      await Auth.instance.currentUser.then((value) => userId = value.id);
      originalAmount = shoppingRepository.getTotalPrice();
      couponRepository.currentCoupon.then((value) {
        couponId = value.id;
        if (value.percent != null) {
          discount = (originalAmount ?? 0 * (value.percent ?? 0)) / 100;
        } else {
          discount = value.amount;
        }
        couponDiscount = discount;
        discountPercent = (value.percent ?? 0);
      });

      await dioClient.getAnyDataCall().then((value) {
        if (value != null) {
          if (value.tax != null && value.tax!.isNotEmpty) {
            taxName = value.tax![0].taxName;
            taxPercent = value.tax![0].percent;
          }
          if (value.extraFees != null && value.extraFees!.isNotEmpty) {
            extraFees = value.extraFees![0].amount;
          }
          if(value.mincheck!=null && value.mincheck!.isNotEmpty) {
            mincheck = num.parse(value.mincheck![0].amount ?? "0");
          }
        }
      });

      amountToPay =
          (((originalAmount) + (extraFees ?? 0) - (discount ?? 0)) * 100) / 100;

      CartData cartData = CartData(
          couponId: couponId,
          userId: userId,
          originalAmount: originalAmount,
          discount: discount,
          couponDiscount: couponDiscount,
          discountPercent: discountPercent,
          taxName: taxName,
          mincheck: mincheck,
          taxPercent: taxPercent,
          extraFees: extraFees,
          amountToPay: amountToPay);
      return cartData;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  CartData updateCart(CartData cartData) {
    num? originalAmount;
    final num? amountToPay;
    try {
      originalAmount = shoppingRepository.getTotalPrice();

      amountToPay = (((originalAmount) +
                  (cartData.extraFees ?? 0) -
                  (cartData.discount ?? 0)) *
              100) /
          100;
      return cartData.copyWith(
          originalAmount: originalAmount, amountToPay: amountToPay);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  CartData updateBookingSlot(CartData cartData, String bookingSlot) {
    try {
      return cartData.copyWith(bookingDateTime: bookingSlot);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  CartData updateCoupon(CartData cartData, CouponData couponData) {
    try {
      couponRepository.updateCurrentCouponInstance(couponData);
      return cartData.copyWith(couponId: couponData.id, couponDiscount: couponData.amount, discountPercent: couponData.percent);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
