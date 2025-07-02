import 'package:wallpaper_app/features/wallpaper/data/datasources/remote_data_source.dart';
import 'package:wallpaper_app/features/wallpaper/data/models/wallpaper_model.dart';
import 'package:wallpaper_app/features/wallpaper/domain/entities/wallpaper.dart';
import 'package:wallpaper_app/features/wallpaper/domain/repositories/wallpaper_repository.dart';

class WallpaperRepositoryImplementation implements WallpaperRepository {
  final WallpaperRemoteDataSource remote;

  WallpaperRepositoryImplementation({required this.remote});
  @override
  Future<List<WallpaperEntity>> getSearchedWallpapers(
    String query,
    page,
    perPage,
  ) async {
    final List<dynamic> raw = await remote.getSearchedWallpapers(
      query,
      page,
      perPage,
    );

    return raw.map((json) => WallpaperModel.fromJson(json)).toList();
  }

  @override
  Future<List<WallpaperEntity>> getCuratedWallpapers({
    required int page,
    required int perPage,
  }) async {
    final List<dynamic> raw = await remote.getCuratedWallpapers(
      page: page,
      perPage: perPage,
    );
    return raw.map((json) => WallpaperModel.fromJson(json)).toList();
  }
}
