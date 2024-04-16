import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationTheme {
  static Color primaryColor = const Color(0xff0A1128);
  static ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      primary: primaryColor,
      seedColor: primaryColor,
      secondary: Colors.white,
    ),
    textTheme: TextTheme(
        titleLarge: GoogleFonts.pacifico(
          color: Colors.white,
          fontSize: 78,
        ),
        titleMedium: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: const Color(0xff14213D),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: const Color(0xff7DD7DF),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: GoogleFonts.poppins(
            fontSize: 15,
            color: const Color(0xffACACAC),
            fontWeight: FontWeight.w500),
        displayMedium: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 35,
          fontWeight: FontWeight.w500,
          shadows: <Shadow>[
            const Shadow(
              offset: Offset(0, 5),
              color: Color.fromARGB(255, 66, 61, 61),
            ),
          ],
        ),
        labelMedium: GoogleFonts.poppins(
          color: primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      selectedIconTheme: IconThemeData(
        color: Color(0xff7DD7DF),
        size: 45,
      ),
      selectedItemColor: Color(0xff7DD7DF),
      unselectedIconTheme: IconThemeData(
        color: Color(0xff0A1128),
        size: 40,
      ),
      unselectedItemColor: Color(0xff0A1128),
    ),
  );
}
