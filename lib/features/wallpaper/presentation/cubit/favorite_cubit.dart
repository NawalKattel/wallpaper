import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<Set<int>> {
  FavoriteCubit() : super(<int>{});

  void toggleFavorite(int index) {
    final updated = Set<int>.from(state);
    if (updated.contains(index)) {
      updated.remove(index);
    } else {
      updated.add(index);
    }
    emit(updated);
  }

  bool isFavorite(int index) => state.contains(index);
}
