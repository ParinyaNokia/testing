import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//event
abstract class LocaleEvent {}

class Changelocale extends LocaleEvent {
  final Locale locale;
  Changelocale(this.locale);
}

//state
class LocaleState {
  final Locale locale;
  LocaleState(this.locale);
}

//bloc
class Changelanguage extends Bloc<LocaleEvent, LocaleState> {
  Changelanguage() : super(LocaleState(Locale('en', ''))) {
    on<Changelocale>((event, emit) {
      emit(LocaleState(event.locale));
    });
  }

  Stream<LocaleState> mapEventtoState(LocaleEvent event) async* {
    if (event is Changelocale) {
      yield LocaleState(event.locale);
    }
  }
}
