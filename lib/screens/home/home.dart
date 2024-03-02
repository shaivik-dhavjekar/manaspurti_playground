import 'package:flutter/material.dart';
import 'package:manaspurti_playground/providers/sign_out_provider.dart';
import 'package:manaspurti_playground/screens/home/about.dart';
import 'package:manaspurti_playground/screens/home/feedback.dart';
import 'package:manaspurti_playground/screens/home/profile.dart';
import 'package:manaspurti_playground/screens/home/settings.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /*
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    AboutScreen(),
    FeedbackScreen(),
    SettingsScreen(),
    ProfileScreen(),
  ];
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _tabs[_currentIndex],
      body: const Center(child: Text('Swipe Right ->')),
      drawer: DrawerMenu(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      /*
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF674FA3),
        unselectedItemColor: const Color(0xFFD0C8E2),
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          BottomNavigationBarItem(
              icon: Icon(Icons.feedback), label: 'Feedback'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
      */
    );
  }
}

class DrawerMenu extends StatelessWidget {
  final List<IconData> screenIcons = [
    Icons.settings_outlined,
    Icons.feedback_outlined,
    Icons.info_outline
  ];
  final List<String> screenTitles = ['Settings', 'Feedback', 'About'];
  final List<Widget> screens = const [
    SettingsScreen(),
    FeedbackScreen(),
    AboutScreen()
  ];

  DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignOutProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
      child: Drawer(
        backgroundColor: const Color(0xFFEFEFEF),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            children: [
              ListTile(
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_circle_outlined),
                    SizedBox(width: 10),
                    Text('Profile'),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen()));
                },
              ),
              ListTile(
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home_outlined),
                    SizedBox(width: 10),
                    Text('Home'),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              for (int i = 0; i < screenTitles.length; i++)
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(screenIcons[i]),
                      const SizedBox(width: 10),
                      Text(screenTitles[i]),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => screens[i]));
                  },
                ),
              ListTile(
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.power_settings_new_outlined),
                    SizedBox(width: 10),
                    Text('Logout'),
                  ],
                ),
                onTap: () async {
                  await provider.signOut();
                  if (provider.isSignedOut) {
                    Navigator.pushNamedAndRemoveUntil(context, '/sign_in_with_phone', (Route<dynamic> route) => false);
                  }
                },
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
