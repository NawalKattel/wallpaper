import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/constants/colors.dart';

ThemeData appLightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.lightOnPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.lightOnSecondary,
    error: AppColors.error,
    onError: AppColors.onError,
    surface: AppColors.lightBackground,
    onSurface: AppColors.lightOnSurface,
  ),
  scaffoldBackgroundColor: AppColors.lightBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightSurface,
    foregroundColor: AppColors.lightOnSurface,
    elevation: 0,
  ),
);

ThemeData appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.darkOnPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.darkOnSecondary,
    error: AppColors.error,
    onError: AppColors.onError,
    surface: AppColors.darkBackground,
    onSurface: AppColors.darkOnSurface,
  ),
  scaffoldBackgroundColor: AppColors.darkBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.darkOnSurface,
    elevation: 0,
  ),
);
