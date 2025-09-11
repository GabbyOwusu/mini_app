import 'package:flutter/material.dart';
import 'package:mini_app/features/dashboard/presentation/widgets/business_list_successful.dart';
import 'package:mini_app/features/dashboard/presentation/widgets/business_list_with_empty_state.dart';
import 'package:mini_app/features/dashboard/presentation/widgets/business_list_with_error.dart';
import 'package:mini_app/features/dashboard/presentation/widgets/business_list_with_retry.dart';
import 'package:mini_app/utils/utils.dart';

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
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.businessListWithDifferentScenarios),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: appLocalizations.businessList),
            Tab(text: appLocalizations.retry),
            Tab(text: appLocalizations.persistentError),
            Tab(text: appLocalizations.empty),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          BusinessList(),
          BusinessListWithRetry(),
          BusinessListWithPersistentError(),
          BusinessListWithEmpty(),
        ],
      ),
    );
  }
}
