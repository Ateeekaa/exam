 import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Пайдаланушы тіркелмеген',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
