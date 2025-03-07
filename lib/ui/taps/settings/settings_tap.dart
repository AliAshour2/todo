import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/auth_provider.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/providers/theme_provider.dart';
import 'package:todo/screens/auth/sign_up_screen.dart';

class SettingsTap extends StatelessWidget {
  const SettingsTap({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Theme Switching
          Card(
            child: SwitchListTile(
              title: const Text('Dark Mode'),
              value: themeProvider.isDark, // Bind to the current theme mode
              onChanged: (bool value) {
                // Update the theme mode based on the switch value
                themeProvider.changeThemeMode(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
              secondary: const Icon(Icons.brightness_6),
            ),
          ),
          const SizedBox(height: 16.0),

          // Language Selection
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              trailing: DropdownButton<String>(
                value: 'English', // Default language
                onChanged: (String? newValue) {
                  // Implement language change logic here
                },
                items: <String>['English', 'Spanish', 'French', 'German']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16.0),

          // Logout Button
          Card(
            child: ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Provider.of<TodoAuthProvider>(context, listen: false).logout();
                Provider.of<TasksProvider>(context, listen: false)
                    .tasks
                    .clear();
                Navigator.popAndPushNamed(context, SignUpScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
