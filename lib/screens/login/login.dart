import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:alindor_tech/configs/colors.dart';
import 'package:alindor_tech/configs/dimension.dart';

import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<String> keypointTexts = [
    'Infinite Possibilities',
    'Smart Solutions',
    'Empowering Minds',
    'Your Personal Genius',
    'Enhancing Lives',
    'Your Progress Partner',
  ];

  String? currentPoint;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentPoint = keypointTexts[0];
    });

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        currentPoint = keypointTexts[timer.tick % keypointTexts.length];
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0F0827),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getScreenHeight(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VerticalSpacingMobile(
                heightValue: MediaQuery.of(context).size.height / 4),
            SizedBox(
              width: getScreenHeight(350),
              child: Center(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'AI, but ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getScreenHeight(24),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ' $currentPoint.',
                    style: GoogleFonts.chewy(
                        fontSize: getScreenHeight(20),
                        backgroundColor: Colors.purple,
                        height: 1.5),
                  )
                ])),
              ),
            ),
            VerticalSpacingMobile(heightValue: getScreenHeight(30)),
            GestureDetector(
              onTap: () {
                context.read<AuthService>().signInWithGoogle(context);
              },
              child: Container(
                height: getScreenHeight(50),
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: textGray),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/google.svg',
                      width: getScreenHeight(25),
                      height: getScreenHeight(25),
                    ),
                    SizedBox(
                      width: getScreenHeight(10),
                    ),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(
                        color: primaryBlack,
                        fontSize: getScreenHeight(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpacingMobile(
                heightValue: MediaQuery.of(context).size.height / 3.3),
            Center(
              child: Text(
                'Alindor.tech',
                style: GoogleFonts.manrope(
                    color: Colors.white70,
                    fontSize: getScreenHeight(19),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
