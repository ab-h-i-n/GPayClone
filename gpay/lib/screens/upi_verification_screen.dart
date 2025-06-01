import 'package:flutter/material.dart';
import 'package:gpay/constants/app_logos.dart';

class UPIVerificationScreen extends StatelessWidget {
  const UPIVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('State Bank of India',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('XXX0064',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Image(
                      image: AssetImage(AppLogos.upiLogo),
                      height: 40,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
