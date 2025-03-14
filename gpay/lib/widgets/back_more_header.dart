import 'package:flutter/material.dart';
import 'package:gpay/constants/app_colors.dart';

class BackMoreHeader extends StatelessWidget {
  const BackMoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            style: const ButtonStyle(
              tapTargetSize:
                  MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.textColorMain,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            style: const ButtonStyle(
              tapTargetSize:
                  MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.textColorMain,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
