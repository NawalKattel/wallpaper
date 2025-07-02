import 'package:wallpaper_app/core/network/dio_clients.dart';

class WallpaperRemoteDataSource {
  final DioClients client;

  WallpaperRemoteDataSource({required this.client});

  Future<List<dynamic>> getSearchedWallpapers(
    String query,
    page,
    perPage,
  ) async {
    try {
      final response = await client.get(
        'search',
        params: {'query': query, "per_page": perPage, 'page': page},
      );
      final List data = response.data['photos'];

      return data;
       
    } catch (e) {
      throw Exception('Failed to load searched Wallpaper : $e');
    }
  }

  Future<List<dynamic>> getCuratedWallpapers(
    {
    required int page,
    required int perPage,
    }
  ) async {
    try {
      final response = await client.get(
        'curated',
        params: {'page': page, 'per_page': perPage},
      );
      final List data = response.data['photos'];

      return data;
     
    } catch (e) {
      throw Exception(
        'Unexpected error while fetching wallpaper: ${e.toString()}',
      );
    }
  }
}
