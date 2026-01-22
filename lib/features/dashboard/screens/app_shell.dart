import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../users/screens/user_list_widget.dart';
import '../../users/screens/user_information_widget.dart';
import '../../users/screens/pair_user_screen.dart';
import '../../vitals/screens/vitals_detail_widget.dart';
import '../../chat/screens/chat_screen_widget.dart';
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

    // 1. Watch Main Dashboard Mode (Users vs Devices)
    final viewMode = ref.watch(dashboardViewModeProvider);

    // 2. Watch User Selection States
    final selectedVital = ref.watch(selectedVitalProvider);
    final isPairingUser = ref.watch(isPairingUserProvider);

    // 3. [NEW] Watch Detail View Mode (Info vs Chat)
    final userDetailMode = ref.watch(userDetailViewModeProvider);

    Widget col2;
    Widget col3;

    if (viewMode == DashboardMode.devices) {
      // --- DEVICES MODE ---
      col2 = const DevicesScreen();
      col3 = const PairDevicesScreen();
    } else {
      // --- USER MODE ---
      col2 = const UserDashboard();

      // Dynamic Column 3 Logic:
      if (selectedVital != null) {
        // Priority 1: If a vital card is clicked, show the Graph
        col3 = const VitalsDetailWidget();
      } else if (isPairingUser) {
        // Priority 2: If pairing is active, show Pairing Screen
        col3 = const PairUserScreen();
      } else {
        // Priority 3: Check if we are in Chat Mode or Info Mode
        if (userDetailMode == UserDetailView.chat) {
          col3 = const ChatScreenWidget(); // Show Chat
        } else {
          col3 = const UserInformationWidget(); // Show Info (Default)
        }
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

          // Column 3: Dynamic (Info / Chat / Vitals) (Fixed Width)
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
