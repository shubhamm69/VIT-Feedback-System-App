import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smartcityfeedbacksystem/models/user_model.dart';
import 'package:smartcityfeedbacksystem/provider/auth_provider.dart';
import 'package:smartcityfeedbacksystem/screens/home_screen.dart';
import 'package:smartcityfeedbacksystem/utils/image_picker.dart';
import 'package:smartcityfeedbacksystem/utils/snack_bar.dart';
import 'package:smartcityfeedbacksystem/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class userInformationScreen extends StatefulWidget {
  const userInformationScreen({Key? key}) : super(key: key);

  @override
  State<userInformationScreen> createState() => _userInformationScreenState();
}

class _userInformationScreenState extends State<userInformationScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final regnoController = TextEditingController();
  final bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    regnoController.dispose();
    bioController.dispose();
  }

  void selectImage() async {
    File? pickedImage = await pickImage(context);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 25.0,
                  horizontal: 5.0,
                ),
                child: Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => selectImage(),
                        child: image == null
                            ? const CircleAvatar(
                                backgroundColor: Colors.purple,
                                radius: 50,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(image!),
                                radius: 50,
                              ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        margin: const EdgeInsets.only(top: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              textField(
                                hintText: "Enter Your Name",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: nameController,
                              ),
                              textField(
                                hintText: "Enter Your Email",
                                icon: Icons.email,
                                inputType: TextInputType.emailAddress,
                                maxLines: 1,
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.endsWith('@vitstudent.ac.in') &&
                                      !value.endsWith('@vit.ac.in')) {
                                    return 'Sign-In with your VIT mail';
                                  }
                                  return null;
                                },
                              ),
                              textField(
                                hintText: "Enter Your Registration Number",
                                icon: Icons.tag,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: regnoController,
                                validator: (Value) {
                                  if (Value == null || Value.isEmpty) {
                                    return 'Please enter your Registration Number';
                                  }
                                  if (Value.length != 9) {
                                    return 'Please enter a valid Registration Number';
                                  }
                                  int currentYear = DateTime.now().year % 100;
                                  int yearPrefix =
                                      int.tryParse(Value.substring(0, 2)) ?? 0;

                                  if (yearPrefix > currentYear) {
                                    return 'Please enter a valid Registration Number';
                                  }

                                  int lastFourDigits =
                                      int.tryParse(Value.substring(5)) ?? 0;

                                  if (lastFourDigits < 1000 ||
                                      lastFourDigits > 9999) {
                                    return 'Please enter a valid Registration Number';
                                  }
                                  return null;
                                },
                              ),
                              textField(
                                hintText: "Enter Your Bio",
                                icon: Icons.edit,
                                inputType: TextInputType.name,
                                maxLines: 2,
                                controller: bioController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomButton(
                          text: "Create",
                          onPressed: () => storeData(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget textField({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.purple,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
        validator: validator,
      ),
    );
  }

  // store data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    if (_formKey.currentState?.validate() ?? false) {
      UserModel userModel = UserModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        regno: regnoController.text.trim(),
        bio: bioController.text.trim(),
        profilePic: "",
        createdAt: "",
        phoneNumber: "",
        uid: "",
      );
      if (image != null) {
        ap.saveUserToFirebase(
          context: context,
          userModel: userModel,
          profilePic: image!,
          onSuccess: () {
            // Once data is saved, we need to store it locally also
            ap.saveUserDataToSP().then(
                  (value) => ap.setSignIn().then(
                        (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false,
                        ),
                      ),
                );
          },
        );
      } else {
        showSnackBar(context, "Please upload Profile Photo");
      }
    }
  }
}
