import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../users/screens/user_list_widget.dart';
import '../../users/screens/user_information_widget.dart';
import '../../users/screens/pair_user_screen.dart';
import '../../vitals/screens/vitals_detail_widget.dart';
import '../providers/selection_providers.dart';
import '../../dashboard/providers/view_mode_provider.dart';
import '../../devices/screens/devices_screen.dart';
import '../../devices/screens/pair_devices_screen.dart';
import '../../devices/providers/device_discovery_provider.dart';
import 'user_dashboard.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder gives us the constraints of the screen
    return LayoutBuilder(
      builder: (context, constraints) {
        // If width is > 900, we treat it as Desktop
        if (constraints.maxWidth > 900) {
          return const _DesktopLayout();
        } else {
          return const _MobileLayout();
        }
      },
    );
  }
}

class _DesktopLayout extends ConsumerWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(deviceManagerProvider); // start scanner in the background

    final viewMode = ref.watch(dashboardViewModeProvider);
    final selectedVital = ref.watch(selectedVitalProvider);
    final isPairingUser = ref.watch(isPairingUserProvider);

    Widget col2;
    Widget col3;

    if (viewMode == DashboardMode.devices) {
      // --- DEVICES MODE ---
      col2 = const DevicesScreen();
      col3 = const PairDevicesScreen();
    } else {
      // User Mode
      col2 = const UserDashboard();

      // Dynamic Column 3 Logic:
      if (selectedVital != null) {
        col3 = const VitalsDetailWidget(); // Priority 1: Vital Graph
      } else if (isPairingUser) {
        col3 = const PairUserScreen(); // Priority 2: Pairing Screen
      } else {
        col3 = const UserInformationWidget(); // Priority 3: User Info
      }
    }

    return Scaffold(
      body: Row(
        children: [
          // Column 1: User List (Fixed Width)
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[50],
              child: const UserListWidget(),
            ),
          ),
          const VerticalDivider(width: 1),

          // Column 2: Dashboard (Flexible)
          Expanded(
            flex: 5,
            child: Container(color: Colors.white, child: col2),
          ),
          const VerticalDivider(width: 1),

          // Column 3: Dynamic (Info or Vitals) (Fixed Width)
          Expanded(
            flex: 4,
            child: Container(color: Colors.grey[50], child: col3),
          ),
        ],
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    // For mobile, we just start with the User List
    return Scaffold(
      appBar: AppBar(title: const Text("AWear")),
      body: const Center(child: Text("User List (Mobile)")),
    );
  }
}
