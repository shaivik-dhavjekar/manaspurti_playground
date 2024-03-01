import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double dividerHeight = 12;

    return Scaffold(
      appBar: AppBar(
        title: const Text(('About')),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.93,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AboutListTile(
                title: 'Info',
                content: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 15),
                            child: Image.asset(
                              'assets/poker360Logo-circle.png',
                              width: 25,
                            ),
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('GetRide',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500)),
                              Text(
                                'v 8.3.2.',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Some Text',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: dividerHeight),
              const AboutListTile(
                  title: 'Links',
                  content: Column(
                    children: [
                      LinksListTile(icon: Icons.email_outlined, link: 'Email'),
                      Divider(height: 1),
                      LinksListTile(
                          icon: Icons.language_outlined, link: 'Website'),
                      Divider(height: 1),
                      LinksListTile(icon: Icons.shop, link: 'Google Play Store')
                    ],
                  )),
              const SizedBox(height: dividerHeight),
              AboutListTile(
                title: 'Developer',
                content: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: Image.asset(
                              'assets/poker360Logo-circle.png',
                              width: 25,
                            ),
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('GetRide', style: TextStyle(fontSize: 16)),
                              Text(
                                'Some Text',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Icon>[
                            Icon(Icons.contact_mail_outlined, size: 20),
                            Icon(Icons.contact_phone_outlined, size: 20),
                            Icon(Icons.language_outlined, size: 20),
                            Icon(Icons.store_outlined, size: 20),
                            Icon(Icons.poll_outlined, size: 20)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: dividerHeight),
              const AboutListTile(
                title: 'Open source licenses',
                content: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('All open source licences'),
                          Text(
                            'Lists all the open source licences used in this app',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Icon(Icons.launch_outlined)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: dividerHeight),
              const AboutListTile(
                title: 'Policy',
                content: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Terms of Use'),
                      Text(
                        'Last Updated: Jan2024',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutListTile extends StatelessWidget {
  final String title;
  final Widget content;

  const AboutListTile({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xFFEFEFEF),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 4),
                          blurRadius: 4),
                    ]),
                child: content,
              )
            ],
          )
        ],
      ),
    );
  }
}

class LinksListTile extends StatelessWidget {
  final IconData icon;
  final String link;

  const LinksListTile({super.key, required this.icon, required this.link});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            link,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
