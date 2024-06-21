import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tester/model/catagorymodel.dart';
import 'package:tester/repo/repocatagory.dart';

part 'datacatagory_event.dart';
part 'datacatagory_state.dart';

class DatacatagoryBloc extends Bloc<DatacatagoryEvent, DatacatagoryState> {
  final RepoCatagory repocatagort;
  DatacatagoryBloc(this.repocatagort) : super(DatacatagoryLoaddingState()) {
    on<DatacatagoryEvent>((event, emit) async {
      emit(DatacatagoryLoaddingState());
      try {
        final catagorydata = await repocatagort.getDataCatagory();
        emit(DatacatagoryLoadedState(catagorydata));
      } catch (e) {
        emit(DatacatagoryErrorState(e.toString()));
        print(e);
      }
    });
  }
}
