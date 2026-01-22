// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatMessagesHash() => r'6220bb2ad3b5d11dd834e63c7cce07fe3afc3522';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [chatMessages].
@ProviderFor(chatMessages)
const chatMessagesProvider = ChatMessagesFamily();

/// See also [chatMessages].
class ChatMessagesFamily
    extends Family<AsyncValue<List<QueryDocumentSnapshot>>> {
  /// See also [chatMessages].
  const ChatMessagesFamily();

  /// See also [chatMessages].
  ChatMessagesProvider call(
    String studentId,
  ) {
    return ChatMessagesProvider(
      studentId,
    );
  }

  @override
  ChatMessagesProvider getProviderOverride(
    covariant ChatMessagesProvider provider,
  ) {
    return call(
      provider.studentId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatMessagesProvider';
}

/// See also [chatMessages].
class ChatMessagesProvider
    extends AutoDisposeStreamProvider<List<QueryDocumentSnapshot>> {
  /// See also [chatMessages].
  ChatMessagesProvider(
    String studentId,
  ) : this._internal(
          (ref) => chatMessages(
            ref as ChatMessagesRef,
            studentId,
          ),
          from: chatMessagesProvider,
          name: r'chatMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatMessagesHash,
          dependencies: ChatMessagesFamily._dependencies,
          allTransitiveDependencies:
              ChatMessagesFamily._allTransitiveDependencies,
          studentId: studentId,
        );

  ChatMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentId,
  }) : super.internal();

  final String studentId;

  @override
  Override overrideWith(
    Stream<List<QueryDocumentSnapshot>> Function(ChatMessagesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatMessagesProvider._internal(
        (ref) => create(ref as ChatMessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentId: studentId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<QueryDocumentSnapshot>>
      createElement() {
    return _ChatMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMessagesProvider && other.studentId == studentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatMessagesRef
    on AutoDisposeStreamProviderRef<List<QueryDocumentSnapshot>> {
  /// The parameter `studentId` of this provider.
  String get studentId;
}

class _ChatMessagesProviderElement
    extends AutoDisposeStreamProviderElement<List<QueryDocumentSnapshot>>
    with ChatMessagesRef {
  _ChatMessagesProviderElement(super.provider);

  @override
  String get studentId => (origin as ChatMessagesProvider).studentId;
}

String _$unreadMessageCountHash() =>
    r'90d8a38d7e6e2e5b6a1c2d137c099e35ce2fe25f';

/// See also [unreadMessageCount].
@ProviderFor(unreadMessageCount)
const unreadMessageCountProvider = UnreadMessageCountFamily();

/// See also [unreadMessageCount].
class UnreadMessageCountFamily extends Family<AsyncValue<int>> {
  /// See also [unreadMessageCount].
  const UnreadMessageCountFamily();

  /// See also [unreadMessageCount].
  UnreadMessageCountProvider call(
    String studentId,
  ) {
    return UnreadMessageCountProvider(
      studentId,
    );
  }

  @override
  UnreadMessageCountProvider getProviderOverride(
    covariant UnreadMessageCountProvider provider,
  ) {
    return call(
      provider.studentId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'unreadMessageCountProvider';
}

/// See also [unreadMessageCount].
class UnreadMessageCountProvider extends AutoDisposeStreamProvider<int> {
  /// See also [unreadMessageCount].
  UnreadMessageCountProvider(
    String studentId,
  ) : this._internal(
          (ref) => unreadMessageCount(
            ref as UnreadMessageCountRef,
            studentId,
          ),
          from: unreadMessageCountProvider,
          name: r'unreadMessageCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$unreadMessageCountHash,
          dependencies: UnreadMessageCountFamily._dependencies,
          allTransitiveDependencies:
              UnreadMessageCountFamily._allTransitiveDependencies,
          studentId: studentId,
        );

  UnreadMessageCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentId,
  }) : super.internal();

  final String studentId;

  @override
  Override overrideWith(
    Stream<int> Function(UnreadMessageCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UnreadMessageCountProvider._internal(
        (ref) => create(ref as UnreadMessageCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentId: studentId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<int> createElement() {
    return _UnreadMessageCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UnreadMessageCountProvider && other.studentId == studentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UnreadMessageCountRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `studentId` of this provider.
  String get studentId;
}

class _UnreadMessageCountProviderElement
    extends AutoDisposeStreamProviderElement<int> with UnreadMessageCountRef {
  _UnreadMessageCountProviderElement(super.provider);

  @override
  String get studentId => (origin as UnreadMessageCountProvider).studentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
