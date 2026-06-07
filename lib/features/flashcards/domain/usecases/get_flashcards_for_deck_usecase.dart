import '../entities/flashcard.dart';
import '../repositories/flashcard_repository.dart';

class GetFlashcardsForDeckUseCase {
  const GetFlashcardsForDeckUseCase(this._repository);
  final FlashcardRepository _repository;

  Stream<List<Flashcard>> call(int deckId) =>
      _repository.watchByDeck(deckId);
}
