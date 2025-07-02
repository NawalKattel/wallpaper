import 'package:flutter/material.dart';
import 'package:wallpaper_app/app.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/pages/accounts.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/pages/explorer.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/pages/home.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/widgets/preview.dart';

class AppRoutes {
  static const String initial = '/';

  static const String home = '/home';
  static const String accounts = '/account';
  static const String explorer = '/explorer';
  static const String preview = '/preview';
  static const String wallpaperDetail = '/wallpaper_detail';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const MainPage(),

    home: (context) => const HomePage(),
    accounts: (context) => const AccountsPage(),
    explorer: (context) => ExplorerPage(),
    preview: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      return PreviewPage(imageSource: args as String);
    },
    wallpaperDetail: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      return PreviewPage(imageSource: args as String);
    },
  };
}
