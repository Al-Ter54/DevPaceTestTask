import 'package:dev_pace_test_task/bloc/bloc_event.dart';
import 'package:dev_pace_test_task/bloc/bloc_state.dart';
import 'package:dev_pace_test_task/service/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/model_element.dart';

class DevPaceBloc extends Bloc<BlocEvent, BlocState> {
  DevPaceBloc(this.service) : super(BlocStateEmpty()){
    on<BlocEventInit>(_onInit);
    on<BlocEventAdd>(_onAdd);
    on<BlocEventRemove>(_onRemove);
  }
  final Service service;
  List<ModelElement> oldList = [];

  Future<void> _onInit(
      BlocEvent event,
      Emitter<BlocState> emit,
      ) async {
    oldList = await service.getList();
    emit(BlocStateEmpty());
  }
  Future<void> _onAdd(
      BlocEvent event,
      Emitter<BlocState> emit,
      ) async {
    try {
      emit(BlocStateLoading(oldList));
      await service.addElement();
      var list = oldList = await service.getList();
      emit(BlocStateLoaded(list));
    } catch (e) {
      emit(BlocStateError(e));
    }
  }
  Future<void> _onRemove(
      BlocEvent event,
      Emitter<BlocState> emit,
      ) async {
    try {
      emit(BlocStateLoading(oldList));
      await service.removeElement();
      var list = oldList = await service.getList();
      if(list.isNotEmpty) {
        emit(BlocStateLoaded(list));
      } else {
        emit(BlocStateEmpty());
      }
    } catch (e) {
      emit(BlocStateError(e));
    }
  }
}