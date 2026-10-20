import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/search_results_page.dart';

void main() {
  runApp(const FlightBookingApp());
}

/// Root application widget.
///
/// Configures the global [MaterialApp] with route definitions and a cohesive
/// dark-purple theme accented with orange/amber.
class FlightBookingApp extends StatelessWidget {
  const FlightBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Booking',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const HomePage(),
        AppRoutes.results: (_) => const SearchResultsPage(),
      },
    );
  }
}

/// Centralized route constants.
class AppRoutes {
  AppRoutes._();
  static const String home = '/';
  static const String results = '/search-results';
}

/// Centralized theme and color definitions.
///
/// Deep dark purple background with modern rounded surfaces and amber/orange
/// primary accent buttons.
class AppTheme {
  AppTheme._();

  /// Deep dark purple canvas
  static const Color deepPurple = Color(0xFF120A1F);

  /// Elevated container / card surface
  static const Color surfacePurple = Color(0xFF1E1432);

  /// Primary amber/orange accent
  static const Color amberPrimary = Color(0xFFFF9800);

  static const Color amberSecondary = Color(0xFFFFB74D);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3AEC5);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: deepPurple,
      colorScheme: const ColorScheme.dark(
        primary: amberPrimary,
        secondary: amberSecondary,
        surface: surfacePurple,
        background: deepPurple,
        onPrimary: Color(0xFF000000), // text on amber buttons
        onSurface: textPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: amberPrimary,
          foregroundColor: const Color(0xFF000000),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfacePurple,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: amberPrimary),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
      ),
    );
  }
}
