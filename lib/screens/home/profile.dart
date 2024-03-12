import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/user_profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileEditScreen()));
            },
            icon: const Icon(
              Icons.mode_edit_outline_outlined,
              size: 30,
            ),
          ),
          const SizedBox(width: 5)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            user?.photoURL != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: SizedBox(
                      width: screenWidth * 0.3,
                      height: screenWidth * 0.3,
                      child: Image.network(
                        user!.photoURL!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : user?.displayName != null
                    ? Container(
                        alignment: Alignment.center,
                        width: screenWidth * 0.3,
                        height: screenWidth * 0.3,
                        decoration: const BoxDecoration(
                          color: Color(0xFF866FB9),
                          shape: BoxShape.circle,
                        ),
                        child: Text(user!.displayName![0].toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: screenWidth * 0.2)),
                      )
                    : Icon(
                        Icons.account_circle,
                        size: screenWidth * 0.3,
                        color: const Color(0xFF6A736B),
                      ),
            const SizedBox(height: 20),
            Text(
              user?.displayName ?? "No display name",
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.rubik(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Text(
              user?.email ??
                  (user?.phoneNumber != null
                      ? user!.phoneNumber!
                      : "No phone number"),
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  color: Color(0xFF909090),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
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

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final imagePicker = ImagePicker();
  XFile? _pickedImage;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _displayNameController.text = user!.displayName ?? "";
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Container(
        height: 100,
        color: Colors.grey.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text('Camera'),
              onPressed: () async {
                final image = await imagePicker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  setState(() {
                    _pickedImage = image;
                  });
                  Navigator.pop(context);
                }
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.photo_library),
              label: Text('Gallery'),
              onPressed: () async {
                final image = await imagePicker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    _pickedImage = image;
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<UserProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: screenWidth * 0.4,
                height: screenWidth * 0.4,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _pickedImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.file(
                              File(_pickedImage!.path),
                              width: screenWidth * 0.4,
                              height: screenWidth * 0.4,
                              fit: BoxFit.cover,
                            ),
                        )
                        : user?.photoURL != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: SizedBox(
                                  width: screenWidth * 0.4,
                                  height: screenWidth * 0.4,
                                  child: Image.network(
                                    user!.photoURL!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                width: screenWidth * 0.4,
                                height: screenWidth * 0.4,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF866FB9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                    _pickedImage != null || user?.photoURL != null ? Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const Icon(Icons.mode_edit_outline_outlined),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _showBottomSheet(context);
                        },
                        padding: EdgeInsets.zero,
                        iconSize: 24.0,
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF866FB9)),
                          foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    50.0)
                            ),
                          ),
                        ),
                      ),
                    ) : GestureDetector(
                      onTap: () => _showBottomSheet(context),
                      child: Icon(Icons.add_a_photo_outlined,
                          size: screenWidth * 0.1, color: Colors.white),
                    )
                  ],
                ),
              ),
              TextFormField(
                controller: _displayNameController,
                decoration: InputDecoration(labelText: 'Display Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await provider.updateProfile(
                        _displayNameController.text.toString(), _pickedImage);
                  }
                  Navigator.pop(context);
                },
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _pickImage() async {
  //   try {
  //     final XFile? pickedImageFile =
  //         await imagePicker.pickImage(source: ImageSource.gallery);
  //     setState(() {
  //       _pickedImage = pickedImageFile;
  //     });
  //   } catch (err) {
  //     print(err);
  //   }
  // }
}
