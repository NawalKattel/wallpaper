import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/cubit/favorite_cubit.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/widgets/wallpaper_detail.dart';

class ImageTile extends StatelessWidget {
  final String imageSource;
  final int index;
  final String alt;
  final double extent;
  final bool isFavorited;
  final VoidCallback onFavoriteToggle;

  const ImageTile({
    super.key,
    required this.imageSource,
    required this.index,
    required this.extent,
    required this.isFavorited,
    required this.onFavoriteToggle,
    required this.alt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showWallpaperDetail(context, imageSource, alt);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        height: extent,

        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(imageUrl: imageSource, fit: BoxFit.cover),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                color: Theme.of(
                  context,
                ).colorScheme.onSecondary.withOpacity(0.79),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        alt,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onInverseSurface,
                        ),
                      ),
                    ),
                    BlocBuilder<FavoriteCubit, Set<int>>(
                      builder: (context, favorites) {
                        final isFavorited = favorites.contains(index);

                        return IconButton(
                          onPressed: () => context
                              .read<FavoriteCubit>()
                              .toggleFavorite(index),
                          icon: Icon(
                            isFavorited
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined,
                            color: isFavorited
                                ? Colors.amber
                                : Theme.of(context).colorScheme.surface,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showWallpaperDetail(
    BuildContext context,
    String imageSource,
    String alt,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return WallpaperDetail(
          imageSource: imageSource,
          index: index,
          isFavorited: isFavorited,
          onFavoriteToggle: onFavoriteToggle,
          alt: alt,
        );
      },
    );
  }
}
