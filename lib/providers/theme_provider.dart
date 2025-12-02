import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _getThemeKey(String? username) => username != null ? '${username}_themeMode' : 'themeMode';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

class ThemeNotifier extends Notifier<ThemeMode> {
  String? _username;

  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  void setUsername(String? username) {
    _username = username;
  }

  Future<void> loadUserTheme(String? username) async {
    _username = username;
    final prefs = await SharedPreferences.getInstance();
    final savedThemeString = prefs.getString(_getThemeKey(username));
    
    if (savedThemeString != null) {
      if (savedThemeString == 'ThemeMode.dark') {
        state = ThemeMode.dark;
      } else if (savedThemeString == 'ThemeMode.light') {
        state = ThemeMode.light;
      } else {
        state = ThemeMode.system;
      }
    } else {
      state = ThemeMode.system;
    }
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
    await prefs.setString(_getThemeKey(_username), newMode.toString());
  }
}