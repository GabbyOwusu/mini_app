import 'package:flutter/material.dart';
import 'package:mini_app/core/api/api_response.dart';
import 'package:mini_app/features/business/data/providers/business_provider.dart';
import 'package:mini_app/features/business/models/business_model.dart';
import 'package:mini_app/features/business/presentation/widgets/business_card.dart';
import 'package:mini_app/utils/common.dart';
import 'package:provider/provider.dart';

class BusinessListWithRetry extends StatefulWidget {
  const BusinessListWithRetry({super.key});

  @override
  State<BusinessListWithRetry> createState() => _BusinessListWithRetryState();
}

class _BusinessListWithRetryState extends State<BusinessListWithRetry> {
  late Future<ApiResponse<List<Business>>> _businessFuture;

  @override
  void initState() {
    super.initState();
    _businessFuture = context.read<BusinessProvider>().fetchBusinessWithError();
  }

  void _refreshBusinesses() {
    setState(() {
      _businessFuture = context.read<BusinessProvider>().fetchBusinesses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<BusinessProvider>(
        builder: (context, businessProvider, child) {
          return FutureBuilder<ApiResponse<List<Business>>>(
            future: _businessFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Loading businesses...'),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return EmptyState(
                  errorMessage: snapshot.error.toString(),
                  onPressed: _refreshBusinesses,
                );
              }
              if (snapshot.hasData) {
                final response = snapshot.data!;
                if (response.errorMessage != null) {
                  return EmptyState(
                    errorMessage: response.errorMessage!,
                    onPressed: _refreshBusinesses,
                  );
                }
                if (response.data!.isEmpty) {
                  return EmptyState(
                    errorMessage: 'No businesses found',
                    onPressed: _refreshBusinesses,
                  );
                }
                return Column(
                  children: response.data!.map((business) {
                    return BusinessCard(
                      title: business.businessName,
                      subtitle: business.businessLocation,
                      bottomText: business.contactNumber,
                    );
                  }).toList(),
                );
              }
              return const Center(
                child: Text('Something unexpected happened'),
              );
            },
          );
        },
      ),
    );
  }
}
