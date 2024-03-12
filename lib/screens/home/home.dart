import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manaspurti_playground/providers/sign_out_provider.dart';
import 'package:manaspurti_playground/screens/home/about.dart';
import 'package:manaspurti_playground/screens/home/feedback.dart';
import 'package:manaspurti_playground/screens/home/profile.dart';
import 'package:manaspurti_playground/screens/home/settings.dart';
import 'package:provider/provider.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 500 && constraints.maxHeight > 600) {
        return Scaffold(
          body: Row(
            children: [
              SizedBox(
                width: 240,
                child: AppMenu(),
              ),
              const VerticalDivider(width: 0.5, color: Colors.black),
              const Expanded(
                child: HomeScreen(),
              ),
            ],
          ),
        );
      } else {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text('Normal'),
          // ),
          body: const HomeScreen(),
          drawer: DrawerMenu(),
          drawerEdgeDragWidth: MediaQuery.of(context).size.width,
        );
      }
    });
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    Sessions(),
    Players(),
    Casinos(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, -4),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFF0EDF6),
          selectedItemColor: const Color(0xFF262626),
          unselectedItemColor: const Color(0xFF262626),
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.window_outlined), label: 'Sessions'),
            BottomNavigationBarItem(
                icon: Icon(Icons.group_outlined), label: 'Players'),
            BottomNavigationBarItem(
                icon: Icon(Icons.casino_outlined), label: 'Casinos'),
          ],
        ),
      ),
    );
  }
}

class Sessions extends StatelessWidget {
  const Sessions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('SESSIONS'),
    );
  }
}

class Players extends StatelessWidget {
  const Players({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('PLAYERS'),
    );
  }
}

class Casinos extends StatelessWidget {
  const Casinos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('CASINOS'),
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
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(4, 4),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Drawer(
          width: MediaQuery.of(context).size.width * 0.58,
          backgroundColor: const Color(0xFFEFEFEF),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              children: [
                GestureDetector(child: DrawerProfileTab(),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen()));
                },
                ),
                DrawerListTile(
                    screenTitle: 'Home',
                    screenIcon: Icons.home_outlined,
                    onTap: () {
                      Navigator.pop(context);
                    }),
                const Divider(),
                for (int i = 0; i < screenTitles.length; i++)
                  DrawerListTile(
                      screenTitle: screenTitles[i],
                      screenIcon: screenIcons[i],
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => screens[i]));
                      }),
                DrawerListTile(
                    screenTitle: 'Logout',
                    screenIcon: Icons.power_settings_new_outlined,
                    onTap: () async {
                      await provider.signOut(context: context);
                      if (provider.isSignedOut) {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/sign_in_with_phone',
                            (Route<dynamic> route) => false);
                      }
                    }),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppMenu extends StatelessWidget {
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

  AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignOutProvider>(context);
    return Container(
      color: const Color(0xFFEFEFEF),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [
            GestureDetector(
              child: DrawerProfileTab(),
              onTap: () {},
            ),
            DrawerListTile(
                screenTitle: 'Home',
                screenIcon: Icons.home_outlined,
                onTap: () {}),
            const Divider(),
            for (int i = 0; i < screenTitles.length; i++)
              DrawerListTile(
                  screenTitle: screenTitles[i],
                  screenIcon: screenIcons[i],
                  onTap: () {}),
            DrawerListTile(
                screenTitle: 'Logout',
                screenIcon: Icons.power_settings_new_outlined,
                onTap: () async {
                  await provider.signOut(context: context);
                  if (provider.isSignedOut) {
                    Navigator.pushNamedAndRemoveUntil(context,
                        '/sign_in_with_phone', (Route<dynamic> route) => false);
                  }
                }),
            const Spacer()
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData screenIcon;
  final String screenTitle;
  final Function() onTap;

  const DrawerListTile(
      {super.key,
      required this.screenTitle,
      required this.screenIcon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(screenTitle, style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w400),),
      leading: Icon(screenIcon, size: 24,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      onTap: onTap,
    );
  }
}

class DrawerProfileTab extends StatelessWidget {
  final User? _user = FirebaseAuth.instance.currentUser;
  DrawerProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white.withOpacity(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: _user?.photoURL != null
                ? CircleAvatar(
              backgroundImage: NetworkImage(_user!.photoURL!),
              radius: 25,
            )
                : _user?.displayName != null
                ? Container(
              alignment: Alignment.center,
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color:
                Color(0xFF866FB9),
                shape: BoxShape.circle,
              ),
              child: Text(_user!.displayName![0].toUpperCase(), style: GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24)),
            )
                : const Icon(
              Icons.account_circle,
              size: 50,
              color: Color(0xFF6A736B),
            ),
          ),
          SizedBox(height: 10),
          Text(
            _user?.displayName ?? "No display name",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Text(
            _user?.email ??
                (_user?.phoneNumber != null
                    ? _user!.phoneNumber!
                    : "No phone number"),
            style: GoogleFonts.rubik(color: Color(0xFF909090), fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
