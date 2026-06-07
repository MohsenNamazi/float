import '../entities/deck.dart';
import '../repositories/deck_repository.dart';

class GetDecksUseCase {
  const GetDecksUseCase(this._repository);
  final DeckRepository _repository;

  Stream<List<Deck>> call() => _repository.watchAll();
}
