import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gpay/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PeoplesSection extends StatefulWidget {
  const PeoplesSection({super.key});

  @override
  State<PeoplesSection> createState() => _PeoplesSectionState();
}

class _PeoplesSectionState extends State<PeoplesSection>
    with SingleTickerProviderStateMixin {
  List<Contact> userContacts = [];
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _fetchUserContacts();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true); // Repeat the animation in a loop

    // Define the animation (opacity)
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  Future<void> _fetchUserContacts() async {
    if (await Permission.contacts.request().isGranted) {
      List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      setState(() {
        var contactsWithPhoto =
            contacts.where((contact) => contact.photo != null).take(7).toList();

        if (contactsWithPhoto.length < 7) {
          var contactsWithoutPhoto = contacts
              .where((contact) => contact.photo == null)
              .take(7 - contactsWithPhoto.length)
              .toList();
          contactsWithPhoto.addAll(contactsWithoutPhoto);
        }

        userContacts = contactsWithPhoto
          ..sort((a, b) => a.displayName.compareTo(b.displayName));
      });
    } else {
      debugPrint("Permission Denied!");
    }
  }

  Color generateRandomSimilarColor() {
    // Base color in RGB (7E57C2)
    const Color baseColor = Color(0xFF7E57C2);

    // Convert base color to HSL
    final HSLColor hslColor = HSLColor.fromColor(baseColor);

    // Extract hue, saturation, and lightness
    double saturation = hslColor.saturation;
    double lightness = hslColor.lightness;

    // Random generator
    final Random random = Random();

    // Generate a random hue (0-360 degrees)
    double randomHue = random.nextDouble() * 360;

    // Create a new color with the same saturation and lightness but a different hue
    HSLColor newHslColor = HSLColor.fromAHSL(1.0, randomHue, saturation, lightness);

    // Convert back to Color
    return newHslColor.toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'People',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.textColorMain,
            ),
          ),
          const SizedBox(height: 20),
          userContacts.isEmpty
              ? SizedBox(
                  height: 200,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return FadeTransition(
                        opacity: _animation, 
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color.fromARGB(255, 48, 48, 52),
                                  width: 1,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.serachBarColor,
                                backgroundImage: null,
                                child: null,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: 60,
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppColors.serachBarColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : SizedBox(
                  height: 200,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: userContacts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == userContacts.length) {
                        // Display the additional button
                        return Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.serachBarColor,
                              radius: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 48, 48, 52),
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 40,
                                    color: AppColors.tertiary,
                                  ),
                                  onPressed: () {
                                    // Handle the button press
                                    debugPrint("Add more people pressed!");
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'More',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: AppColors.textColorMain,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        );
                      } else {
                        // Display the contact
                        final contact = userContacts[index];
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color.fromARGB(255, 48, 48, 52),
                                  width: 1,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: generateRandomSimilarColor(),
                                backgroundImage: contact.photo != null
                                    ? MemoryImage(contact.photo!)
                                    : null,
                                child: contact.photo == null
                                    ? Text(
                                        contact.displayName[0],
                                        style: const TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textColorMain,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              contact.displayName,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: AppColors.textColorMain,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}