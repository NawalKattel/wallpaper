import 'package:wallpaper_app/features/wallpaper/domain/entities/wallpaper.dart';

abstract class WallpaperRepository {
  Future<List<WallpaperEntity>> getSearchedWallpapers(
    String query,
    int page,
    int perPage,
  );
  Future<List<WallpaperEntity>> getCuratedWallpapers({required int page, required int perPage}
  
  );
}
