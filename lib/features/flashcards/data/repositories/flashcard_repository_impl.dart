import 'package:drift/drift.dart';
import 'package:float/core/database/app_database.dart';
import 'package:float/features/flashcards/domain/entities/flashcard.dart';
import 'package:float/features/flashcards/domain/entities/fsrs_state.dart';
import 'package:float/features/flashcards/domain/repositories/flashcard_repository.dart';

class FlashcardRepositoryImpl implements FlashcardRepository {
  const FlashcardRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Stream<List<Flashcard>> watchByDeck(int deckId) => (_db.select(_db.flashcards)
        ..where((t) => t.deckId.equals(deckId))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .watch()
      .map((rows) => rows.map(_toEntity).toList());

  @override
  Future<List<Flashcard>> getByDeck(int deckId) async {
    final rows = await (_db.select(_db.flashcards)
          ..where((t) => t.deckId.equals(deckId)))
        .get();
    return rows.map(_toEntity).toList();
  }

  @override
  Future<List<Flashcard>> getDueCards(int deckId) async {
    final now = DateTime.now().toUtc();
    final rows = await (_db.select(_db.flashcards)
          ..where(
            (t) =>
                t.deckId.equals(deckId) &
                t.state.isNotIn(const [0]) & // not newCard
                t.due.isSmallerOrEqualValue(now),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.due)]))
        .get();
    return rows.map(_toEntity).toList();
  }

  @override
  Future<List<Flashcard>> getNewCards(int deckId, {int limit = 20}) async {
    final rows = await (_db.select(_db.flashcards)
          ..where(
            (t) => t.deckId.equals(deckId) & t.state.equals(0),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
    return rows.map(_toEntity).toList();
  }

  @override
  Future<int> create({
    required int deckId,
    required String word,
    required String translation,
  }) =>
      _db.into(_db.flashcards).insert(
            FlashcardsCompanion.insert(
              deckId: deckId,
              word: word,
              translation: translation,
            ),
          );

  @override
  Future<void> updateAfterReview({
    required int id,
    required DateTime due,
    required double stability,
    required double difficulty,
    required int reps,
    required int lapses,
    required FsrsCardState state,
  }) async {
    await (_db.update(_db.flashcards)..where((t) => t.id.equals(id))).write(
      FlashcardsCompanion(
        due: Value(due),
        stability: Value(stability),
        difficulty: Value(difficulty),
        reps: Value(reps),
        lapses: Value(lapses),
        state: Value(state.index),
      ),
    );
  }

  @override
  Future<void> deleteById(int id) async {
    await (_db.delete(_db.flashcards)..where((t) => t.id.equals(id))).go();
  }

  Flashcard _toEntity(FlashcardRow row) => Flashcard(
        id: row.id,
        deckId: row.deckId,
        word: row.word,
        translation: row.translation,
        createdAt: row.createdAt,
        due: row.due,
        stability: row.stability,
        difficulty: row.difficulty,
        reps: row.reps,
        lapses: row.lapses,
        state: FsrsCardState.fromIndex(row.state),
      );
}
