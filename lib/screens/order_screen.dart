import 'package:flutter/material.dart';
import '../constants/colors.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: AppColors.primary,
      ),
      body: const Center(
        child: Text(
          "No orders yet",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
