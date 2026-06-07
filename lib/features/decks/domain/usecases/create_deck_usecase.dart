import '../repositories/deck_repository.dart';

class CreateDeckUseCase {
  const CreateDeckUseCase(this._repository);
  final DeckRepository _repository;

  Future<int> call({required String name, required String colorThemeId}) =>
      _repository.create(name: name, colorThemeId: colorThemeId);
}
