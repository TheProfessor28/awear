import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selection_providers.g.dart';

// Tracks the ID of the currently selected user (null if none)
@riverpod
class SelectedUserId extends _$SelectedUserId {
  @override
  int? build() => null;

  void select(int id) => state = id;
  void clear() => state = null;
}

// Tracks which vital card is selected (e.g., "Heart Rate", "Oxygen")
@riverpod
class SelectedVital extends _$SelectedVital {
  @override
  String? build() => null;

  void select(String vitalLabel) => state = vitalLabel;
  void clear() => state = null;
}

// Tracks if we are currently looking at the "Pair User" screen in Column 3
@riverpod
class IsPairingUser extends _$IsPairingUser {
  @override
  bool build() => false;

  void set(bool value) => state = value;
}

// --- CHAT FEATURE PROVIDER ---

// Enum for switching Column 3 between Vitals and Chat
enum UserDetailView { vitals, chat }

// Tracks the view mode for the User Details column
@riverpod
class UserDetailViewMode extends _$UserDetailViewMode {
  @override
  UserDetailView build() => UserDetailView.vitals;

  void set(UserDetailView view) => state = view;
}
