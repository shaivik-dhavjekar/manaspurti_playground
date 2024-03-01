import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsListTile(
            icon: Icons.vibration_outlined,
            title: 'Sound and vibration',
            content: Column(
              children: [
                Row(
                  children: [
                    Column()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget content;

  const SettingsListTile({
    required this.icon,
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor,),
            Text(title, style: TextStyle(fontSize: 12),)
          ],
        ),
        content
      ],
    );
  }
}