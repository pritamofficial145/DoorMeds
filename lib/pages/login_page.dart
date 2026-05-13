import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'forget_password.dart';
import 'create_account.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xff745CFF),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> loginUser() async {
    String input = emailController.text.trim();
    String password = passwordController.text.trim();

    if (input.isEmpty || password.isEmpty) {
      showMessage("Please fill all fields");
      return;
    }

    if (password.length < 8) {
      showMessage("Password must be at least 8 characters");
      return;
    }

    try {
      final url = Uri.parse(
        "http://10.0.2.2/doormed/backend_api/customer_api/login.php",
      );

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"input": input, "password": password}),
      );

      if (response.statusCode != 200) {
        showMessage("Server error: ${response.statusCode}");
        return;
      }

      final data = jsonDecode(response.body);

      if (data["success"] == true && data["customer"] != null) {
        final user = UserModel.fromJson(data["customer"]);
        Provider.of<UserProvider>(context, listen: false).setUser(user);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
      } else {
        showMessage(data["message"] ?? "Login failed");
      }
    } catch (e) {
      showMessage("Something went wrong. Please try again.");
    }
  }

  void forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
    );
  }

  void goToCreateAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateAccountPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            child: Column(
              children: [
                const SizedBox(height: 20),

                Image.asset(
                  "assets/images/login.png",
                  height: size.height * 0.45,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 10),

                const Text(
                  "welcome Back",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Your medicines, delivered with care and trust",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Color(0xff222222)),
                ),

                const SizedBox(height: 22),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      hintStyle: const TextStyle(
                        color: Color(0xff9A9A9A),
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor: const Color(0xffF1F1F1),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: TextField(
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: const TextStyle(
                        color: Color(0xff9A9A9A),
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: const Color(0xffF1F1F1),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 35),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: forgotPassword,
                      child: const Text(
                        "Forgot Password ?",
                        style: TextStyle(color: Colors.black, fontSize: 11),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                Container(
                  width: 175,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0xff9C27E8), Color(0xff2878E8)],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 17),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 53),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(color: Colors.black54, thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("or", style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        child: Divider(color: Colors.black54, thickness: 1),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/google_icon.webp",
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(width: 25),
                    Image.asset(
                      "assets/images/facebook_icon.webp",
                      height: 30,
                      width: 30,
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t have an account ? ",
                      style: TextStyle(fontSize: 11, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: goToCreateAccount,
                      child: const Text(
                        "Create account",
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

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
