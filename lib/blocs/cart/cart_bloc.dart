import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:glamcode/blocs/cart_data/cart_data_bloc.dart';
import 'package:glamcode/data/model/my_cart/cart.dart';
import 'package:glamcode/data/model/packages_model/service.dart';
import 'package:meta/meta.dart';

import '../../data/repository/shopping_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this.shoppingRepository, this.cartDataBloc) : super(CartLoading()) {
    on<CartStarted>(_onStarted);
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartCleared>(_onCartCleared);
  }

  final ShoppingRepository shoppingRepository;
  final CartDataBloc cartDataBloc;

  Future<void> _onStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final items = await shoppingRepository.loadCartItems();
      emit(CartLoaded(cart: Cart(items: {...items})));
    } catch (_) {
      emit(CartError());
    }
  }

  Future<void> _onItemAdded(
    CartItemAdded event,
    Emitter<CartState> emit,
  ) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        await shoppingRepository.addItemToCart(event.item);
        state.cart.items[event.item] = 1 + (state.cart.items[event.item] ?? 0);
        emit(CartLoaded(cart: Cart(items: {...state.cart.items})));
        cartDataBloc.add(CartDataUpdate());
      } catch (_) {
        emit(CartError());
      }
    }
  }

  Future<void> _onItemRemoved(
      CartItemRemoved event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        await shoppingRepository.removeItemFromCart(event.item);
        if (state.cart.items[event.item] != null &&
            state.cart.items[event.item]! > 1) {
          state.cart.items[event.item] =
              (state.cart.items[event.item] ?? 0) - 1;
        } else if (state.cart.items[event.item] != null &&
            state.cart.items[event.item]! == 1) {
          state.cart.items.remove(event.item);
        }
        emit(CartLoaded(cart: Cart(items: {...state.cart.items})));
        cartDataBloc.add(CartDataUpdate());
      } catch (_) {
        print(_.toString());
        emit(CartError());
      }
    }
  }

  Future<void> _onCartCleared(
      CartCleared event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        await shoppingRepository.clearCart();
        emit(const CartLoaded(cart: Cart(items: {})));
        cartDataBloc.add(CartDataUpdate());
      } catch (_) {
        print(_.toString());
        emit(CartError());
      }
    }
  }
}
