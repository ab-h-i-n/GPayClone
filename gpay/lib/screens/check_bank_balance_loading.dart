import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shimmer/shimmer.dart';

class CheckBankBalanceLoading extends StatefulWidget {
  const CheckBankBalanceLoading({super.key});

  @override
  State<CheckBankBalanceLoading> createState() => _CheckBankBalanceLoadingState();
}

class _CheckBankBalanceLoadingState extends State<CheckBankBalanceLoading> {
  @override
  void initState() {
    super.initState();
    // Redirect after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/check-bank-balance-upi');
    });
  }

  Widget _buildShimmerContainer({
    double? height,
    double? width,
    double radius = 10,
    bool isCircle = false,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: isCircle ? null : BorderRadius.all(Radius.circular(radius)),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[900]!,
          highlightColor: Colors.grey[700]!,
          period: const Duration(seconds: 1),
          loop: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerContainer(height: 30, width: 200),
                const SizedBox(height: 20),
                _buildShimmerContainer(
                  height: 165,
                  width: double.infinity,
                  radius: 20,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildShimmerContainer(height: 30, width: 200),
                    _buildShimmerContainer(height: 30, width: 50),
                  ],
                ),
                const SizedBox(height: 30),
                for (int i = 0; i < 3; i++)
                  Container(
                    height: 46,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        _buildShimmerContainer(height: 46, width: 46, isCircle: true),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildShimmerContainer(height: 20, width: 150),
                            const SizedBox(height: 5),
                            _buildShimmerContainer(height: 15, width: 100),
                          ],
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}