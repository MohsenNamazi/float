import 'package:drift/drift.dart';
import 'package:float/core/database/app_database.dart';
import 'package:float/features/decks/domain/entities/deck.dart';
import 'package:float/features/decks/domain/repositories/deck_repository.dart';

class DeckRepositoryImpl implements DeckRepository {
  const DeckRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Stream<List<Deck>> watchAll() => _db
      .select(_db.decks)
      .watch()
      .map((rows) => rows.map(_toEntity).toList());

  @override
  Future<List<Deck>> getAll() async {
    final rows = await _db.select(_db.decks).get();
    return rows.map(_toEntity).toList();
  }

  @override
  Future<Deck?> getById(int id) async {
    final row = await (_db.select(_db.decks)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row != null ? _toEntity(row) : null;
  }

  @override
  Future<int> create({
    required String name,
    required String colorThemeId,
  }) =>
      _db.into(_db.decks).insert(
            DecksCompanion.insert(
              name: name,
              colorThemeId: Value(colorThemeId),
            ),
          );

  @override
  Future<void> update(Deck deck) async {
    await (_db.update(_db.decks)..where((t) => t.id.equals(deck.id))).write(
      DecksCompanion(
        name: Value(deck.name),
        colorThemeId: Value(deck.colorThemeId),
      ),
    );
  }

  @override
  Future<void> deleteById(int id) async {
    await (_db.delete(_db.decks)..where((t) => t.id.equals(id))).go();
    // Cascade: delete all cards in this deck
    await (_db.delete(_db.flashcards)
          ..where((t) => t.deckId.equals(id)))
        .go();
  }

  Deck _toEntity(DeckRow row) => Deck(
        id: row.id,
        name: row.name,
        colorThemeId: row.colorThemeId,
        createdAt: row.createdAt,
      );
}
