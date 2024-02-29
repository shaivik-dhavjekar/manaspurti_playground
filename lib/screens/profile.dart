import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.mode_edit_outline_outlined, size: 30,),),
          SizedBox(width: 5,)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _user?.photoURL != null ?
            CircleAvatar(
              backgroundImage: NetworkImage(_user!.photoURL!),
              radius: MediaQuery.of(context).size.width * 0.4,
            ) : Icon(Icons.account_circle, size: MediaQuery.of(context).size.width * 0.4, color: const Color(0xFF6A736B),),
          SizedBox(height: 20),
          Text(
            _user?.displayName ?? "No display name",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),
          Text(
            _user?.email ??
                (_user?.phoneNumber != null
                    ? _user!.phoneNumber!
                    : "No phone number"),
          textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
