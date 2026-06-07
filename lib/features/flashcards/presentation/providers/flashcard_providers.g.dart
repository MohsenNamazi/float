// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$flashcardRepositoryHash() =>
    r'becc01c1fc2a51c4b4b3581c49a011be4dae80f7';

/// See also [flashcardRepository].
@ProviderFor(flashcardRepository)
final flashcardRepositoryProvider = Provider<FlashcardRepository>.internal(
  flashcardRepository,
  name: r'flashcardRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$flashcardRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FlashcardRepositoryRef = ProviderRef<FlashcardRepository>;
String _$flashcardsForDeckHash() => r'4852a2915e24d99b18ecd1b1b044076423f6a736';

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

/// See also [flashcardsForDeck].
@ProviderFor(flashcardsForDeck)
const flashcardsForDeckProvider = FlashcardsForDeckFamily();

/// See also [flashcardsForDeck].
class FlashcardsForDeckFamily extends Family<AsyncValue<List<Flashcard>>> {
  /// See also [flashcardsForDeck].
  const FlashcardsForDeckFamily();

  /// See also [flashcardsForDeck].
  FlashcardsForDeckProvider call(int deckId) {
    return FlashcardsForDeckProvider(deckId);
  }

  @override
  FlashcardsForDeckProvider getProviderOverride(
    covariant FlashcardsForDeckProvider provider,
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
  String? get name => r'flashcardsForDeckProvider';
}

/// See also [flashcardsForDeck].
class FlashcardsForDeckProvider
    extends AutoDisposeStreamProvider<List<Flashcard>> {
  /// See also [flashcardsForDeck].
  FlashcardsForDeckProvider(int deckId)
    : this._internal(
        (ref) => flashcardsForDeck(ref as FlashcardsForDeckRef, deckId),
        from: flashcardsForDeckProvider,
        name: r'flashcardsForDeckProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$flashcardsForDeckHash,
        dependencies: FlashcardsForDeckFamily._dependencies,
        allTransitiveDependencies:
            FlashcardsForDeckFamily._allTransitiveDependencies,
        deckId: deckId,
      );

  FlashcardsForDeckProvider._internal(
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
  Override overrideWith(
    Stream<List<Flashcard>> Function(FlashcardsForDeckRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FlashcardsForDeckProvider._internal(
        (ref) => create(ref as FlashcardsForDeckRef),
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
  AutoDisposeStreamProviderElement<List<Flashcard>> createElement() {
    return _FlashcardsForDeckProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FlashcardsForDeckProvider && other.deckId == deckId;
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
mixin FlashcardsForDeckRef on AutoDisposeStreamProviderRef<List<Flashcard>> {
  /// The parameter `deckId` of this provider.
  int get deckId;
}

class _FlashcardsForDeckProviderElement
    extends AutoDisposeStreamProviderElement<List<Flashcard>>
    with FlashcardsForDeckRef {
  _FlashcardsForDeckProviderElement(super.provider);

  @override
  int get deckId => (origin as FlashcardsForDeckProvider).deckId;
}

String _$flashcardActionsHash() => r'0fb5026bcdeaca6c511cce36a9d6e48081692c21';

/// See also [FlashcardActions].
@ProviderFor(FlashcardActions)
final flashcardActionsProvider =
    AutoDisposeNotifierProvider<FlashcardActions, void>.internal(
      FlashcardActions.new,
      name: r'flashcardActionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$flashcardActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FlashcardActions = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
