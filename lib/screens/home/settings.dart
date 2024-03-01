import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Container(
                      width: MediaQuery.of(context).size.width*0.93,
                      alignment: Alignment.centerLeft,
                      child: const SettingsTextWidget(
                          title: 'App Theme', subtitle: 'Light'),
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
                Icon(icon, color: Theme.of(context).primaryColor),
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