import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wallpaper_app/features/wallpaper/domain/entities/wallpaper.dart';
import 'package:wallpaper_app/features/wallpaper/domain/use_case/curated_wallpaper_use_case.dart';
import 'package:wallpaper_app/features/wallpaper/domain/use_case/searched_wallpaper_use_case.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  final GetCuratedWallpaperUseCase getWallpapers;
  final GetSearchedWallpaperUseCase searchedWallpapers;
  int currentPage = 1;
  final int perPage = 50;

  WallpaperBloc({required this.getWallpapers, required this.searchedWallpapers})
    : super(WallpaperInitial()) {
    on<LoadCuratedWallpaper>((event, emit) async {
      emit(WallpaperLoading());
      currentPage = 1;
      try {
        final wallpaper = await getWallpapers.call(
          page: currentPage,
          perPage: perPage,
        );

        emit(WallpaperLoadSuccess(wallpaper, currentPage));
      } catch (e) {
        emit(WallpaperLoadFailure(message: 'Failed to load wallpapers: $e'));
      }
    });

    on<LoadSearchedWallpaper>((event, emit) async {
      emit(WallpaperLoading());
      try {
        final wallpaper = await searchedWallpapers.call(
          query: event.query,
          page: event.page,
          perPage: event.perPage,
        );

        emit(SearchedWallpaperLoadSuccess(wallpaper, currentPage, perPage));
      } catch (e) {
        emit(WallpaperLoadFailure(message: 'Failed to load wallpapers : $e'));
      }
    });
  
  }
}
