import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wallpaper_app/features/wallpaper/data/repositories/wallpaper_repository_implementation.dart';
import 'package:wallpaper_app/core/network/dio_clients.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper_app/features/wallpaper/domain/use_case/searched_wallpaper_use_case.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/bloc/wallpaper_bloc.dart';

import 'package:wallpaper_app/features/wallpaper/presentation/cubit/favorite_cubit.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/cubit/navigation_cubit.dart';
import 'package:wallpaper_app/core/config/routes/routes.dart';
import 'package:wallpaper_app/core/config/theme/theme.dart';
import 'package:wallpaper_app/core/config/theme/theme_cubit.dart';

import 'package:wallpaper_app/features/wallpaper/domain/use_case/curated_wallpaper_use_case.dart';
import 'package:wallpaper_app/features/wallpaper/data/datasources/remote_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final dio = Dio();
  final dioClients = DioClients(dio);
  final remoteDataSource = WallpaperRemoteDataSource(client: dioClients);
  final wallpaperRepository = WallpaperRepositoryImplementation(
    remote: remoteDataSource,
  );
  final wallpaperUseCase = GetCuratedWallpaperUseCase(
    repository: wallpaperRepository,
  );
  final searchedWallpaperUseCase = GetSearchedWallpaperUseCase(
    repository: wallpaperRepository,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (create) => NavigationCubit()),
        BlocProvider(create: (create) => FavoriteCubit()),
        BlocProvider(create: (create) => NavBarVisibilityCubit()),
        BlocProvider(create: (create) => AppBarVisibilityCubit()),
        BlocProvider(create: (create) => ThemeCubit()),
        BlocProvider(
          create: (create) => WallpaperBloc(
            getWallpapers: wallpaperUseCase,
            searchedWallpapers: searchedWallpaperUseCase,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Wallpaper App',
          debugShowCheckedModeBanner: false,
          theme: appLightTheme,
          darkTheme: appDarkTheme,
          themeMode: state.themeMode,
          initialRoute: AppRoutes.initial,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
