import 'package:flutter_test/flutter_test.dart';
import 'package:float/features/flashcards/domain/entities/flashcard.dart';
import 'package:float/features/flashcards/domain/entities/fsrs_state.dart';
import 'package:float/features/flashcards/domain/repositories/flashcard_repository.dart';

// ── In-memory fake ────────────────────────────────────────────────────────────

class FakeFlashcardRepository implements FlashcardRepository {
  final List<Flashcard> _cards = [];
  int _nextId = 1;

  @override
  Stream<List<Flashcard>> watchByDeck(int deckId) =>
      Stream.value(_cards.where((c) => c.deckId == deckId).toList());

  @override
  Future<List<Flashcard>> getByDeck(int deckId) async =>
      _cards.where((c) => c.deckId == deckId).toList();

  @override
  Future<List<Flashcard>> getDueCards(int deckId) async {
    final now = DateTime.now().toUtc();
    return _cards
        .where((c) =>
            c.deckId == deckId &&
            c.state != FsrsCardState.newCard &&
            c.due.isBefore(now))
        .toList()
      ..sort((a, b) => a.due.compareTo(b.due));
  }

  @override
  Future<List<Flashcard>> getNewCards(int deckId, {int limit = 20}) async =>
      _cards
          .where((c) => c.deckId == deckId && c.state == FsrsCardState.newCard)
          .take(limit)
          .toList();

  @override
  Future<int> create({
    required int deckId,
    required String word,
    required String translation,
  }) async {
    final id = _nextId++;
    _cards.add(Flashcard(
      id: id,
      deckId: deckId,
      word: word,
      translation: translation,
      createdAt: DateTime.now().toUtc(),
      due: DateTime.now().toUtc(),
      stability: 0,
      difficulty: 5,
      reps: 0,
      lapses: 0,
      state: FsrsCardState.newCard,
    ));
    return id;
  }

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
    final idx = _cards.indexWhere((c) => c.id == id);
    if (idx == -1) return;
    _cards[idx] = _cards[idx].copyWith(
      due: due,
      stability: stability,
      difficulty: difficulty,
      reps: reps,
      lapses: lapses,
      state: state,
    );
  }

  @override
  Future<void> deleteById(int id) async {
    _cards.removeWhere((c) => c.id == id);
  }
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late FakeFlashcardRepository repo;

  setUp(() => repo = FakeFlashcardRepository());

  group('create()', () {
    test('assigns auto-incrementing ids', () async {
      final id1 = await repo.create(deckId: 1, word: 'a', translation: 'A');
      final id2 = await repo.create(deckId: 1, word: 'b', translation: 'B');
      expect(id1, 1);
      expect(id2, 2);
    });

    test('new card defaults to newCard state', () async {
      await repo.create(deckId: 1, word: 'hello', translation: 'Hola');
      final cards = await repo.getByDeck(1);
      expect(cards.first.state, FsrsCardState.newCard);
    });

    test('creates cards in correct deck', () async {
      await repo.create(deckId: 1, word: 'a', translation: 'A');
      await repo.create(deckId: 2, word: 'b', translation: 'B');
      expect((await repo.getByDeck(1)).length, 1);
      expect((await repo.getByDeck(2)).length, 1);
    });
  });

  group('getByDeck()', () {
    test('returns empty list for unknown deck', () async {
      expect(await repo.getByDeck(99), isEmpty);
    });

    test('returns all cards for a given deck', () async {
      await repo.create(deckId: 1, word: 'a', translation: 'A');
      await repo.create(deckId: 1, word: 'b', translation: 'B');
      expect((await repo.getByDeck(1)).length, 2);
    });
  });

  group('getDueCards()', () {
    test('excludes newCard state cards', () async {
      await repo.create(deckId: 1, word: 'a', translation: 'A');
      expect(await repo.getDueCards(1), isEmpty);
    });

    test('returns review cards with past due date', () async {
      final id = await repo.create(deckId: 1, word: 'a', translation: 'A');
      await repo.updateAfterReview(
        id: id,
        due: DateTime.now().toUtc().subtract(const Duration(hours: 1)),
        stability: 5,
        difficulty: 5,
        reps: 1,
        lapses: 0,
        state: FsrsCardState.review,
      );
      expect((await repo.getDueCards(1)).length, 1);
    });

    test('excludes review cards with future due date', () async {
      final id = await repo.create(deckId: 1, word: 'a', translation: 'A');
      await repo.updateAfterReview(
        id: id,
        due: DateTime.now().toUtc().add(const Duration(days: 3)),
        stability: 5,
        difficulty: 5,
        reps: 1,
        lapses: 0,
        state: FsrsCardState.review,
      );
      expect(await repo.getDueCards(1), isEmpty);
    });

    test('returns cards sorted by due date ascending', () async {
      for (var i = 0; i < 3; i++) {
        final id =
            await repo.create(deckId: 1, word: 'w$i', translation: 't$i');
        await repo.updateAfterReview(
          id: id,
          due: DateTime.now()
              .toUtc()
              .subtract(Duration(hours: (3 - i) * 10)),
          stability: 5,
          difficulty: 5,
          reps: 1,
          lapses: 0,
          state: FsrsCardState.review,
        );
      }
      final due = await repo.getDueCards(1);
      for (var i = 0; i < due.length - 1; i++) {
        expect(due[i].due.isBefore(due[i + 1].due), isTrue);
      }
    });
  });

  group('getNewCards()', () {
    test('respects the limit parameter', () async {
      for (var i = 0; i < 30; i++) {
        await repo.create(deckId: 1, word: 'w$i', translation: 't$i');
      }
      expect((await repo.getNewCards(1, limit: 10)).length, 10);
    });

    test('default limit is 20', () async {
      for (var i = 0; i < 25; i++) {
        await repo.create(deckId: 1, word: 'w$i', translation: 't$i');
      }
      expect((await repo.getNewCards(1)).length, 20);
    });

    test('excludes cards that are no longer new', () async {
      final id = await repo.create(deckId: 1, word: 'a', translation: 'A');
      await repo.create(deckId: 1, word: 'b', translation: 'B');
      await repo.updateAfterReview(
        id: id,
        due: DateTime.now().toUtc().add(const Duration(days: 1)),
        stability: 2,
        difficulty: 5,
        reps: 1,
        lapses: 0,
        state: FsrsCardState.review,
      );
      expect((await repo.getNewCards(1)).length, 1);
    });
  });

  group('updateAfterReview()', () {
    test('updates all FSRS fields correctly', () async {
      final id = await repo.create(deckId: 1, word: 'a', translation: 'A');
      final due = DateTime.utc(2026, 1, 15);
      await repo.updateAfterReview(
        id: id,
        due: due,
        stability: 7.5,
        difficulty: 4.2,
        reps: 2,
        lapses: 1,
        state: FsrsCardState.review,
      );
      final card = (await repo.getByDeck(1)).first;
      expect(card.due, due);
      expect(card.stability, closeTo(7.5, 0.001));
      expect(card.difficulty, closeTo(4.2, 0.001));
      expect(card.reps, 2);
      expect(card.lapses, 1);
      expect(card.state, FsrsCardState.review);
    });

    test('silently ignores unknown card id', () async {
      await expectLater(
        repo.updateAfterReview(
          id: 999,
          due: DateTime.now().toUtc(),
          stability: 5,
          difficulty: 5,
          reps: 1,
          lapses: 0,
          state: FsrsCardState.review,
        ),
        completes,
      );
    });
  });

  group('deleteById()', () {
    test('removes the card', () async {
      final id = await repo.create(deckId: 1, word: 'a', translation: 'A');
      await repo.deleteById(id);
      expect(await repo.getByDeck(1), isEmpty);
    });

    test('only removes the targeted card', () async {
      final id1 = await repo.create(deckId: 1, word: 'a', translation: 'A');
      await repo.create(deckId: 1, word: 'b', translation: 'B');
      await repo.deleteById(id1);
      final remaining = await repo.getByDeck(1);
      expect(remaining.length, 1);
      expect(remaining.first.word, 'b');
    });

    test('silently ignores unknown id', () async {
      await expectLater(repo.deleteById(999), completes);
    });
  });

  group('watchByDeck()', () {
    test('emits current card list as a stream', () async {
      await repo.create(deckId: 1, word: 'a', translation: 'A');
      final stream = repo.watchByDeck(1);
      final snapshot = await stream.first;
      expect(snapshot.length, 1);
    });

    test('emits empty list for unknown deck', () async {
      final snapshot = await repo.watchByDeck(99).first;
      expect(snapshot, isEmpty);
    });
  });
}
