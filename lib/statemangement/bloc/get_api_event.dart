part of 'get_api_bloc.dart';

@immutable
abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class GetDataEvent extends DataEvent {}
