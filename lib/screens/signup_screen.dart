import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:avaliacao_mobile_2025/providers/auth_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedImagePath;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 600,
    );

    if (pickedFile == null) return;

    setState(() {
      _selectedImagePath = pickedFile.path;
    });
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

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final success = await ref.read(authProvider.notifier).register(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
      profileImagePath: _selectedImagePath,
    );

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao registrar. Email já pode estar em uso.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/login-background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              isDark ? Colors.black.withValues(alpha: 0.6) : Colors.black.withValues(alpha: 0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 100, left: 24, right: 24, bottom: 24),
            child: Card(
              color: colorScheme.surface.withValues(alpha: 0.9),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Avatar com ícone de câmera igual ao da tela de perfil
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: colorScheme.primaryContainer,
                            backgroundImage: _selectedImagePath != null
                                ? FileImage(File(_selectedImagePath!))
                                : null,
                            child: _selectedImagePath == null
                                ? Icon(Icons.person, size: 50, color: colorScheme.onPrimaryContainer)
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => _showImageSourceActionSheet(context),
                              child: CircleAvatar(
                                backgroundColor: colorScheme.primary,
                                radius: 18,
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nova Conta',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _nameController,
                        style: TextStyle(color: colorScheme.onSurface),
                        decoration: InputDecoration(
                          labelText: 'Nome de Usuário',
                          labelStyle: TextStyle(color: isDark ? Colors.white70 : null),
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu nome';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        style: TextStyle(color: colorScheme.onSurface),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: isDark ? Colors.white70 : null),
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return 'Por favor, insira um email válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        style: TextStyle(color: colorScheme.onSurface),
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: isDark ? Colors.white70 : null),
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'A senha deve ter pelo menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      if (_isLoading)
                        const CircularProgressIndicator()
                      else
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Registrar',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
