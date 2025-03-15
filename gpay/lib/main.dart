import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import
import 'package:gpay/constants/app_colors.dart';
import 'package:gpay/screens/bank_verification_loading.dart';
import 'package:gpay/screens/email_selection_screen.dart';
import 'package:gpay/screens/home_screen.dart';
import 'package:gpay/screens/initial_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home : user == null ? const InitialScreen() : const HomeScreen(),
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

  PageRouteBuilder _slideTransitionRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
