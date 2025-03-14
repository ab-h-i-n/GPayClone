import 'package:flutter/material.dart';
import 'package:gpay/constants/app_colors.dart';

class CustomDropdownButton extends StatelessWidget {
  final String text;
  final dynamic icon; 
  final double iconSize;
  final Color iconColor;
  final double horizontalPadding;
  final double verticalPadding;

  const CustomDropdownButton({
    super.key,
    required this.text,
    required this.icon,
    this.iconSize = 24,
    this.iconColor = Colors.grey,
    this.horizontalPadding = 5,
    this.verticalPadding = 5,
  });

  void _onButtonPressed(BuildContext context) {
    debugPrint('Button pressed!');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onButtonPressed(context),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: double.infinity
        ),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, 
          children: [
            if (icon is IconData)
              Icon(icon, size: iconSize, color: iconColor),
            if (icon is String)
              Image.asset(
                icon,
                width: iconSize,
                height: iconSize,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: iconSize, color: Colors.red);
                },
              ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: TextStyle(color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 3),
            Icon(Icons.arrow_drop_down, color: AppColors.tertiary, size: 24),
          ],
        ),
      ),
    );
  }
}