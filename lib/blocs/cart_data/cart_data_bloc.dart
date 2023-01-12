import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glamcode/data/model/cart_data.dart';
import 'package:glamcode/data/model/coupons.dart';
import 'package:glamcode/data/repository/cart_data_repository.dart';
import 'package:meta/meta.dart';

part 'cart_data_event.dart';
part 'cart_data_state.dart';

class CartDataBloc extends Bloc<CartDataEvent, CartDataState> {
  CartDataBloc(this.cartDataRepository) : super(CartDataLoading()) {
    on<CartDataStarted>(_onStarted);
    on<CartDataUpdate>(_onCartUpdate);
    on<CartBookingSlotUpdate>(_onBookingSlotUpdate);
    on<CartCouponUpdate>(_onCouponUpdate);
  }

  final CartDataRepository cartDataRepository;

  Future<void> _onStarted(
      CartDataStarted event, Emitter<CartDataState> emit) async {
    emit(CartDataLoading());
    try {
      CartData cartDataItem = await cartDataRepository.loadItems();
      // final items = await shoppingRepository.loadCartItems();
      emit(CartDataLoaded(cartData: cartDataItem));
    } catch (_) {
      emit(CartDataError());
    }
  }

  void _onCartUpdate(CartDataUpdate event, Emitter<CartDataState> emit) {
    final state = this.state;
    emit(CartDataLoading());
    if (state is CartDataLoaded) {
      try {
        CartData cartDataItem = cartDataRepository.updateCart(state.cartData);
        // final items = await shoppingRepository.loadCartItems();
        emit(CartDataLoaded(cartData: cartDataItem));
      } catch (_) {
        emit(CartDataError());
      }
    }
  }

  void _onBookingSlotUpdate(CartBookingSlotUpdate event, Emitter<CartDataState> emit) {
    final state = this.state;
    emit(CartDataLoading());
    if (state is CartDataLoaded) {
      try {
        CartData cartDataItem = cartDataRepository.updateBookingSlot(state.cartData, event.item);
        emit(CartDataLoaded(cartData: cartDataItem));
      } catch (_) {
        emit(CartDataError());
      }
    }
  }

  void _onCouponUpdate(CartCouponUpdate event, Emitter<CartDataState> emit) {
    final state = this.state;
    emit(CartDataLoading());
    if(state is CartDataLoaded) {
      try {
        CartData cartDataItem = cartDataRepository.updateCoupon(state.cartData, event.item);
        emit(CartDataLoaded(cartData: cartDataItem));
      } catch (_) {
        emit(CartDataError());
      }
    }
  }
}
