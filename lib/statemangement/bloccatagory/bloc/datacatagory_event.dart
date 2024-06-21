part of 'datacatagory_bloc.dart';

@immutable
sealed class DatacatagoryEvent extends Equatable {
  const DatacatagoryEvent();

  @override
  List<Object> get props => [];
}

class GetCatagoryEvent extends DatacatagoryEvent {
  
}
