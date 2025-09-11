import 'package:flutter/material.dart';
import 'package:mini_app/core/api/api_response.dart';
import 'package:mini_app/features/business/data/providers/business_provider.dart';
import 'package:mini_app/features/business/models/business_model.dart';
import 'package:mini_app/features/business/presentation/widgets/business_card.dart';
import 'package:mini_app/utils/common.dart';
import 'package:mini_app/utils/utils.dart';
import 'package:provider/provider.dart';

class BusinessList extends StatefulWidget {
  const BusinessList({super.key});

  @override
  State<BusinessList> createState() => _BusinessListState();
}

class _BusinessListState extends State<BusinessList> {
  late Future<ApiResponse<List<Business>>> _businessFuture;

  @override
  void initState() {
    super.initState();
    _businessFuture = context.read<BusinessProvider>().fetchBusinesses();
  }

  void _refreshBusinesses() {
    setState(() {
      _businessFuture = context.read<BusinessProvider>().fetchBusinesses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.l10n;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<BusinessProvider>(
        builder: (context, businessProvider, child) {
          final initialData = businessProvider.businesses.isNotEmpty
              ? ApiResponse<List<Business>>(
                  data: businessProvider.businesses,
                )
              : null;
          return FutureBuilder<ApiResponse<List<Business>>>(
            future: _businessFuture,
            initialData: initialData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting && snapshot.data == null) {
                return Center(
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(appLocalizations.loadingBusinesses),
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
                    errorMessage: appLocalizations.noBusinessesFound,
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
              return Center(
                child: Text(appLocalizations.somethingUnexpectedHappened),
              );
            },
          );
        },
      ),
    );
  }
}
