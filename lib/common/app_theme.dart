// 
import 'package:flutter/material.dart';
import 'package:todo/common/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light theme 🌞
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.bgColor,
    fontFamily: GoogleFonts.poppins().fontFamily,

    //  Text theme
    primaryTextTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        color: AppColors.primaryTextLightColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.poppins(
        color: AppColors.primaryColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        color: AppColors.primaryTextLightColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.poppins(
        color: AppColors.textBlack,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.poppins(
        color: AppColors.textGrayColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: AppColors.textGrayColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: AppColors.primaryTextLightColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.poppins(
        color: AppColors.primaryTextLightColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.primaryTextLightColor),
      titleTextStyle: GoogleFonts.poppins(
        color: AppColors.primaryTextLightColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Bottom navigation bar theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryColor,
      unselectedIconTheme: IconThemeData(color: Color(0x252C34FF), size: 30),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),

    // Floating action button theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      shape: const CircleBorder(),
      elevation: 4,
      splashColor: AppColors.primaryColor.withOpacity(0.4),
    ),
    
    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromRGBO(249, 250, 252, 1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      hintStyle: GoogleFonts.poppins(
        color: const Color.fromRGBO(151, 151, 151, 1),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: AppColors.primaryColor,
      suffixIconColor: AppColors.textGrayColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),

    // Color scheme
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.light,
    ),
    
    // Card theme
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  // 🌔Dark theme🌙
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.bgDarkColor,
    fontFamily: GoogleFonts.poppins().fontFamily,

    //  Text theme
    primaryTextTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.poppins(
        color: Colors.grey[400],
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: Colors.grey[400],
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: GoogleFonts.poppins(
        color: Colors.grey[400],
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Bottom navigation bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1C1C1C),
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey[400],
      unselectedIconTheme: IconThemeData(color: Colors.grey[400], size: 30),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),

    // Floating action button theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      shape: const CircleBorder(),
      elevation: 4,
      splashColor: AppColors.primaryColor.withOpacity(0.4),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromRGBO(40, 40, 40, 1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      hintStyle: GoogleFonts.poppins(
        color: Colors.grey[400],
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: AppColors.primaryColor,
      suffixIconColor: Colors.grey[400],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),

    // Color scheme
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.dark,
    ),
    
    // Card theme
    cardTheme: CardTheme(
      color: const Color(0xFF1C1C1C),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}