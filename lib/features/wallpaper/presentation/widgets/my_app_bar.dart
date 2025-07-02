import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/core/config/theme/theme_cubit.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/cubit/navigation_cubit.dart';

class MyAppBAr extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBAr({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBarVisibilityCubit, bool>(
      builder: (context, visible) {
        return visible
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: AppBar(
                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                      icon: Icon(Icons.dark_mode),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}