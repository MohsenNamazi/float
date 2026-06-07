import 'package:flutter_test/flutter_test.dart';
import 'package:float/features/decks/domain/entities/deck.dart';
import 'package:float/features/flashcards/domain/entities/flashcard.dart';
import 'package:float/features/flashcards/domain/entities/fsrs_state.dart';
import 'package:float/features/study/domain/entities/study_card.dart';

// ── Helpers ──────────────────────────────────────────────────────────────────

Flashcard _card({
  FsrsCardState state = FsrsCardState.newCard,
  DateTime? due,
}) =>
    Flashcard(
      id: 1,
      deckId: 1,
      word: 'w',
      translation: 't',
      createdAt: DateTime.utc(2025),
      due: due ?? DateTime.now().toUtc(),
      stability: 0,
      difficulty: 5,
      reps: 0,
      lapses: 0,
      state: state,
    );

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  // ── FsrsCardState ──────────────────────────────────────────────────────────
  group('FsrsCardState', () {
    test('isNew is true only for newCard', () {
      expect(FsrsCardState.newCard.isNew, isTrue);
      expect(FsrsCardState.learning.isNew, isFalse);
      expect(FsrsCardState.review.isNew, isFalse);
      expect(FsrsCardState.relearning.isNew, isFalse);
    });

    test('isDue is true for learning, review, relearning', () {
      expect(FsrsCardState.newCard.isDue, isFalse);
      expect(FsrsCardState.learning.isDue, isTrue);
      expect(FsrsCardState.review.isDue, isTrue);
      expect(FsrsCardState.relearning.isDue, isTrue);
    });

    test('fromIndex round-trips all enum values', () {
      for (final v in FsrsCardState.values) {
        expect(FsrsCardState.fromIndex(v.index), v);
      }
    });

    test('fromIndex clamps out-of-range indices to newCard', () {
      expect(FsrsCardState.fromIndex(-1), FsrsCardState.newCard);
      expect(FsrsCardState.fromIndex(999), FsrsCardState.relearning);
    });
  });

  // ── FsrsRating ─────────────────────────────────────────────────────────────
  group('FsrsRating', () {
    test('values are 1-4', () {
      expect(FsrsRating.again.value, 1);
      expect(FsrsRating.hard.value, 2);
      expect(FsrsRating.good.value, 3);
      expect(FsrsRating.easy.value, 4);
    });

    test('label returns non-empty string for every rating', () {
      for (final r in FsrsRating.values) {
        expect(r.label, isNotEmpty);
      }
    });
  });

  // ── Flashcard ──────────────────────────────────────────────────────────────
  group('Flashcard', () {
    test('isNew is true when state == newCard', () {
      expect(_card(state: FsrsCardState.newCard).isNew, isTrue);
    });

    test('isNew is false for other states', () {
      for (final s in [
        FsrsCardState.learning,
        FsrsCardState.review,
        FsrsCardState.relearning
      ]) {
        expect(_card(state: s).isNew, isFalse);
      }
    });

    test('isDue is false for newCard regardless of due date', () {
      final card = _card(
        state: FsrsCardState.newCard,
        due: DateTime.now().toUtc().subtract(const Duration(days: 10)),
      );
      expect(card.isDue, isFalse);
    });

    test('isDue is true for review card with past due date', () {
      final card = _card(
        state: FsrsCardState.review,
        due: DateTime.now().toUtc().subtract(const Duration(minutes: 1)),
      );
      expect(card.isDue, isTrue);
    });

    test('isDue is false for review card with future due date', () {
      final card = _card(
        state: FsrsCardState.review,
        due: DateTime.now().toUtc().add(const Duration(days: 3)),
      );
      expect(card.isDue, isFalse);
    });

    test('copyWith preserves all fields when nothing changes', () {
      final card = _card(state: FsrsCardState.review);
      final copy = card.copyWith();
      expect(copy, card);
    });

    test('copyWith updates only the specified field', () {
      final card = _card();
      final updated = card.copyWith(word: 'Hola');
      expect(updated.word, 'Hola');
      expect(updated.translation, card.translation);
      expect(updated.id, card.id);
    });

    test('equality holds for identical cards', () {
      // Use fixed timestamps so both instances compare equal
      final fixed = DateTime.utc(2025, 6, 1, 12);
      final a = _card().copyWith(createdAt: fixed, due: fixed);
      final b = _card().copyWith(createdAt: fixed, due: fixed);
      expect(a, b);
    });

    test('equality fails when word differs', () {
      final a = _card();
      final b = a.copyWith(word: 'Different');
      expect(a, isNot(b));
    });
  });

  // ── Deck ───────────────────────────────────────────────────────────────────
  group('Deck', () {
    final deck = Deck(
      id: 1,
      name: 'Spanish',
      colorThemeId: 'pastelOcean',
      createdAt: DateTime.utc(2025),
    );

    test('copyWith updates name only', () {
      final updated = deck.copyWith(name: 'French');
      expect(updated.name, 'French');
      expect(updated.id, deck.id);
      expect(updated.colorThemeId, deck.colorThemeId);
    });

    test('equality holds for identical decks', () {
      final a = Deck(
          id: 1, name: 'A', colorThemeId: 'x', createdAt: DateTime.utc(2025));
      final b = Deck(
          id: 1, name: 'A', colorThemeId: 'x', createdAt: DateTime.utc(2025));
      expect(a, b);
    });

    test('decks with different ids are not equal', () {
      final a = deck;
      final b = deck.copyWith(id: 99);
      expect(a, isNot(b));
    });
  });

  // ── StudySessionState ──────────────────────────────────────────────────────
  group('StudySessionState', () {
    StudyCard _studyCard(int id) => StudyCard(
          flashcard: _card().copyWith(id: id),
          isNew: true,
        );

    test('currentCard returns first card when index is 0', () {
      final queue = [_studyCard(1), _studyCard(2)];
      final state = StudySessionState(
          queue: queue, currentIndex: 0, isFlipped: false, isComplete: false);
      expect(state.currentCard?.flashcard.id, 1);
    });

    test('currentCard returns null when index >= queue length', () {
      final state = StudySessionState(
          queue: [_studyCard(1)],
          currentIndex: 1,
          isFlipped: false,
          isComplete: false);
      expect(state.currentCard, isNull);
    });

    test('progress is 0.0 at the start', () {
      final state = StudySessionState(
          queue: [_studyCard(1), _studyCard(2)],
          currentIndex: 0,
          isFlipped: false,
          isComplete: false);
      expect(state.progress, 0.0);
    });

    test('progress is 0.5 at midpoint', () {
      final state = StudySessionState(
          queue: [_studyCard(1), _studyCard(2)],
          currentIndex: 1,
          isFlipped: false,
          isComplete: false);
      expect(state.progress, 0.5);
    });

    test('progress is 1.0 when all cards done', () {
      final state = StudySessionState(
          queue: [_studyCard(1)],
          currentIndex: 1,
          isFlipped: false,
          isComplete: true);
      expect(state.progress, 1.0);
    });

    test('progress is 1.0 when queue is empty', () {
      final state = StudySessionState(
          queue: [], currentIndex: 0, isFlipped: false, isComplete: true);
      expect(state.progress, 1.0);
    });

    test('completedCards equals currentIndex', () {
      final state = StudySessionState(
          queue: [_studyCard(1), _studyCard(2), _studyCard(3)],
          currentIndex: 2,
          isFlipped: false,
          isComplete: false);
      expect(state.completedCards, 2);
    });
  });
}
