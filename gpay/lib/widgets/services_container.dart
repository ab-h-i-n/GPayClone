import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicesContainer extends StatelessWidget {
  const ServicesContainer({super.key});

  static const services = [
    {
      'name': 'Scan any QR code',
      'icon': Icons.qr_code_scanner,
      'route': '/scan-qr',
    },
    {
      'name': 'Pay contacts',
      'icon': Icons.contacts_outlined,
      'route': '/pay-contacts',
    },
    {
      'name': 'Pay phone number',
      'icon': Icons.send_to_mobile_outlined,
      'route': '/pay-phone',
    },
    {
      'name': 'Bank transfer',
      'icon': Icons.account_balance,
      'route': '/bank-transfer',
    },
    {
      'name': 'Pay UPI ID or number',
      'icon': Icons.alternate_email,
      'route': '/pay-upi',
    },
    {
      'name': 'Self transfer',
      'icon': Icons.person_outlined,
      'route': '/self-transfer',
    },
    {
      'name': 'Pay \n bills',
      'icon': Icons.receipt_long_rounded,
      'route': '/pay-bills',
    },
    {
      'name': 'Mobile recharge',
      'icon': Icons.charging_station_outlined,
      'route': '/mobile-recharge',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        shrinkWrap: true, // Take only the space it needs
        physics:
            const NeverScrollableScrollPhysics(), // Disable scrolling if inside another scrollable view
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 4 columns
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8, // Adjusts height to make it look good
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return GestureDetector(
            onTap: () => print('Navigate to ${service['route']}'),
            // Navigator.pushNamed(context, service['route'] as String),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(
                  service['icon'] as IconData,
                  size: 30,
                  color: AppColors.tertiary,
                ),
                const SizedBox(height: 8),
                Text(
                  service['name'] as String,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColorMain),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
