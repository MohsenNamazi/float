import '../entities/deck.dart';

abstract interface class DeckRepository {
  Stream<List<Deck>> watchAll();
  Future<List<Deck>> getAll();
  Future<Deck?> getById(int id);
  Future<int> create({required String name, required String colorThemeId});
  Future<void> update(Deck deck);
  Future<void> deleteById(int id);
}
