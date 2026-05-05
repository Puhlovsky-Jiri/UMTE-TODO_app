import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  SettingsScreen({
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nastavení aplikace", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),

            SwitchListTile(
              title: Text("Dark mode"),
              value: isDarkMode,
              onChanged: (value) {
                toggleTheme(value);
              },
            ),

            ListTile(
              title: Text("Verze aplikace"),
              subtitle: Text("1.0.0"),
            ),
          ],
        ),
      ),
    );
  }
}