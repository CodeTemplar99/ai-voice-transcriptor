import 'package:alindor_tech/configs/colors.dart';
import 'package:alindor_tech/configs/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// Opens a top snackbar with a transparent background and dismisses upwards when swiped.
// The snackbar floats above the content, with a customizable margin.
// It displays a message in a styled container with an icon and text.
// Requires the BuildContext `context` and a `message` to display.
Future<void> openSnackBar(
  BuildContext context,
  String message,
) async =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        width: getScreenHeight(327),
        padding: EdgeInsets.symmetric(
            horizontal: getScreenHeight(12), vertical: getScreenHeight(10)),
        decoration: BoxDecoration(
            // color: const Color(0xFFF4FFED),
            color: const Color(0xFFFFEEED),
            borderRadius: BorderRadius.circular(getScreenHeight(8))),
        child: Center(
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/info_danger.svg'),
              SizedBox(
                width: getScreenHeight(10),
              ),
              SizedBox(
                width: getScreenHeight(260),
                child: Text(
                  message,
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.manrope(
                    fontSize: getScreenHeight(14),
                    color: danger,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
