import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';

class LocalStorage {
  Future<File> get _favoritesFile async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/favorites.json');
  }

  Future<List<String>> readFavorites() async {
    try {
      final file = await _favoritesFile;
      if (!await file.exists()) return [];
      final content = await file.readAsString();
      return (jsonDecode(content) as List).cast<String>();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveFavorites(List<String> ids) async {
    final file = await _favoritesFile;
    await file.writeAsString(jsonEncode(ids));
  }

  Future<File> get _statusFile async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/statuses.json');
  }

  Future<Map<String, GameStatus>> readStatuses() async {
    try {
      final file = await _statusFile;
      if (!await file.exists()) return {};
      final content = await file.readAsString();
      final Map<String, dynamic> json = jsonDecode(content);

      final Map<String, GameStatus> result = {};
      json.forEach((key, value) {
        result[key] = GameStatus.values.firstWhere(
              (e) => e.name == value,
          orElse: () => GameStatus.notStarted,
        );
      });
      return result;
    } catch (_) {
      return {};
    }
  }

  Future<void> saveStatuses(Map<String, GameStatus> statuses) async {
    final file = await _statusFile;
    final Map<String, String> json = {};
    statuses.forEach((key, value) {
      if (value != GameStatus.notStarted) json[key] = value.name;
    });
    await file.writeAsString(jsonEncode(json));
  }
}