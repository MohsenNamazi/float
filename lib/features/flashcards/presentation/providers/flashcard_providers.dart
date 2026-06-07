import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:float/core/providers/database_provider.dart';
import 'package:float/features/flashcards/data/repositories/flashcard_repository_impl.dart';
import 'package:float/features/flashcards/domain/entities/flashcard.dart';
import 'package:float/features/flashcards/domain/repositories/flashcard_repository.dart';
import 'package:float/features/flashcards/domain/usecases/create_flashcard_usecase.dart';
import 'package:float/features/flashcards/domain/usecases/get_flashcards_for_deck_usecase.dart';

part 'flashcard_providers.g.dart';

@Riverpod(keepAlive: true)
FlashcardRepository flashcardRepository(FlashcardRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return FlashcardRepositoryImpl(db);
}

@riverpod
Stream<List<Flashcard>> flashcardsForDeck(FlashcardsForDeckRef ref, int deckId) {
  final useCase =
      GetFlashcardsForDeckUseCase(ref.watch(flashcardRepositoryProvider));
  return useCase(deckId);
}

@riverpod
class FlashcardActions extends _$FlashcardActions {
  @override
  void build() {}

  Future<void> createCard({
    required int deckId,
    required String word,
    required String translation,
  }) async {
    final useCase =
        CreateFlashcardUseCase(ref.read(flashcardRepositoryProvider));
    await useCase(deckId: deckId, word: word, translation: translation);
  }
}
