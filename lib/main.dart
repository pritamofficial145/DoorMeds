import 'package:app_new/pages/order_summery.dart';
import 'package:app_new/pages/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';

import 'package:app_new/pages/splash_screen.dart';
import 'package:app_new/pages/splash_screen1.dart';
import 'package:app_new/pages/splash_screen2.dart';
import 'package:app_new/pages/splash_screen3.dart';
import 'package:app_new/pages/login_page.dart';
import 'package:app_new/pages/home_page.dart';
import 'package:app_new/pages/forget_password.dart';
import 'package:app_new/pages/otp_verification.dart';
import 'package:app_new/pages/cart_screen.dart';
import 'package:app_new/pages/wish_list.dart';
import 'package:app_new/pages/profile_screen.dart';
import 'package:app_new/pages/item_details.dart';
import 'package:app_new/pages/create_account.dart';

import 'package:app_new/utils/routes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => UserProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.light,

      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.lato().fontFamily,
        textTheme: GoogleFonts.latoTextTheme(),
      ),

      darkTheme: ThemeData(brightness: Brightness.dark),

      initialRoute: MyRoutes.splashRoute,

      routes: {
        "/": (context) => const SplashScreen(),

        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.forgetPasswordRoute: (context) => const ForgotPasswordPage(),
        MyRoutes.otpVerificationRoute: (context) => const OtpVerification(),
        MyRoutes.cartRoute: (context) => const CartScreen(),
        MyRoutes.wishListRoute: (context) => const WishList(),
        MyRoutes.profileRoute: (context) => const ProfileScreen(),
        MyRoutes.orderSummeryRoute: (context) =>
            const OrderSummery(product: {}),
        MyRoutes.paymentRoute: (context) => const PaymentScreen(),
        MyRoutes.createAccountRoute: (context) => const CreateAccountPage(),
        MyRoutes.splashRoute: (context) => const SplashScreen(),
        MyRoutes.splashRoute1: (context) => const SplashScreen1(),
        MyRoutes.splashRoute2: (context) => const SplashScreen2(),
        MyRoutes.splashRoute3: (context) => const SplashScreen3(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == MyRoutes.itemDetailsRoute) {
          final product = settings.arguments as Map<String, String>;

          return MaterialPageRoute(
            builder: (context) => ItemDetails(product: product),
          );
        }

        return null;
      },
    );
  }
}
