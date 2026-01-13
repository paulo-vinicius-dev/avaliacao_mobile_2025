import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _getGridKey(String? username) => username != null ? '${username}_gridLayout_columns' : 'gridLayout_columns';

final gridLayoutProvider = NotifierProvider<GridLayoutNotifier, int>(() {
  return GridLayoutNotifier(3);
});

class GridLayoutNotifier extends Notifier<int> {
  final int _initialColumns;
  String? _username;
  
  GridLayoutNotifier(this._initialColumns);

  @override
  int build() {
    return _initialColumns;
  }

  void setUsername(String? username) {
    _username = username;
  }

  Future<void> loadUserLayout(String? username) async {
    _username = username;
    final prefs = await SharedPreferences.getInstance();
    final savedColumns = prefs.getInt(_getGridKey(username)) ?? 3;
    state = savedColumns;
  }

  void toggleColumns() async {
    int newState;

    if (state >= 3) {
      newState = 1;
    } else {
      newState = state + 1;
    }
    state = newState; 
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_getGridKey(_username), newState);
  }
}