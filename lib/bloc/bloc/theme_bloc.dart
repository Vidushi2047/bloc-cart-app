import 'package:bloc/bloc.dart';
import 'package:bloc_cart_app/utils/aap_themes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            themeData: AppThemes().AppThemesData[AppTheme.brownTheme]!)) {
    on<ThemeEvent>((event, emit) {
      // Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
      //   print('yes');
      //   yield ThemeState(
      //     themeData: AppThemes().AppThemesData[event.appTheme]!,
      //   );
      // }

      print('----${event.appTheme}---$emit');

      emit(state.copyWith(
          themeData: AppThemes().AppThemesData[event.appTheme]!));
    });
  }
  // @override
  // void onChange(Change<ThemeState> change) {
  //   print('theme block-$change');
  //   super.onChange(change);
  // }
  // @override
  // void onTransition(Transition<ThemeEvent, ThemeState> transition) {
  //   print('$transition-$StackTrace-$transition');
  //   super.onTransition(transition);
  // }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   print(error);
  //   super.onError(error, stackTrace);
  // }
}
