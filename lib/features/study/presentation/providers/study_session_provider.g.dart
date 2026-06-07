// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$studySessionHash() => r'399980723e6d718c35d019a32f0719503a7953c3';

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

abstract class _$StudySession
    extends BuildlessAutoDisposeAsyncNotifier<StudySessionState> {
  late final int deckId;

  FutureOr<StudySessionState> build(int deckId);
}

/// See also [StudySession].
@ProviderFor(StudySession)
const studySessionProvider = StudySessionFamily();

/// See also [StudySession].
class StudySessionFamily extends Family<AsyncValue<StudySessionState>> {
  /// See also [StudySession].
  const StudySessionFamily();

  /// See also [StudySession].
  StudySessionProvider call(int deckId) {
    return StudySessionProvider(deckId);
  }

  @override
  StudySessionProvider getProviderOverride(
    covariant StudySessionProvider provider,
  ) {
    return call(provider.deckId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'studySessionProvider';
}

/// See also [StudySession].
class StudySessionProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<StudySession, StudySessionState> {
  /// See also [StudySession].
  StudySessionProvider(int deckId)
    : this._internal(
        () => StudySession()..deckId = deckId,
        from: studySessionProvider,
        name: r'studySessionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$studySessionHash,
        dependencies: StudySessionFamily._dependencies,
        allTransitiveDependencies:
            StudySessionFamily._allTransitiveDependencies,
        deckId: deckId,
      );

  StudySessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.deckId,
  }) : super.internal();

  final int deckId;

  @override
  FutureOr<StudySessionState> runNotifierBuild(
    covariant StudySession notifier,
  ) {
    return notifier.build(deckId);
  }

  @override
  Override overrideWith(StudySession Function() create) {
    return ProviderOverride(
      origin: this,
      override: StudySessionProvider._internal(
        () => create()..deckId = deckId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        deckId: deckId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<StudySession, StudySessionState>
  createElement() {
    return _StudySessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StudySessionProvider && other.deckId == deckId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deckId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StudySessionRef
    on AutoDisposeAsyncNotifierProviderRef<StudySessionState> {
  /// The parameter `deckId` of this provider.
  int get deckId;
}

class _StudySessionProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<StudySession, StudySessionState>
    with StudySessionRef {
  _StudySessionProviderElement(super.provider);

  @override
  int get deckId => (origin as StudySessionProvider).deckId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
