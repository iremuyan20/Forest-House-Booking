import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housebookingapp/components/custom_button.dart';
import 'package:housebookingapp/components/custom_textfield.dart';


class RegisterPage extends StatefulWidget {
final void Function()? onTap;

 const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
final TextEditingController usernameController = TextEditingController();

final TextEditingController emailController = TextEditingController();

final TextEditingController passwordController = TextEditingController();

final TextEditingController confirmController = TextEditingController();

void registerUser() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  if (passwordController.text != confirmController.text) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Passwords don't match!"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
    return;
  }

  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    Navigator.pop(context);



  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);

    String errorMessage;


    if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password provided.';
    } else if (e.code == 'invalid-email') {
      errorMessage = 'The email address is not valid.';
    } else if (e.code == 'user-disabled') {
      errorMessage = 'This user has been disabled.';
    } else {

      errorMessage = "An unexpected error occurred.";
    }


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}




@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(height: 20,),
                const Text(
                  "IYU HOUSE BOOKING",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 35,),
            
                CustomTextField(
                  hintText: "User name",
                  obscureText: false,
                  controller: usernameController,),
            
                const SizedBox(height: 10,),
                CustomTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,),
            
                const SizedBox(height: 10,),
            
                CustomTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,),
            
                const SizedBox(height: 10,),
            
                CustomTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmController,),
            
                const SizedBox(height: 10,),

                const SizedBox(height: 20,),
                CustomButton(
                    text: "Register",
                    onTap: registerUser),
            
                const SizedBox(height: 20,),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(" Login here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
