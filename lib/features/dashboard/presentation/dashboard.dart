import 'package:flutter/material.dart';
import 'package:mini_app/features/business/presentation/widgets/business_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Business list',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Below are the list of businesses in your area',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ...List.generate(10, (index) {
              return const BusinessCard(
                title: 'Business name',
                subtitle: 'Business location',
                bottomText: 'Business contact number',
              );
            }),
          ],
        ),
      ),
    );
  }
}
