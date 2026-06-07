import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:float/core/providers/database_provider.dart';
import 'package:float/features/decks/data/repositories/deck_repository_impl.dart';
import 'package:float/features/decks/domain/entities/deck.dart';
import 'package:float/features/decks/domain/repositories/deck_repository.dart';
import 'package:float/features/decks/domain/usecases/create_deck_usecase.dart';
import 'package:float/features/decks/domain/usecases/delete_deck_usecase.dart';
import 'package:float/features/decks/domain/usecases/get_decks_usecase.dart';

part 'deck_providers.g.dart';

@Riverpod(keepAlive: true)
DeckRepository deckRepository(DeckRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return DeckRepositoryImpl(db);
}

@riverpod
Stream<List<Deck>> decksStream(DecksStreamRef ref) {
  final useCase = GetDecksUseCase(ref.watch(deckRepositoryProvider));
  return useCase();
}

@riverpod
class DeckActions extends _$DeckActions {
  @override
  void build() {}

  Future<void> createDeck({
    required String name,
    required String colorThemeId,
  }) async {
    final useCase = CreateDeckUseCase(ref.read(deckRepositoryProvider));
    await useCase(name: name, colorThemeId: colorThemeId);
  }

  Future<void> deleteDeck(int id) async {
    final useCase = DeleteDeckUseCase(ref.read(deckRepositoryProvider));
    await useCase(id);
  }
}
