import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const RoadCellApp());
}

class RoadCellApp extends StatelessWidget {
  const RoadCellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RoadCellSplashScreen(),
    );
  }
}

class RoadCellSplashScreen extends StatelessWidget {
  const RoadCellSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Transparent status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xff011A13),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff011A13),
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // 80% clean smooth mixed gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
            Color(0xff143957),
            Color(0xff0d3345),
            Color(0xff062d31),
            Color(0xff012219),
            ],
          ),
        ),

        child: Stack(
          children: [
            // Center logo and text
            Center(
              child: Transform.translate(
                offset: const Offset(0, -35),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo box
                    Container(
                      height: 98,
                      width: 98,
                      decoration: BoxDecoration(
                        color: const Color(0xff20384F),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: const Color(0xff22C55E),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff22C55E).withOpacity(0.35),
                            blurRadius: 24,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(26),
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xff20384F),
                              child: const Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 34,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ROAD CELL text
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "ROAD",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 5,
                            ),
                          ),
                          TextSpan(
                            text: "CELL",
                            style: TextStyle(
                              color: Color(0xff22C55E),
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "VEHICLE PERMISSION SYSTEM",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.32),
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom road, loading line and text
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // Road
                  SizedBox(
                    height: 100,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: 36,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xff1D3F55).withOpacity(0.72),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                        ),

                        // Road white dividers
                        Positioned(
                          top: 0,
                          child: Container(
                            width: 4,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.50),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 37,
                          child: Container(
                            width: 4,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.50),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 75,
                          child: Container(
                            width: 4,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.50),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Progress line
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 52),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              color: const Color(0xff22C55E),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xff22C55E)
                                      .withOpacity(0.35),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 11),

                  Text(
                    "Road Dept. India",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.18),
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}