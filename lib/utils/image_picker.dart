import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:smartcityfeedbacksystem/utils/snack_bar.dart';


Future<File?> pickImage(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
    await ImagePicker().pickImage (source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File (pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }
  return image;
}
