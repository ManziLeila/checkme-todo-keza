import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final currentName = ref.read(userProvider);
    _nameController = TextEditingController(text: currentName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Display name'),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final newName = _nameController.text.trim();
                await ref.read(userProvider.notifier).setName(newName.isEmpty ? 'Keza' : newName);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Name saved')),
                  );
                }
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 24),
            const Text('Theme'),
            const SizedBox(height: 8),
            DropdownButton<AppThemeMode>(
              value: theme.themeMode,
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(appThemeProvider.notifier).setThemeMode(mode);
                }
              },
              items: const [
                DropdownMenuItem(value: AppThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: AppThemeMode.dark, child: Text('Dark')),
                DropdownMenuItem(value: AppThemeMode.system, child: Text('System')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
