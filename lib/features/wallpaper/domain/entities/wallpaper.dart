class WallpaperEntity {
  final int id;
  final int width;
  final int height;
  final String url;
  final String avgColor;
  final String alt;
  final String photographer;
  final String photographerUrl;
  final int photographerId;
  final WallpaperSrcEntity src;
  final bool liked;

  WallpaperEntity({
    required this.width,
    required this.height,
    required this.avgColor,
    required this.photographerId,
    required this.liked,
    required this.id,
    required this.url,
    required this.alt,
    required this.src,
    required this.photographer,
    required this.photographerUrl,
  });
}

class WallpaperSrcEntity {
  final String original;
  final String portrait;
  final String medium;

  const WallpaperSrcEntity({
    required this.original,
    required this.portrait,
    required this.medium,
  });
}
