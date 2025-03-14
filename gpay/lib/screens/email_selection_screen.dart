import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gpay/widgets/back_more_header.dart';
import '../constants/app_colors.dart';
import '../constants/app_logos.dart';
import '../providers/email_provider.dart';
import '../providers/phone_provider.dart';

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
            'imageUrl': account.photoUrl ?? "",
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
            'imageUrl': account.photoUrl ?? "",
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
      ref.read(emailProvider.notifier).state = _selectedAccount!;
      // Perform any additional sign-in logic here if needed
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
                                _selectedAccount!['imageUrl']!.isNotEmpty
                            ? NetworkImage(_selectedAccount!['imageUrl']!)
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
                        _continueWithSelectedAccount();
                        Navigator.of(context).pushNamed('/home-screen');
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
