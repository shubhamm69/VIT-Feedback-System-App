import 'package:flutter/material.dart';
import 'package:smartcityfeedbacksystem/provider/auth_provider.dart';
import 'package:smartcityfeedbacksystem/screens/home_screen.dart';
import 'package:smartcityfeedbacksystem/screens/registration_screen.dart';
import 'package:smartcityfeedbacksystem/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/register.png",
                  height: 300,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Let's Get Started",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Never a better time than now to start",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: () {
                      ap.isSignedIn == true // when true then fetch, shared preference data
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(),
                              ),
                            )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RegisterScreen(key: UniqueKey()),
                              ),
                            );
                    },
                    text: "Get Started",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
