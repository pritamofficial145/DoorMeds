import 'dart:async';
import 'package:flutter/material.dart';
import 'reset_password.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();

  Timer? resendTimer;
  int remainingSeconds = 0;

  bool get isTimerRunning => remainingSeconds > 0;

  @override
  void dispose() {
    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();
    resendTimer?.cancel();
    super.dispose();
  }

  void goToResetPassword() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ResetPasswordPage(),
      ),
    );
  }

  void startResendTimer() {
    if (isTimerRunning) return;

    setState(() {
      remainingSeconds = 60;
    });

    resendTimer?.cancel();

    resendTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainingSeconds == 0) {
          timer.cancel();
        } else {
          setState(() {
            remainingSeconds--;
          });
        }
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("OTP resent successfully"),
        backgroundColor: Color(0xff745CFF),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Widget otpBox(TextEditingController controller) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        cursorColor: Colors.black,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Color(0xff7C3AED),
              width: 1.4,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  String timerText() {
    final int minutes = remainingSeconds ~/ 60;
    final int seconds = remainingSeconds % 60;

    return "$minutes:${seconds.toString().padLeft(2, '0')}";
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

              Center(
                child: Image.asset(
                  "assets/images/otp.png",
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 35),

              const Text(
                "OTP verification",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Enter the OTP sent to mr.pritam111@gmail.com",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  otpBox(otp1),
                  const SizedBox(width: 14),
                  otpBox(otp2),
                  const SizedBox(width: 14),
                  otpBox(otp3),
                  const SizedBox(width: 14),
                  otpBox(otp4),
                ],
              ),

              const SizedBox(height: 22),

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
                    onPressed: goToResetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Submit",
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
                    "Didn’t receive the OTP ? ",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),

                  GestureDetector(
                    onTap: isTimerRunning ? null : startResendTimer,
                    child: Text(
                      isTimerRunning
                          ? "Resend in ${timerText()}"
                          : "Resend",
                      style: TextStyle(
                        fontSize: 11,
                        color: isTimerRunning ? Colors.grey : Colors.red,
                        fontWeight: FontWeight.bold,
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