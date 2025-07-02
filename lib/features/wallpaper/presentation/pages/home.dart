import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/cubit/favorite_cubit.dart';

import 'package:wallpaper_app/features/wallpaper/presentation/widgets/image_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WallpaperBloc>().add(LoadCuratedWallpaper(page: 1, perPage: 30));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                labelColor: Colors.teal,
                indicatorColor: Colors.tealAccent,
                indicatorAnimation: TabIndicatorAnimation.elastic,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(text: 'Suggested'),
                  Tab(text: 'favorite'),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: [
                    BlocBuilder<WallpaperBloc, WallpaperState>(
                      builder: (context, state) {
                        if (state is WallpaperLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (state is WallpaperLoadSuccess) {
                          final wallpapers = state.wallpapers;
                          return MasonryGridView.builder(
                            mainAxisSpacing: 13,
                            crossAxisSpacing: 13,
                            itemCount: wallpapers.length,
                            itemBuilder: (context, index) {
                              final wallpaper = wallpapers[index];

                              return ImageTile(
                                index: index,
                                extent: (index % 3) == 2 ? 350 : 250,
                                imageSource: wallpaper.src.portrait,

                                isFavorited: context
                                    .read<FavoriteCubit>()
                                    .state
                                    .contains(index),
                                onFavoriteToggle: () => context
                                    .read<FavoriteCubit>()
                                    .toggleFavorite(index), alt: wallpaper.alt,
                              );
                            },
                            gridDelegate:
                                SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                          );
                        } else if (state is WallpaperLoadFailure) {
                          return Center(child: Text('No Internet Connection'));
                        }
                        return const Center(
                          child: Text('No wallpapers found.'),
                        );
                      },
                    ),

                    BlocBuilder<WallpaperBloc, WallpaperState>(
                      builder: (context, state) {
                        final favList = context
                            .read<FavoriteCubit>()
                            .state
                            .toList();
                        final wallpaperState = context
                            .read<WallpaperBloc>()
                            .state;
                        if (wallpaperState is! WallpaperLoadSuccess) {
                          return const Center(
                            child: Text('no Favorite wallpaper '),
                          );
                        }
                        final wallpapers = wallpaperState.wallpapers;
                        return MasonryGridView.builder(
                          itemCount: favList.length,
                          mainAxisSpacing: 13,
                          crossAxisSpacing: 13,
                          itemBuilder: (context, i) {
                            final index = favList[i];

                            return ImageTile(
                              index: index,

                              extent: (index % 3) == 2 ? 350 : 250,
                              imageSource: wallpapers[index].src.portrait,
                              isFavorited: true,
                              onFavoriteToggle: () => context
                                  .read<FavoriteCubit>()
                                  .toggleFavorite(index), alt: wallpapers[index].alt,
                            );
                          },
                          gridDelegate:
                              SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
