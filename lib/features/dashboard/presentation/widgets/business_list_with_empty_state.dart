import 'package:flutter/material.dart';
import 'package:mini_app/core/api/api_response.dart';
import 'package:mini_app/features/business/data/providers/business_provider.dart';
import 'package:mini_app/features/business/models/business_model.dart';
import 'package:mini_app/features/business/presentation/widgets/business_card.dart';
import 'package:mini_app/utils/common.dart';
import 'package:mini_app/utils/utils.dart';
import 'package:provider/provider.dart';

class BusinessListWithEmpty extends StatefulWidget {
  const BusinessListWithEmpty({super.key});

  @override
  State<BusinessListWithEmpty> createState() => _BusinessListWithEmptyState();
}

class _BusinessListWithEmptyState extends State<BusinessListWithEmpty> {
  late Future<ApiResponse<List<Business>>> _businessFuture;

  @override
  void initState() {
    super.initState();
    _businessFuture = context.read<BusinessProvider>().fetchBusinessesEmpty();
  }

  void _refreshBusinesses() {
    setState(() {
      _businessFuture = context.read<BusinessProvider>().fetchBusinessesEmpty();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.l10n;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<ApiResponse<List<Business>>>(
        future: _businessFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                icon: Icons.business,
                title: appLocalizations.noBusinessesFound,
                errorMessage: appLocalizations.noBusinessesFound,
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
      ),
    );
  }
}
