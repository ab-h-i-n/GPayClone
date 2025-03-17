import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import  'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null) {
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedUser = prefs.getString('user');
    
    if (cachedUser != null) {
      state = User.fromJson(jsonDecode(cachedUser));
      return;
    }

    final user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          final data = userDoc.data()!;
          final userData = User(
            email: user.email ?? '',
            name: data['name'] ?? '',
            photoUrl: data['photoUrl'] ?? '',
            phone: data['phone'] ?? '',
            id: user.uid,
          );
          
          state = userData;
          // Cache the user data
          await prefs.setString('user', jsonEncode(userData.toJson()));
          print("User data fetched and cached successfully");
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await firebase_auth.FirebaseAuth.instance.signOut();
    state = null; 
  }
}
