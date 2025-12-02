import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/providers/theme_provider.dart';
import 'package:avaliacao_mobile_2025/providers/auth_provider.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key, required this.onSelectedScreen});

  final void Function(String identifier) onSelectedScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final isDark = currentTheme == ThemeMode.dark;
    final authState = ref.watch(authProvider);
    
    // Capturar o notifier antes de qualquer navegação
    final authNotifier = ref.read(authProvider.notifier);

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Future<void> handleLogout() async {
      Navigator.of(context).pop(); // Fecha o drawer primeiro
      
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Logout'),
          content: const Text('Deseja realmente sair da sua conta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Confirmar'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await authNotifier.logout(); // Usa o notifier já capturado
      }
    }

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PlayLegacy',
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(
                            color: colors.onPrimaryContainer,
                            fontWeight: FontWeight.bold),
                      ),
                      if (authState.username != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Olá, ${authState.username}!',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ],
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
                fontSize: 20,
              ),
            ),
            trailing: Switch(
              value: isDark,
              onChanged: (value) {
                ref.read(themeProvider.notifier).toggleTheme();
              },
            ),
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          ListTile(
            tileColor: colors.primaryContainer.withValues(alpha: 0.8),
            leading: Icon(
              Icons.logout,
              size: 26,
              color: colors.error,
            ),
            title: Text(
              'Logout',
              style: textTheme.titleSmall!.copyWith(
                color: colors.error,
                fontSize: 24,
              ),
            ),
            onTap: handleLogout,
          ),
        ],
      ),
    );
  }
}
