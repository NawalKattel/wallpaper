import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/cubit/navigation_cubit.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/pages/accounts.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/pages/explorer.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/pages/home.dart';
import 'package:wallpaper_app/features/wallpaper/presentation/widgets/my_app_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static final List<Widget> pages = [
    HomePage(),
    ExplorerPage(),
    AccountsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          final direction = notification.direction;
          if (direction == ScrollDirection.reverse) {
            context.read<NavBarVisibilityCubit>().hide();
            context.read<AppBarVisibilityCubit>().hide();
          } else if (direction == ScrollDirection.forward) {
            context.read<NavBarVisibilityCubit>().show();
            context.read<AppBarVisibilityCubit>().show();
          }
        }
        return true;
      },

      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: BlocBuilder<NavigationCubit, int>(
            builder: (context, state) {
              return pages[state];
            },
          ),
          appBar: MyAppBAr(),
        
          bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
            builder: (context, selectedPage) {
              return BlocBuilder<NavBarVisibilityCubit, bool>(
                builder: (context, visible) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: visible ? 70 : 0,
                    child: NavigationBar(
                      elevation: 0,
                      destinations: [
                        NavigationDestination(
                          icon: Icon(Icons.home),
                          label: 'Home',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.search),
                          label: 'Explorer',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.person),
                          label: 'Account',
                        ),
                      ],
                      onDestinationSelected: (page) {
                        context.read<NavigationCubit>().updateIndex(page);
                      },
                      selectedIndex: selectedPage,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}


