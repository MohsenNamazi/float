import '../repositories/deck_repository.dart';

class DeleteDeckUseCase {
  const DeleteDeckUseCase(this._repository);
  final DeckRepository _repository;

  Future<void> call(int id) => _repository.deleteById(id);
}
