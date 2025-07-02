part of 'wallpaper_bloc.dart';

abstract class WallpaperState extends Equatable {
  const WallpaperState();

  @override
  List<Object?> get props => [];
}

class WallpaperInitial extends WallpaperState {}

class WallpaperLoading extends WallpaperState {}

class WallpaperLoadSuccess extends WallpaperState {
  final List<WallpaperEntity> wallpapers;
  final int page;


  const WallpaperLoadSuccess(this.wallpapers, this.page);

  @override
  List<Object> get props => [wallpapers];
}
class SearchedWallpaperLoadSuccess extends WallpaperState {
  final List<WallpaperEntity> wallpapers;
  final int page;
  final int perPage;


  const SearchedWallpaperLoadSuccess(this.wallpapers, this.page, this.perPage);

  @override
  List<Object> get props => [wallpapers];
}

class WallpaperLoadFailure extends WallpaperState {
  final String message;

  const WallpaperLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
