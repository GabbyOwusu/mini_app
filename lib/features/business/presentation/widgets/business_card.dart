import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? bottomText;

  const BusinessCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.bottomText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        leading: const Icon(Icons.business),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
            if (bottomText != null) Text(bottomText!),
          ],
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_forward_ios, size: 14),
        ),
      ),
    );
  }
}
