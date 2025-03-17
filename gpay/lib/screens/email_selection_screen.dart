import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gpay/widgets/back_more_header.dart';
import '../constants/app_colors.dart';
import '../constants/app_logos.dart';
import '../providers/auth_provider.dart';
import '../providers/phone_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

final Terms =
    'By continuing you agree to the Combined Google Pay Terms.The Privacy Policy describes how your data is handled.Google Pay will periodically send your contacts and locationto Google servers. People with your number can contact you across Google services and see your public information, such as your name and photo.The phone number you have provided can be used on different Google services';
final Privacy =
    'Google Pay collects your phone number device, payment and location, to set up payment methods and control risk. This and other transaction information may be shared with your payment provider network and 3rd parties.';

class EmailSelectionScreen extends ConsumerStatefulWidget {
  const EmailSelectionScreen({super.key});

  @override
  ConsumerState<EmailSelectionScreen> createState() =>
      _EmailSelectionScreenState();
}

class _EmailSelectionScreenState extends ConsumerState<EmailSelectionScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, String>? _selectedAccount;

  @override
  void initState() {
    super.initState();
    _fetchGoogleAccount();
  }

  Future<void> _fetchGoogleAccount() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signInSilently();
      if (account != null) {
        setState(() {
          _selectedAccount = {
            'email': account.email,
            'name': account.displayName ?? "Unknown User",
            'photoUrl': account.photoUrl ?? "",
          };
        });
      }
      print("Fetched Google account: $account");
    } catch (error) {
      print("Error fetching Google account: $error");
    }
  }

  Future<void> _selectGoogleAccount() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        setState(() {
          _selectedAccount = {
            'email': account.email,
            'name': account.displayName ?? "Unknown User",
            'photoUrl': account.photoUrl ?? "",
          };
        });
      }
      print("Google Sign-In successful: $account");
    } catch (error) {
      print("Google Sign-In failed: $error");
    }
  }

  Future<void> _continueWithSelectedAccount() async {
    if (_selectedAccount != null) {
      try {
        // Sign in with Google using Firebase Authentication
        final GoogleSignInAuthentication googleAuth =
            await _googleSignIn.currentUser!.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credentials
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        //create a doc in firestore collection 'users'
        FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'email': userCredential.user!.email!,
          'name': userCredential.user!.displayName ?? "Unknown User",
          'photoUrl': userCredential.user!.photoURL ?? "",
          'phone' : ref.read(phoneProvider),
        });

        if (!mounted) return;
        // Navigate to the BankVerificationLoading page
        Navigator.of(context).pushNamed('/bank-verification-loading');
      } catch (error) {
        debugPrint("Firebase Sign-In failed: $error");
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign in: $error'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumber = ref.watch(phoneProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackMoreHeader(),
              const SizedBox(height: 40),
              Text(
                'Choose an account',
                style: TextStyle(
                  color: AppColors.textColorMain,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'This is how people on Google Pay will see you',
                style: GoogleFonts.inter(
                  color: AppColors.textColorMain,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () {
                  if (_selectedAccount != null) _googleSignIn.signOut();
                  _selectGoogleAccount();
                },
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: _selectedAccount != null &&
                                _selectedAccount!['photoUrl']?.isNotEmpty == true
                            ? NetworkImage(_selectedAccount!['photoUrl']!)
                            : AssetImage(AppLogos.noUser) as ImageProvider,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _selectedAccount != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedAccount!['name']!,
                                    style: GoogleFonts.inter(
                                      color: AppColors.textColorMain,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    _selectedAccount!['email']!,
                                    style: GoogleFonts.inter(
                                      color: AppColors.secondary,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '+91$phoneNumber',
                                    style: GoogleFonts.inter(
                                      color: AppColors.secondary,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'Choose an account',
                                style: GoogleFonts.inter(
                                  color: AppColors.textColorMain,
                                  fontSize: 15,
                                ),
                              ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textColorMain,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      Terms,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppColors.secondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      Privacy,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppColors.secondary,
                        fontSize: 12,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.tertiary,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.9, 40),
                      ),
                      onPressed: () {
                        if (_selectedAccount != null) {
                          _continueWithSelectedAccount();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Please select an account to continue'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Accept and continue',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}