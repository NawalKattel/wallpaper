import 'package:wallpaper_app/features/wallpaper/domain/entities/wallpaper.dart';
import 'package:wallpaper_app/features/wallpaper/domain/repositories/wallpaper_repository.dart';




class GetCuratedWallpaperUseCase {
  final WallpaperRepository repository;

  GetCuratedWallpaperUseCase({required this.repository});
  

Future<List<WallpaperEntity>> call(
  {required int page,required int perPage}
  ) {
    return repository.getCuratedWallpapers(
      page: page, perPage: perPage
      );
  }
}
  


