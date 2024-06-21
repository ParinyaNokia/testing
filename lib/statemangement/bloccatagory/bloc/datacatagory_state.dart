part of 'datacatagory_bloc.dart';

@immutable
sealed class DatacatagoryState extends Equatable {}

final class DatacatagoryLoaddingState extends DatacatagoryState {
  @override
  List<Object?> get props => [];
}

final class DatacatagoryLoadedState extends DatacatagoryState {
  DatacatagoryLoadedState(this.product);
  final List<Product> product;
  @override
  List<Object?> get props => [product];
}

final class DatacatagoryErrorState extends DatacatagoryState {
  DatacatagoryErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
