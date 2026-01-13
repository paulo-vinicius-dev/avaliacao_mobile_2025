import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:avaliacao_mobile_2025/providers/auth_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 600,
    );

    if (pickedFile == null) return;

    await ref.read(authProvider.notifier).updateProfileImage(pickedFile.path);
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeria'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Câmera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (user == null) {
      return const Center(child: Text('Usuário não autenticado'));
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Stack(
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: colors.primaryContainer,
                backgroundImage: user.profileImagePath != null
                    ? FileImage(File(user.profileImagePath!))
                    : null,
                child: user.profileImagePath == null
                    ? Icon(Icons.person, size: 80, color: colors.onPrimaryContainer)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _showImageSourceActionSheet(context),
                  child: CircleAvatar(
                    backgroundColor: colors.primary,
                    radius: 25,
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            user.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : colors.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user.email,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDark ? Colors.white70 : colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 48),
          if (user.profileImagePath != null)
            OutlinedButton.icon(
              onPressed: _removeImage,
              icon: const Icon(Icons.delete_outline),
              label: const Text('Remover Foto de Perfil'),
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.error,
                side: BorderSide(color: colors.error),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _showImageSourceActionSheet(context),
            icon: const Icon(Icons.add_a_photo),
            label: Text(user.profileImagePath == null ? 'Adicionar Foto' : 'Mudar Foto'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _removeImage() async {
    await ref.read(authProvider.notifier).updateProfileImage(null);
  }
}
