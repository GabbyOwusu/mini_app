import 'package:flutter/material.dart';
import 'package:mini_app/features/dashboard/presentation/widgets/business_list.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Business list',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Below are the list of businesses in your area',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            BusinessList(),
          ],
        ),
      ),
    );
  }
}
