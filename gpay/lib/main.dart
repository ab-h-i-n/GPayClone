import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this import
import 'package:gpay/constants/app_colors.dart';
import 'package:gpay/screens/bank_verification_loading.dart';
import 'package:gpay/screens/email_selection_screen.dart';
import 'package:gpay/screens/home_screen.dart';
import 'package:gpay/screens/initial_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // Ensure Firebase is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/bank-verification-loading':
            return _slideTransitionRoute(const BankVerificationLoading());
          case '/home-screen':
            return _slideTransitionRoute(const HomeScreen());
          case '/email-selection':
            return _slideTransitionRoute(const EmailSelectionScreen());
          default:
            return _slideTransitionRoute(const InitialScreen());
        }
      },
    );
  }

  /// Function to create a slide transition
  PageRouteBuilder _slideTransitionRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from the right
        const end = Offset.zero; // End at the center
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}