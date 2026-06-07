import 'package:flutter_test/flutter_test.dart';
import 'package:float/features/flashcards/domain/entities/flashcard.dart';
import 'package:float/features/flashcards/domain/entities/fsrs_state.dart';
import 'package:float/features/study/domain/services/fsrs_engine.dart';

// ── Helpers ─────────────────────────────────────────────────────────────────

Flashcard _newCard({int id = 1, int deckId = 1}) => Flashcard(
      id: id,
      deckId: deckId,
      word: 'Bonjour',
      translation: 'Hello',
      createdAt: DateTime.utc(2025),
      due: DateTime.now().toUtc(),
      stability: 0,
      difficulty: 5,
      reps: 0,
      lapses: 0,
      state: FsrsCardState.newCard,
    );

Flashcard _reviewCard({
  required double stability,
  required double difficulty,
  required int reps,
  required int lapses,
  DateTime? due,
}) =>
    Flashcard(
      id: 1,
      deckId: 1,
      word: 'Bonjour',
      translation: 'Hello',
      createdAt: DateTime.utc(2025),
      due: due ?? DateTime.now().toUtc().subtract(const Duration(days: 1)),
      stability: stability,
      difficulty: difficulty,
      reps: reps,
      lapses: lapses,
      state: FsrsCardState.review,
    );

// ── Tests ────────────────────────────────────────────────────────────────────

void main() {
  const engine = FsrsEngine();

  // ── retrievability ─────────────────────────────────────────────────────────
  group('retrievability()', () {
    test('returns 1.0 on the day of review (elapsed = 0)', () {
      expect(engine.retrievability(10, 0), closeTo(1.0, 0.0001));
    });

    test('returns exactly targetRetention when elapsed == stability', () {
      // R = 0.9^(S/S) = 0.9
      expect(engine.retrievability(7, 7), closeTo(0.9, 0.001));
    });

    test('decreases as elapsed days increase beyond stability', () {
      final r1 = engine.retrievability(10, 5);
      final r2 = engine.retrievability(10, 10);
      final r3 = engine.retrievability(10, 20);
      expect(r1, greaterThan(r2));
      expect(r2, greaterThan(r3));
    });

    test('returns 0 for zero stability', () {
      expect(engine.retrievability(0, 5), 0.0);
    });

    test('is bounded between 0 and 1', () {
      for (final days in [0.0, 1.0, 10.0, 100.0]) {
        final r = engine.retrievability(5, days);
        expect(r, inInclusiveRange(0.0, 1.0));
      }
    });
  });

  // ── New card — initial review ───────────────────────────────────────────────
  group('review() — new card', () {
    test('Again → learning state, very short interval (1 min)', () {
      final card = _newCard();
      final result = engine.review(card: card, rating: FsrsRating.again);

      expect(result.state, FsrsCardState.learning);
      expect(result.reps, 1);
      expect(result.lapses, 0);
      // Due should be ~1 minute from now
      expect(
        result.due.difference(DateTime.now().toUtc()).inSeconds,
        inInclusiveRange(50, 70),
      );
    });

    test('Hard → learning state, ~5 min interval', () {
      final result = engine.review(card: _newCard(), rating: FsrsRating.hard);
      expect(result.state, FsrsCardState.learning);
      expect(result.due.difference(DateTime.now().toUtc()).inSeconds,
          inInclusiveRange(280, 310));
    });

    test('Good → learning state, ~10 min interval', () {
      final result = engine.review(card: _newCard(), rating: FsrsRating.good);
      expect(result.state, FsrsCardState.learning);
      expect(result.due.difference(DateTime.now().toUtc()).inSeconds,
          inInclusiveRange(580, 620));
    });

    test('Easy → review state, day-level interval', () {
      final result = engine.review(card: _newCard(), rating: FsrsRating.easy);
      expect(result.state, FsrsCardState.review);
      expect(result.due.isAfter(DateTime.now().toUtc()), isTrue);
      final daysUntilDue = result.due
          .difference(DateTime.now().toUtc())
          .inHours;
      expect(daysUntilDue, greaterThan(20)); // at least ~1 day
    });

    test('stability is positive for all ratings', () {
      for (final rating in FsrsRating.values) {
        final r = engine.review(card: _newCard(), rating: rating);
        expect(r.stability, greaterThan(0));
      }
    });

    test('difficulty is clamped between 1 and 10 for all ratings', () {
      for (final rating in FsrsRating.values) {
        final r = engine.review(card: _newCard(), rating: rating);
        expect(r.difficulty, inInclusiveRange(1.0, 10.0));
      }
    });

    test('reps increments from 0 to 1 on first review', () {
      final r = engine.review(card: _newCard(), rating: FsrsRating.good);
      expect(r.reps, 1);
    });

    test('lapses stay 0 on first review even for Again', () {
      final r = engine.review(card: _newCard(), rating: FsrsRating.again);
      expect(r.lapses, 0);
    });

    test('Easy produces higher stability than Good', () {
      final easy = engine.review(card: _newCard(), rating: FsrsRating.easy);
      final good = engine.review(card: _newCard(), rating: FsrsRating.good);
      expect(easy.stability, greaterThan(good.stability));
    });

    test('Good produces higher stability than Hard', () {
      final good = engine.review(card: _newCard(), rating: FsrsRating.good);
      final hard = engine.review(card: _newCard(), rating: FsrsRating.hard);
      expect(good.stability, greaterThan(hard.stability));
    });
  });

  // ── Existing card — recall (remembered) ────────────────────────────────────
  group('review() — existing card recalled', () {
    test('Good recall increases stability', () {
      final card = _reviewCard(stability: 5, difficulty: 5, reps: 3, lapses: 0);
      final result = engine.review(card: card, rating: FsrsRating.good);
      expect(result.stability, greaterThan(card.stability));
    });

    test('state remains review after Good recall', () {
      final card = _reviewCard(stability: 5, difficulty: 5, reps: 3, lapses: 0);
      final result = engine.review(card: card, rating: FsrsRating.good);
      expect(result.state, FsrsCardState.review);
    });

    test('Easy gives bigger stability boost than Good', () {
      final card = _reviewCard(stability: 5, difficulty: 5, reps: 3, lapses: 0);
      final easy = engine.review(card: card, rating: FsrsRating.easy);
      final good = engine.review(card: card, rating: FsrsRating.good);
      expect(easy.stability, greaterThan(good.stability));
    });

    test('Hard gives smaller stability boost than Good', () {
      final card = _reviewCard(stability: 5, difficulty: 5, reps: 3, lapses: 0);
      final hard = engine.review(card: card, rating: FsrsRating.hard);
      final good = engine.review(card: card, rating: FsrsRating.good);
      expect(hard.stability, lessThan(good.stability));
    });

    test('lapses do not increase on recall', () {
      final card = _reviewCard(stability: 5, difficulty: 5, reps: 3, lapses: 1);
      final result = engine.review(card: card, rating: FsrsRating.good);
      expect(result.lapses, 1);
    });

    test('reps increments on recall', () {
      final card = _reviewCard(stability: 5, difficulty: 5, reps: 3, lapses: 0);
      final result = engine.review(card: card, rating: FsrsRating.good);
      expect(result.reps, 4);
    });

    test('difficulty decreases toward median on Easy', () {
      // High-difficulty card rated Easy should drift toward median
      final card =
          _reviewCard(stability: 5, difficulty: 9, reps: 5, lapses: 0);
      final result = engine.review(card: card, rating: FsrsRating.easy);
      expect(result.difficulty, lessThan(card.difficulty));
    });

    test('difficulty increases toward median on Hard', () {
      // Low-difficulty card rated Hard should drift toward median
      final card =
          _reviewCard(stability: 5, difficulty: 2, reps: 5, lapses: 0);
      final result = engine.review(card: card, rating: FsrsRating.hard);
      expect(result.difficulty, greaterThan(card.difficulty));
    });

    test('due date is in the future after recall', () {
      final card = _reviewCard(stability: 5, difficulty: 5, reps: 3, lapses: 0);
      final result = engine.review(card: card, rating: FsrsRating.good);
      expect(result.due.isAfter(DateTime.now().toUtc()), isTrue);
    });
  });

  // ── Existing card — forgot (Again) ─────────────────────────────────────────
  group('review() — forgotten card (Again)', () {
    test('Again → relearning state', () {
      final card = _reviewCard(stability: 10, difficulty: 5, reps: 5, lapses: 0);
      final result = engine.review(card: card, rating: FsrsRating.again);
      expect(result.state, FsrsCardState.relearning);
    });

    test('lapses increments by 1 on Again', () {
      final card = _reviewCard(stability: 10, difficulty: 5, reps: 5, lapses: 2);
      final result = engine.review(card: card, rating: FsrsRating.again);
      expect(result.lapses, 3);
    });

    test('stability resets to a lower value after forgetting', () {
      final card = _reviewCard(stability: 20, difficulty: 5, reps: 5, lapses: 0);
      final result = engine.review(card: card, rating: FsrsRating.again);
      expect(result.stability, lessThan(card.stability));
    });

    test('stability after forgetting is still positive', () {
      final card = _reviewCard(stability: 10, difficulty: 5, reps: 3, lapses: 0);
      final result = engine.review(card: card, rating: FsrsRating.again);
      expect(result.stability, greaterThan(0));
    });

    test('difficulty clamped to max 10 even after many forgettings', () {
      var card = _reviewCard(stability: 5, difficulty: 9.5, reps: 3, lapses: 5);
      for (var i = 0; i < 10; i++) {
        final r = engine.review(card: card, rating: FsrsRating.again);
        card = card.copyWith(
          difficulty: r.difficulty,
          stability: r.stability,
          reps: r.reps,
          lapses: r.lapses,
          state: r.state,
        );
      }
      expect(card.difficulty, inInclusiveRange(1.0, 10.0));
    });

    test('next due date is set after forgotten card', () {
      final card = _reviewCard(stability: 10, difficulty: 5, reps: 5, lapses: 0);
      final result = engine.review(card: card, rating: FsrsRating.again);
      expect(result.due.isAfter(DateTime.now().toUtc()), isTrue);
    });
  });

  // ── Stability invariants ───────────────────────────────────────────────────
  group('stability invariants', () {
    test('stability grows monotonically with consecutive Good reviews', () {
      var card = _newCard();
      var prevStability = 0.0;

      for (var i = 0; i < 5; i++) {
        final result = engine.review(card: card, rating: FsrsRating.good);
        if (result.state == FsrsCardState.review) {
          expect(result.stability, greaterThan(prevStability));
        }
        prevStability = result.stability;
        card = card.copyWith(
          stability: result.stability,
          difficulty: result.difficulty,
          reps: result.reps,
          lapses: result.lapses,
          state: result.state,
          due: result.due,
        );
      }
    });

    test('interval minimum is at least 1 day for review cards', () {
      for (final rating in [FsrsRating.hard, FsrsRating.good, FsrsRating.easy]) {
        final card =
            _reviewCard(stability: 0.1, difficulty: 5, reps: 3, lapses: 0);
        final result = engine.review(card: card, rating: rating);
        final hours = result.due.difference(DateTime.now().toUtc()).inHours;
        expect(hours, greaterThanOrEqualTo(23),
            reason: 'rating $rating produced sub-1-day interval');
      }
    });
  });
}
