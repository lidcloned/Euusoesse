import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'login_screen.dart'; // Navigate to LoginScreen after splash
import '../utils/theme_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Play splash sound
    try {
      // Ensure the path is correct and the asset is listed in pubspec.yaml
      await _audioPlayer.play(AssetSource('audio/splash_screen_sound.mp3'));
      print('Splash sound played successfully.');
    } catch (e) {
      print('Error playing splash sound: $e');
      // Handle error: Log it, maybe proceed without sound
    }

    // Wait for a few seconds (simulating loading)
    await Future.delayed(const Duration(seconds: 4));

    // Navigate to the next screen (LoginScreen)
    if (mounted) { // Check if the widget is still in the tree
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()), // Assuming LoginScreen exists
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Release audio player resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure status bar is visible and styled (optional)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Or Brightness.dark based on background
      systemNavigationBarColor: ThemeConstants.backgroundColor, // Match background
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for Logo - Replace with actual logo later
            Image.asset(
              'assets/images_png/lamafia_icon_foreground.png', // Use the renamed icon as placeholder logo
              width: 150,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading splash image: $error');
                return const Icon(Icons.hide_image, size: 100, color: ThemeConstants.textSecondaryColor);
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'LAMAFIA', 
              style: TextStyle(
                fontSize: 32, 
                fontWeight: FontWeight.bold, 
                color: ThemeConstants.textColor,
                fontFamily: 'Gothic', // Ensure font is loaded
              ),
            ),
            const SizedBox(height: 40),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ThemeConstants.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

