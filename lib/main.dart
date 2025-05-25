import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart'; // Temporarily commented out
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart'; 
import 'providers/user_provider.dart'; 
import 'utils/theme_constants.dart'; 
import 'utils/logger.dart'; // Import the logger

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.info('App Initialization Started.');

  // Initialize Firebase (Temporarily commented out)
  // try {
  //   await Firebase.initializeApp();
  //   Logger.info('Firebase Initialized Successfully.');
  // } catch (e, stackTrace) {
  //   Logger.error('Firebase Initialization Failed', error: e, stackTrace: stackTrace);
  //   // Handle initialization failure if necessary (e.g., show error message)
  // }

  // Forçar orientação retrato
  try {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Logger.info('Screen orientation set to portrait.');
  } catch (e, stackTrace) {
    Logger.error('Failed to set screen orientation', error: e, stackTrace: stackTrace);
  }
  
  Logger.info('Running LAMAFIA App.');
  runApp(const LAMAFIAApp());
}

class LAMAFIAApp extends StatelessWidget {
  const LAMAFIAApp({super.key});

  @override
  Widget build(BuildContext context) {
    Logger.debug('Building LAMAFIAApp Widget.');
    // TODO: Initialize UserProvider properly if needed without Firebase Auth
    return ChangeNotifierProvider(
      create: (context) => UserProvider(), 
      child: MaterialApp(
        title: 'LAMAFIA', // Updated title
        debugShowCheckedModeBanner: false, // Keep false for release builds
        theme: ThemeData(
          fontFamily: 'Gothic', // Set default font if desired
          colorScheme: ColorScheme.dark(
            primary: ThemeConstants.primaryColor, // Ensure these constants are defined
            secondary: ThemeConstants.accentColor,
            surface: ThemeConstants.surfaceColor,
            background: ThemeConstants.backgroundColor, // Use background for consistency if defined
            error: ThemeConstants.dangerColor,
            onPrimary: ThemeConstants.textColor, // Text on primary color
            onSecondary: ThemeConstants.textColor, // Text on secondary color
            onSurface: ThemeConstants.textColor, // Text on surface color
            onBackground: ThemeConstants.textColor, // Text on background color
            onError: ThemeConstants.textColor, // Text on error color
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: ThemeConstants.backgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: ThemeConstants.surfaceColor,
            foregroundColor: ThemeConstants.textColor,
            elevation: 4,
            titleTextStyle: TextStyle( // Define title text style
              fontFamily: 'Gothic', 
              color: ThemeConstants.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
          ),
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: ThemeConstants.textColor, fontFamily: 'Gothic'),
            bodyMedium: TextStyle(color: ThemeConstants.textSecondaryColor, fontFamily: 'Gothic'),
            titleLarge: TextStyle(
              color: ThemeConstants.textColor, 
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Gothic',
            ),
            labelLarge: TextStyle(fontFamily: 'Gothic'), // Example for button text
          ),
          cardTheme: CardTheme(
            color: ThemeConstants.surfaceColor,
            elevation: 2,
            margin: const EdgeInsets.all(8), // Add some margin
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Rounded corners
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeConstants.primaryColor,
              foregroundColor: ThemeConstants.textColor, // Text color on button
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Gothic'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Rounded corners
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: ThemeConstants.inputBackgroundColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Adjust padding
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none, // No border by default
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ThemeConstants.borderColor.withOpacity(0.5)), // Subtle border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ThemeConstants.accentColor, width: 2),
            ),
            labelStyle: TextStyle(color: ThemeConstants.textSecondaryColor, fontFamily: 'Gothic'),
            hintStyle: TextStyle(color: ThemeConstants.textSecondaryColor.withOpacity(0.7), fontFamily: 'Gothic'), // Style for hint text
          ),
        ),
        home: const SplashScreen(), 
      ),
    );
  }
}

// Placeholder for ThemeConstants - Needs actual implementation in utils/theme_constants.dart
// class ThemeConstants { ... } // Already defined in main.dart for now, move later

