import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../dashboard/providers/selection_providers.dart';
import '../../users/providers/user_provider.dart';
import '../../vitals/providers/live_data_provider.dart';

class VitalsDetailWidget extends ConsumerWidget {
  const VitalsDetailWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedUserIdProvider);
    final selectedVital = ref.watch(selectedVitalProvider);
    final userList = ref.watch(userNotifierProvider).valueOrNull ?? [];

    // 1. Safety Checks FIRST
    if (selectedId == null) return const Center(child: Text("Select a User"));
    if (selectedVital == null) {
      return const Center(child: Text("Select a Vital"));
    }

    // 2. Watch Live Data (Now safe because selectedId is not null)
    final liveDataAsync = ref.watch(liveVitalStreamProvider(selectedId));

    // Optional: You can debug print here to see if data arrives
    liveDataAsync.when(
      data: (packet) {
        // Debug print or simple state update
      },
      loading: () {}, // No-op
      error: (err, stack) {}, // No-op
    );

    final user = userList.where((u) => u.id == selectedId).firstOrNull;
    if (user == null) return const SizedBox();

    // 3. Determine Color Scheme based on Vital
    Color color;
    switch (selectedVital) {
      case 'Heart Rate':
        color = Colors.red;
        break;
      case 'Oxygen':
        color = Colors.blue;
        break;
      case 'Temp':
        color = Colors.orange;
        break;
      default:
        color = Colors.teal;
    }

    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Header ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedVital,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "History for ${user.firstName}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
          const Gap(24),

          // --- Graph Section ---
          SizedBox(
            height: 200,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        // Dummy Data for visual test
                        spots: [
                          const FlSpot(0, 3),
                          const FlSpot(1, 1),
                          const FlSpot(2, 4),
                          const FlSpot(3, 2),
                          const FlSpot(4, 5),
                        ],
                        isCurved: true,
                        color: color,
                        barWidth: 4,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: color.withValues(alpha: 0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Gap(24),

          // --- History List ---
          const Text(
            "Recent Records",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Gap(8),
          Expanded(
            child: ListView.separated(
              itemCount: 10, // Dummy count
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text("Value: ${90 + index}"),
                  subtitle: Text("2025-01-05 10:${30 + index} AM"),
                  leading: Icon(Icons.circle, size: 12, color: color),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
