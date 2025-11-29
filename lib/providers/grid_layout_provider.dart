import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Chave para salvar
const _gridKey = 'gridLayout_columns';

//provider que guarda um número inteiro (quantidade de colunas)
final gridLayoutProvider = NotifierProvider<GridLayoutNotifier, int>(() {
  return GridLayoutNotifier(3);
});

class GridLayoutNotifier extends Notifier<int> {
  final int _initialColumns;
  GridLayoutNotifier(this._initialColumns);

  @override
  int build() {
    return _initialColumns;//Inicia com o valor que veio do disco
  }

  void toggleColumns()  async {
    int newState;

    if (state >= 3) {
      newState = 1;
    } else {
      newState = state + 1;
    }
    state = newState; //atualiza tela
    //salva no disco
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_gridKey, newState);
  }
}