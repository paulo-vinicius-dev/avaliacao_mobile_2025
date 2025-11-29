import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themePrefsKey = 'themeMode';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  Future<void> toggleTheme() async {
    ThemeMode newMode;
    if (state == ThemeMode.light || state == ThemeMode.system) {
      newMode = ThemeMode.dark;
    } else {
      newMode = ThemeMode.light;
    }
    state = newMode;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themePrefsKey, newMode.toString());
  }
}