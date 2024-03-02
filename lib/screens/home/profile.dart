import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final User? _user = FirebaseAuth.instance.currentUser;
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mode_edit_outline_outlined,
              size: 30,
            ),
          ),
          const SizedBox(width: 5)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          _user?.photoURL != null
              ? CircleAvatar(
            backgroundImage: NetworkImage(_user!.photoURL!),
            radius: MediaQuery.of(context).size.width * 0.3,
          )
              : _user?.displayName != null
              ? Container(
            alignment: Alignment.center,
            width: screenWidth * 0.3, // Adjust width as desired
            height: screenWidth * 0.3, // Adjust height as desired
            decoration: const BoxDecoration(
              color:
              Color(0xFF866FB9), // Set desired color
              shape: BoxShape.circle, // Set shape to circle
            ),
            child: Text(_user!.displayName![0].toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: screenWidth * 0.2)),
          )
              : Icon(
            Icons.account_circle,
            size: screenWidth * 0.3,
            color: const Color(0xFF6A736B),
          ),
          const SizedBox(height: 20),
          Text(
            _user?.displayName ?? "No display name",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(
            _user?.email ??
                (_user?.phoneNumber != null
                    ? _user!.phoneNumber!
                    : "No phone number"),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );;
  }
}

/*
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mode_edit_outline_outlined,
              size: 30,
            ),
          ),
          const SizedBox(width: 5)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          _user?.photoURL != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(_user!.photoURL!),
                  radius: MediaQuery.of(context).size.width * 0.3,
                )
              : _user?.displayName != null
                  ? Container(
            alignment: Alignment.center,
                      width: screenWidth * 0.3, // Adjust width as desired
                      height: screenWidth * 0.3, // Adjust height as desired
                      decoration: const BoxDecoration(
                        color:
                            Color(0xFF866FB9), // Set desired color
                        shape: BoxShape.circle, // Set shape to circle
                      ),
                      child: Text(_user!.displayName![0].toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: screenWidth * 0.2)),
                    )
                  : Icon(
                      Icons.account_circle,
                      size: screenWidth * 0.3,
                      color: const Color(0xFF6A736B),
                    ),
          const SizedBox(height: 20),
          Text(
            _user?.displayName ?? "No display name",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(
            _user?.email ??
                (_user?.phoneNumber != null
                    ? _user!.phoneNumber!
                    : "No phone number"),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
*/