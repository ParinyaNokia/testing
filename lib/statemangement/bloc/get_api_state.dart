part of 'get_api_bloc.dart';

@immutable
abstract class DataState extends Equatable {}

class DataLoaddingState extends DataState {
  @override
  List<Object?> get props => [];
}

class DataLoadedState extends DataState {
  DataLoadedState(this.data);
  final List<ModelData> data;
  @override
  List<Object?> get props => [data];
}

class DataErrorState extends DataState {
  DataErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
