// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deckRepositoryHash() => r'76680a19e92e402695ee51db218d59370cd8f84e';

/// See also [deckRepository].
@ProviderFor(deckRepository)
final deckRepositoryProvider = Provider<DeckRepository>.internal(
  deckRepository,
  name: r'deckRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deckRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeckRepositoryRef = ProviderRef<DeckRepository>;
String _$decksStreamHash() => r'a15ad6901549baf7db7337e1d4976d5c4e398e94';

/// See also [decksStream].
@ProviderFor(decksStream)
final decksStreamProvider = AutoDisposeStreamProvider<List<Deck>>.internal(
  decksStream,
  name: r'decksStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$decksStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DecksStreamRef = AutoDisposeStreamProviderRef<List<Deck>>;
String _$deckActionsHash() => r'29e6b74b677265eb003cec3b5fb5916260201f0a';

/// See also [DeckActions].
@ProviderFor(DeckActions)
final deckActionsProvider =
    AutoDisposeNotifierProvider<DeckActions, void>.internal(
      DeckActions.new,
      name: r'deckActionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$deckActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DeckActions = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
