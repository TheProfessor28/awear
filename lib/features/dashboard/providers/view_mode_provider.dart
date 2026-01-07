import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_mode_provider.g.dart';

enum DashboardMode {
  users, // Normal Mode: Col 2 = User Dashboard, Col 3 = Info/Vitals
  devices, // Admin Mode: Col 2 = Devices Screen, Col 3 = Pair Device
}

@riverpod
class DashboardViewMode extends _$DashboardViewMode {
  @override
  DashboardMode build() => DashboardMode.users;

  void setMode(DashboardMode mode) => state = mode;
}
