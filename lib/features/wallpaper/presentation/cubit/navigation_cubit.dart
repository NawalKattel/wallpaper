import 'package:bloc/bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void updateIndex(int index) => emit(index);
}

class NavBarVisibilityCubit extends Cubit<bool> {
  NavBarVisibilityCubit() : super(true);

  void hide() => emit(false);

  void show() => emit(true);
}


class AppBarVisibilityCubit extends Cubit<bool> {
  AppBarVisibilityCubit() : super(true);

  void hide() => emit(false);

  void show() => emit(true);
}
