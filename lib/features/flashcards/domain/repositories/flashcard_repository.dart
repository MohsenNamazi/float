import '../entities/flashcard.dart';
import '../entities/fsrs_state.dart';

abstract interface class FlashcardRepository {
  Stream<List<Flashcard>> watchByDeck(int deckId);
  Future<List<Flashcard>> getByDeck(int deckId);
  Future<List<Flashcard>> getDueCards(int deckId);
  Future<List<Flashcard>> getNewCards(int deckId, {int limit = 20});
  Future<int> create({
    required int deckId,
    required String word,
    required String translation,
  });
  Future<void> updateAfterReview({
    required int id,
    required DateTime due,
    required double stability,
    required double difficulty,
    required int reps,
    required int lapses,
    required FsrsCardState state,
  });
  Future<void> deleteById(int id);
}
