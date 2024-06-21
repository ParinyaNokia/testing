import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tester/model/datamodel.dart';

import 'package:tester/repo/repodata.dart';

part 'get_api_event.dart';
part 'get_api_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final DataRepo repo;

  DataBloc(this.repo) : super(DataLoaddingState()) {
    on<GetDataEvent>(((event, emit) async {
      emit(DataLoaddingState());
      try {
        final data = await repo.getData();
        emit(DataLoadedState(data));
      } catch (e) {
        emit(DataErrorState(e.toString()));
        print(e);
      }
    }));
  }
}
