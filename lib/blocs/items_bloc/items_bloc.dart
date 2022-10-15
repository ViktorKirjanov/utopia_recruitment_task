import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utopia_recruitment_task/models/firebase_user_model.dart';
import 'package:utopia_recruitment_task/models/item_model.dart';
import 'package:utopia_recruitment_task/service/firebase_item_service.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final FirebaseItemService _itemService;

  ItemsBloc(this._itemService) : super(InitialItemsState()) {
    on<GetItemsEvent>(_onGetListsEventListener);
    on<UpdatedItemsEvent>(_onUpdateListsEvent);
  }

  StreamSubscription? _subscription;
  void _onGetListsEventListener(
    GetItemsEvent event,
    Emitter<ItemsState> emit,
  ) async {
    try {
      emit(LoadingItemsState());
      await Future.delayed(const Duration(seconds: 2));

      if (event.user.isNotEmpty) {
        _subscription =
            _itemService.createItemStream(event.user.id).listen((lists) {
          add(UpdatedItemsEvent(lists));
        });
      } else {
        emit(ErrorItemsState());
      }
    } catch (_) {
      emit(ErrorItemsState());
    }
  }

  void _onUpdateListsEvent(
    UpdatedItemsEvent event,
    Emitter<ItemsState> emit,
  ) {
    emit(CompleteItemsState(event.items));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
