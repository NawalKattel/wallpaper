import 'package:wallpaper_app/features/wallpaper/domain/entities/wallpaper.dart';
import 'package:wallpaper_app/features/wallpaper/domain/repositories/wallpaper_repository.dart';

class GetSearchedWallpaperUseCase {
  final WallpaperRepository repository;

  GetSearchedWallpaperUseCase({required this.repository});
  Future<List<WallpaperEntity>> call({
    required String query,
    required int page,
    required int perPage,
  }) {
    return repository.getSearchedWallpapers(query, page, perPage);
  }


}