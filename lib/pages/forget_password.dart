import 'package:flutter/material.dart';
import 'otp_verification.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController(
    text: "mr.pritam111@gmail.com",
  );

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void sendResetLink() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Reset OTP sent successfully"),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OtpVerification(),
      ),
    );
  }

  void goBackToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              /// Asset Image
              Center(
                child: Image.asset(
                  "assets/images/forget_password.png",
                  height: 280,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 50),

              const Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 28),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 15,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Container(
                  width: 170,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff9C27E8),
                        Color(0xff2878E8),
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: sendResetLink,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Send",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Remember your password ? ",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: goBackToLogin,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xff5B42D6),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}