import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/addon_model/addon_datum.dart';
import '../../data/repository/shopping_repository.dart';
import '../cart_data/cart_data_bloc.dart';

part 'addon_event.dart';
part 'addon_state.dart';

class AddonBloc extends Bloc<AddonEvent, AddonState> {
  AddonBloc(this.shoppingRepository, this.cartDataBloc) : super(AddonLoading()) {
    on<AddonStarted>(_onStarted);
    on<AddonItemAdded>(_onAddonAdded);
    on<AddonItemRemoved>(_onAddonRemoved);
  }

  final ShoppingRepository shoppingRepository;
  final CartDataBloc cartDataBloc;

  Future<void> _onStarted(AddonStarted event, Emitter<AddonState> emit) async {
    emit(AddonLoading());
    try {
      final addons = await shoppingRepository.loadAddonItems();
      emit(AddonLoaded(addonList: [...addons]));
    } catch (_) {
      emit(AddonError());
    }
  }


  Future<void> _onAddonAdded(
      AddonItemAdded event,
      Emitter<AddonState> emit,
      ) async {
    final state = this.state;
    if (state is AddonLoaded) {
      try {
        await shoppingRepository.addAddonToCart(event.item);
        state.addonList.add(event.item);
        emit(AddonLoaded(addonList: [...state.addonList]));
        cartDataBloc.add(CartDataUpdate());
      } catch (_) {
        emit(AddonError());
      }
    }
  }

  Future<void> _onAddonRemoved(AddonItemRemoved event, Emitter<AddonState> emit) async {
    final state = this.state;
    if (state is AddonLoaded) {
      try {
        await shoppingRepository.removeAddonFromCart(event.item);
        state.addonList.remove(event.item);
        print("-=-=-=-=-------------------${state.addonList}");
        emit(AddonLoaded(addonList: [...state.addonList]));
        cartDataBloc.add(CartDataUpdate());
      } catch (_) {
        emit(AddonError());
      }
    }
  }
}
