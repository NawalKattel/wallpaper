part of 'wallpaper_bloc.dart';

abstract class WallpaperEvent extends Equatable {
  const WallpaperEvent();
  @override
  List<Object> get props => [];
}

class LoadCuratedWallpaper extends WallpaperEvent {
  final int page;
  final int perPage;

  const LoadCuratedWallpaper({required this.page, required this.perPage});
  @override
  List<Object> get props => [page,perPage];
}

class LoadSearchedWallpaper extends WallpaperEvent {
  final String query;
  final int page;
  final int perPage;

  const LoadSearchedWallpaper({
    required this.query,
    required this.page,
    required this.perPage,
  });

  @override
  List<Object> get props => [query, page, perPage];
}

class LoadMoreWallpapers extends WallpaperEvent {}
