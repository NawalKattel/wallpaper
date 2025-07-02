import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(ThemeMode.dark));

  void setDarkTheme() => emit(ThemeInitial(ThemeMode.dark));

  void setLightTheme() => emit(ThemeInitial(ThemeMode.light));
  void toggleTheme() {
    if (state.themeMode == ThemeMode.light) {
      setDarkTheme();
    } else {
      setLightTheme();
    }
  }
}
