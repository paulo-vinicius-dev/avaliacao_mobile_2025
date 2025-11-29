import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/providers/theme_provider.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key, required this.onSelectedScreen});

  final void Function(String identifier) onSelectedScreen;

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final isDark = currentTheme == ThemeMode.dark;

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.primaryContainer,
                  colors.primaryContainer.withValues(alpha: 0.8)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.videogame_asset_rounded,
                  size: 48,
                  color: colors.onPrimaryContainer,
                ),
                const SizedBox(width: 15),
                Text(
                  'PlayLegacy',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            tileColor: colors.primaryContainer.withValues(alpha: 0.8),
            leading: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              size: 26,
              color: colors.onSurface,
            ),
            title: Text(
              'Modo Escuro',
              style: textTheme.titleSmall!.copyWith(
                color: colors.onSurface,
                fontSize: 18,
              ),
            ),
            trailing: Switch(
              value: isDark,
              onChanged: (value) {
                ref.read(themeProvider.notifier).toggleTheme();
              },
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            tileColor: colors.primaryContainer.withValues(alpha: 0.8),
            leading: Icon(
              Icons.info_outline,
              size: 26,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Sobre',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
              ),
            ),
            onTap: () {
              onSelectedScreen('sobre');
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
