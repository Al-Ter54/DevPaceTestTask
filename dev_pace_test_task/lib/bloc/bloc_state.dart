import '../model/model_element.dart';

abstract class BlocState {}

class BlocStateEmpty extends BlocState {}

class BlocStateLoading extends BlocState {
  BlocStateLoading(this.list);

  final List<ModelElement> list;
}

class BlocStateLoaded extends BlocState {
  BlocStateLoaded(this.list);

  final List<ModelElement> list;
}

class BlocStateError extends BlocState {
  BlocStateError(this.error);

  final Object error;
}
