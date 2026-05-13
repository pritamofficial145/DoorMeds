import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> createAccount() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showMessage("Please fill all fields");
      return;
    }

    if (!email.contains("@")) {
      showMessage("Please enter valid email address");
      return;
    }

    if (phone.length != 10) {
      showMessage("Phone number must be 10 digits");
      return;
    }

    if (password.length < 8) {
      showMessage("Password must be at least 8 characters");
      return;
    }

    if (password != confirmPassword) {
      showMessage("Password and confirm password must be same");
      return;
    }

    try {
      final url = Uri.parse(
        "http://10.0.2.2/doormed/backend_api/customer_api/register.php",
      );

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        showSuccessPopup();
      } else {
        showMessage(data["message"] ?? "Registration failed");
      }
    } catch (e) {
      showMessage("Something went wrong. Please try again.");
    }
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

  void goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void showSuccessPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.25),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 35),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 86,
                  height: 86,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xff9C27E8), Color(0xff2878E8)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 54,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Account Created\nSuccessfully !!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Now login with your email and password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  width: 170,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(
                      colors: [Color(0xff9C27E8), Color(0xff2878E8)],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: goToLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text(
                      "Go to Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget inputField({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff9A9A9A), fontSize: 14),
          prefixIcon: Icon(icon, color: Colors.black),
          filled: true,
          fillColor: const Color(0xffF1F1F1),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget passwordField({
    required String hintText,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        controller: controller,
        obscureText: !isVisible,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff9A9A9A), fontSize: 14),
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
          suffixIcon: IconButton(
            icon: Icon(
              isVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.black,
              size: 20,
            ),
            onPressed: onTap,
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
    );
  }

  Widget socialIcon(String imagePath) {
    return Image.asset(
      imagePath,
      height: 30,
      width: 30,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.image_not_supported_outlined,
          color: Colors.grey,
          size: 30,
        );
      },
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
                const SizedBox(height: 16),

                Image.asset(
                  "assets/images/login.png",
                  height: size.height * 0.32,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 8),

                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Join us and get medicines delivered with care",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Color(0xff222222)),
                ),

                const SizedBox(height: 22),

                inputField(
                  hintText: "Full Name",
                  icon: Icons.person_outline,
                  controller: nameController,
                ),

                const SizedBox(height: 12),

                inputField(
                  hintText: "Email Address",
                  icon: Icons.email_outlined,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 12),

                inputField(
                  hintText: "Phone Number",
                  icon: Icons.phone_outlined,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 12),

                passwordField(
                  hintText: "Password",
                  controller: passwordController,
                  isVisible: isPasswordVisible,
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),

                const SizedBox(height: 12),

                passwordField(
                  hintText: "Confirm Password",
                  controller: confirmPasswordController,
                  isVisible: isConfirmPasswordVisible,
                  onTap: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.info_outline,
                        size: 15,
                        color: Color(0xff745CFF),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "Password must be at least 8 characters.",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff666666),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  width: 190,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0xff9C27E8), Color(0xff2878E8)],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

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
                    socialIcon("assets/images/google_icon.webp"),
                    const SizedBox(width: 25),
                    socialIcon("assets/images/facebook_icon.webp"),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account ? ",
                      style: TextStyle(fontSize: 11, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: goToLogin,
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

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
