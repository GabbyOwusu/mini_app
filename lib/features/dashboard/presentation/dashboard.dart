import 'package:flutter/material.dart';
import 'package:mini_app/features/dashboard/presentation/widgets/business_list.dart';
import 'package:mini_app/features/dashboard/presentation/widgets/business_list_with_error.dart';
import 'package:mini_app/features/dashboard/presentation/widgets/business_list_with_retry.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business List with different scenarios'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Business List'),
            Tab(text: 'Retry'),
            Tab(text: 'Persistent error'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          BusinessList(),
          BusinessListWithRetry(),
          BusinessListWithPersistentError(),
        ],
      ),
    );
  }
}
