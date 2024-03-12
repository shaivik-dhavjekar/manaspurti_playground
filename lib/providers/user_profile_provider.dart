import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileProvider extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> updateProfile(String displayName, XFile? profileImage) async {
    if (displayName.trim().isNotEmpty && user!.displayName !=  displayName.trim()) {
      try {
        await user!.updateDisplayName(displayName);
      } on FirebaseAuthException catch (e) {
        // Handle errors (e.g., show error message)
        return;
      }
    }
    if (profileImage != null) {
      try {
        final storageRef =
        FirebaseStorage.instance.ref().child('profile_images/${user!.uid}');
        await storageRef.putFile(File(profileImage.path));

        final imageUrl = await storageRef.getDownloadURL();
        user!.updatePhotoURL(imageUrl);

      } on FirebaseException catch (e) {
        print(e.message);
      }
    }

    await user!.reload();
    return;
  }
}
