import 'package:flutter_riverpod/flutter_riverpod.dart';

//provider que guarda um número inteiro (quantidade de colunas)
final gridLayoutProvider = NotifierProvider<GridLayoutNotifier, int>(() {
  return GridLayoutNotifier();
});

class GridLayoutNotifier extends Notifier<int> {
  @override
  int build() {
    return 3;
  }

  void toggleColumns() {
    if (state >= 3) {
      state = 1;
    } else {
      state = state + 1;
    }
  }
}