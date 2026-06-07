import '../repositories/flashcard_repository.dart';

class CreateFlashcardUseCase {
  const CreateFlashcardUseCase(this._repository);
  final FlashcardRepository _repository;

  Future<int> call({
    required int deckId,
    required String word,
    required String translation,
  }) =>
      _repository.create(deckId: deckId, word: word, translation: translation);
}
