import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:path_provider/path_provider.dart';

class SetWallpaper extends StatelessWidget {
  final String imageSource;
  const SetWallpaper({super.key, required this.imageSource});

  Future<void> setWallpaper(
    BuildContext context,
    int location,
    String label,
  ) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        imageSource,
        options: Options(responseType: ResponseType.bytes),
      );
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/wallpaper.jpg');
      await file.writeAsBytes(response.data);

      await WallpaperManagerFlutter().setWallpaper(file, location);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wallpaper set Successfully on $label screen')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error setting wallpaper')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(
        child: Text(
          'Set Wallpaper',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
      elevation: 10,
      titleTextStyle: TextStyle(),
      titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      contentPadding: EdgeInsets.all(10),
      contentTextStyle: TextStyle(),
      content: SizedBox(
        height: 220,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

                border: Border.all(
                  color: Theme.of(context).colorScheme.surfaceBright,
                ),
              ),
              child: TextButton(
                onPressed: () => setWallpaper(
                  context,
                  WallpaperManagerFlutter.homeScreen,
                  'Home',
                ),
                child: Text(
                  'Set as Home Screen ',

                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.surfaceBright,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.inverseSurface,
                  ),
                ),
              ),
            ),

            Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

                border: Border.all(
                  color: Theme.of(context).colorScheme.surfaceBright,
                ),
              ),
              child: TextButton(
                onPressed: () => setWallpaper(
                  context,
                  WallpaperManagerFlutter.lockScreen,
                  'Lock',
                ),
                child: Text(
                  'Set as Lock Screen ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.surfaceBright,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.inverseSurface,
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

                border: Border.all(
                  color: Theme.of(context).colorScheme.surfaceBright,
                ),
              ),
              child: TextButton(
                onPressed: () => setWallpaper(
                  context,
                  WallpaperManagerFlutter.bothScreens,
                  'Both',
                ),
                child: Text(
                  'Set as both Screen',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.surfaceBright,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.inverseSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
