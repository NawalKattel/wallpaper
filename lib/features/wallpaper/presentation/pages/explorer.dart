import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/cubit/favorite_cubit.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/widgets/image_tile.dart';

class ExplorerPage extends StatelessWidget {
  ExplorerPage({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      obscureText: false,
                      decoration: InputDecoration(
                        focusColor: Theme.of(
                          context,
                        ).colorScheme.inverseSurface,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                        fillColor: Theme.of(context).colorScheme.inverseSurface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Search',
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                    child: TextButton(
                      onPressed: () {
                        final search = searchController.text.trim();
                        FocusScope.of(context).unfocus();
                        if (search.isNotEmpty) {
                          context.read<WallpaperBloc>().add(
                            LoadSearchedWallpaper(
                              page: 1,
                              perPage: 50,
                              query: search,
                            ),
                          );
                        }
                      },

                      style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.surface,
                        ),
                        iconSize: WidgetStatePropertyAll(24),
                        textStyle: WidgetStatePropertyAll(
                          TextStyle(fontSize: 20),
                        ),
                      ),
                      child: Text('Search'),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<WallpaperBloc, WallpaperState>(
                builder: (context, state) {
                  if (state is WallpaperLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchedWallpaperLoadSuccess) {
                    final wallpapers = state.wallpapers;

                    return NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          context.read<WallpaperBloc>().add(LoadMoreWallpapers());
                        }
                        return false;
                      },
                      child: MasonryGridView.builder(
                        mainAxisSpacing: 13,
                        crossAxisSpacing: 13,
                        itemCount: wallpapers.length,
                        itemBuilder: (context, index) {
                          final wallpaper = wallpapers[index];

                          return ImageTile(
                            index: index,
                            extent: (index % 3) == 2 ? 350 : 250,
                            imageSource: wallpaper.src.portrait,
                            isFavorited: context.read<FavoriteCubit>().isFavorite(
                              index,
                            ),
                            onFavoriteToggle: () => context
                                .read<FavoriteCubit>()
                                .toggleFavorite(index), alt:wallpaper.alt ,
                          );
                        },

                        gridDelegate:
                            SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                      ),
                    );
                  } else if (state is WallpaperLoadFailure) {
                    return Center(child: Text(state.message));
                  }
                  return Center(child: Text('No Internet Connection'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
