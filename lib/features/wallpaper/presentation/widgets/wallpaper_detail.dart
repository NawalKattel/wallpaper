import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/cubit/favorite_cubit.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/widgets/set_wallpaper.dart';

class WallpaperDetail extends StatelessWidget {
  final String imageSource;
  final int index;
  final String alt;
  final bool isFavorited;
  final VoidCallback onFavoriteToggle;
  const WallpaperDetail({
    super.key,
    required this.imageSource,
    required this.index,
    required this.alt,
    required this.isFavorited,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.95,
      widthFactor: 1,
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: imageSource, fit: BoxFit.fill),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    alt,
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      context.read<FavoriteCubit>().toggleFavorite(index),
                  icon: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: isFavorited
                      ? Colors.amber
                      : Theme.of(context).colorScheme.surface,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          MaterialButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => SetWallpaper(imageSource: imageSource),
            ),

            color: Theme.of(context).colorScheme.inverseSurface,
            textColor: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Get Wallpaper',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/preview',arguments: imageSource);
            },

            color: Theme.of(context).colorScheme.inverseSurface,
            textColor: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Preview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
