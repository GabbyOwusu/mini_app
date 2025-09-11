import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.title,
    this.icon,
    required this.errorMessage,
    this.onPressed,
  });
  final String? title;
  final IconData? icon;
  final String errorMessage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            icon ?? Icons.warning_amber_outlined,
            size: 64,
            color: Colors.orange[400],
          ),
          const SizedBox(height: 16),
          Text(
            title ?? 'Unable to load businesses',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (onPressed != null) ...[
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ]
        ],
      ),
    );
  }
}
