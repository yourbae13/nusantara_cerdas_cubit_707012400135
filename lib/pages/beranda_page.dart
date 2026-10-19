import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  static const _pilar = [
    (Icons.account_balance, 'Smart Governance'),
    (Icons.campaign, 'Smart Branding'),
    (Icons.trending_up, 'Smart Economy'),
    (Icons.home_work, 'Smart Living'),
    (Icons.groups, 'Smart Society'),
    (Icons.eco, 'Smart Environment'),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        for (final p in _pilar)
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(p.$1, size: 40),
                const SizedBox(height: 8),
                Text(p.$2, textAlign: TextAlign.center),
              ],
            ),
          ),
      ],
    );
  }
}
