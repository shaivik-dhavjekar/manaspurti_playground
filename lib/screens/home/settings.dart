import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void showThemeMenu(BuildContext context, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Constrain content size
            children: [
              TextButton(
                onPressed: () {
                  themeProvider.setThemeMode(ThemeMode.light);
                  Navigator.pop(context);
                },
                child: Text('Light'),
              ),
              TextButton(
                onPressed: () {
                  themeProvider.setThemeMode(ThemeMode.dark);
                  Navigator.pop(context);
                },
                child: Text('Dark'),
              ),
              TextButton(
                onPressed: () {
                  themeProvider.setThemeMode(ThemeMode.system);
                  Navigator.pop(context);
                },
                child: Text('System'),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SettingsListTile(
                icon: Icons.palette_outlined,
                title: 'Customization',
                content: Column(
                  children: [
                    // DropdownButton<ThemeMode>(
                    //   value: themeProvider.themeMode,
                    //   items: [
                    //     DropdownMenuItem(
                    //       value: ThemeMode.light,
                    //       child: Text('Light'),
                    //     ),
                    //     DropdownMenuItem(
                    //       value: ThemeMode.dark,
                    //       child: Text('Dark'),
                    //     ),
                    //     DropdownMenuItem(
                    //       value: ThemeMode.system,
                    //       child: Text('System'),
                    //     ),
                    //   ],
                    //   onChanged: (themeMode) {
                    //     themeProvider.setThemeMode(themeMode!);
                    //   },
                    // ),
                    GestureDetector(
                      // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SetAppTheme())),
                      onTap: () => showThemeMenu(context, themeProvider),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.93,
                        color: Colors.white.withOpacity(0),
                        alignment: Alignment.centerLeft,
                        child: SettingsTextWidget(
                            title: 'App Theme', subtitle: themeProvider.getAppTheme()),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width*0.93,
                      alignment: Alignment.centerLeft,
                      child: const SettingsTextWidget(
                          title: 'Accent color', subtitle: 'System default'),
                    )
                  ],
                )),
            const Divider(),
            SettingsListTile(
              icon: Icons.vibration_outlined,
              title: 'Sound and vibration',
              content: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SettingsTextWidget(
                          title: 'Sound', subtitle: 'No use of sound effects'),
                      VibrationControl(isVibrationEnabled: true, onChanged: (value) {})
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SettingsTextWidget(
                          title: 'Vibration', subtitle: 'Allow use of vibrations for feedback and alerts'),
                      SoundControl(isSoundEnabled: false, onChanged: (value) {})
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
           SettingsListTile(
                icon: Icons.menu,
                title: 'App backend',
                content: Container(
                  width: MediaQuery.of(context).size.width*0.93,
                  alignment: Alignment.centerLeft,
                  child: const SettingsTextWidget(
                      title: 'Switch app backend', subtitle: 'Production'),
                )),
            const Divider(),
            SettingsListTile(
                icon: Icons.more_outlined,
                title: 'Other',
                content: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.93,
                      alignment: Alignment.centerLeft,
                      child: const SettingsTextWidget(
                          title: 'Rate this app', subtitle: 'We deeply value your feedback'),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width*0.93,
                      alignment: Alignment.centerLeft,
                      child: const SettingsTextWidget(
                          title: 'About', subtitle: 'Version 8.3.2'),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class SettingsTextWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const SettingsTextWidget(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Text(subtitle,
            style: const TextStyle(fontSize: 12, color: Color(0xFF5A5A5A))),
      ],
    );
  }
}

class SoundControl extends StatefulWidget {
  final bool isSoundEnabled;
  final ValueChanged<bool> onChanged;

  const SoundControl({
    super.key,
    required this.isSoundEnabled,
    required this.onChanged,
  });

  @override
  State<SoundControl> createState() => _SoundControlState();
}

class _SoundControlState extends State<SoundControl> {
  @override
  Widget build(BuildContext context) {
    return CustomSwitch(
        value: widget.isSoundEnabled,
        onChanged: (value) {
          setState(() {
            widget.onChanged(value);
          });
        });
  }
}

class VibrationControl extends StatefulWidget {
  final bool isVibrationEnabled;
  final ValueChanged<bool> onChanged;

  const VibrationControl({
    super.key,
    required this.isVibrationEnabled,
    required this.onChanged,
  });

  @override
  State<VibrationControl> createState() => _VibrationControlState();
}

class _VibrationControlState extends State<VibrationControl> {
  @override
  Widget build(BuildContext context) {
    return CustomSwitch(
        value: widget.isVibrationEnabled,
        onChanged: (value) {
          setState(() => widget.onChanged(value));
        });
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF64B57E),
      activeThumbImage: const AssetImage('assets/check.png'),
      activeTrackColor: const Color(0xFF376445),
      inactiveThumbColor: const Color(0xFF1D1B20),
      inactiveThumbImage: const AssetImage('assets/close.png'),
      inactiveTrackColor: const Color(0xFFE6E0E9),
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
    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.secondary),
                const SizedBox(width: 25),
                Text(
                  title,
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
            const SizedBox(height: 15),
            content
          ],
        ),
      ),
    );
  }
}


class SetAppTheme extends StatelessWidget {
  const SetAppTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    themeProvider.setThemeMode(ThemeMode.light);
                    Navigator.pop(context);
                  },
                  child: Text('Light'),
                ),
                TextButton(
                  onPressed: () {
                    themeProvider.setThemeMode(ThemeMode.dark);
                    Navigator.pop(context);
                  },
                  child: Text('Dark'),
                ),
                TextButton(
                  onPressed: () {
                    themeProvider.setThemeMode(ThemeMode.system);
                    Navigator.pop(context);
                  },
                  child: Text('System'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
