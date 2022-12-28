import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glamcode/data/model/cart_data.dart';
import 'package:glamcode/data/repository/cart_data_repository.dart';
import 'package:meta/meta.dart';

part 'cart_data_event.dart';
part 'cart_data_state.dart';

class CartDataBloc extends Bloc<CartDataEvent, CartDataState> {
  CartDataBloc(this.cartDataRepository) : super(CartDataLoading()) {
    on<CartDataStarted>(_onStarted);
    on<CartDataUpdate>(_onCartUpdate);
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
}
