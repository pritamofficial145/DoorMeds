import 'package:flutter/material.dart';
import 'login_page.dart';
import 'splash_screen2.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  void goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void goToSplashScreen2(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen2()),
    );
  }

  Widget gradientButton(BuildContext context) {
    return GestureDetector(
      onTap: () => goToSplashScreen2(context),
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xff9C27E8), Color(0xff2878E8)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff745CFF).withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  Widget activeDot() {
    return Container(
      width: 22,
      height: 7,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xff9C27E8), Color(0xff2878E8)],
        ),
      ),
    );
  }

  Widget normalDot() {
    return Container(
      width: 7,
      height: 7,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget textContent() {
    return Column(
      children: [
        const Text(
          "Order Medicines Easily",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Text(
            "Choose your medicines, upload prescription, and confirm your order in just a few simple steps.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [activeDot(), normalDot(), normalDot()],
        ),
      ],
    );
  }

  Widget bottomCard(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 38, 24, 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(42),
            topRight: Radius.circular(42),
          ),
        ),
        child: Column(
          children: [
            textContent(),
            SizedBox(height: 38),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => goToLogin(context),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                gradientButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget topImage() {
    return Expanded(
      flex: 2,
      child: Container(
        width: double.infinity,
        color: const Color(0xffF7F7F9),
        child: Center(
          child: Image.asset(
            "assets/images/splash_screen1.webp",
            height: 350,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.image_not_supported_outlined,
                color: Colors.grey,
                size: 70,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F9),
      body: SafeArea(
        child: Column(children: [topImage(), bottomCard(context)]),
      ),
    );
  }
}
