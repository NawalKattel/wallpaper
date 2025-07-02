import 'package:wallpaper_app/features/wallpaper/domain/entities/wallpaper.dart';

class WallpaperModel extends WallpaperEntity {
  WallpaperModel({
    required super.id,
    required super.url,
    required super.alt,
    required super.photographer,
    required super.photographerUrl,
    required super.src,
    required super.width,
    required super.height,
    required super.avgColor,
    required super.photographerId,
    required super.liked,
  });

  factory WallpaperModel.fromJson(Map<String, dynamic> json) {
    return WallpaperModel(
      id: json['id']?? 0,
      url: json['url']??'',
      alt: json['alt']??'',
      photographer: json['photographer']??'',
      photographerUrl: json['photographer_url']??'',
      src: WallpaperSrcModel.fromJson(json['src']??{}),
      width: json['width']??0,
      height: json['height']??0,
      avgColor:json ['avg_color']??'',
      photographerId: json['photograph_id']??0,
      liked: json['liked']??false,
    );
  }

  static List<WallpaperModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => WallpaperModel.fromJson(e)).toList();
  }
}

class WallpaperSrcModel extends WallpaperSrcEntity {
  WallpaperSrcModel({
    required super.original,
    required super.portrait,
    required super.medium,
  });

  factory WallpaperSrcModel.fromJson(Map<String, dynamic> json) {
    return WallpaperSrcModel(
      original: json['original'],
      portrait: json['portrait'],
      medium: json['medium'],
    );
  }
}
