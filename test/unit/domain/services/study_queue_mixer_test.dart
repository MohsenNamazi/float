import 'package:flutter_test/flutter_test.dart';
import 'package:float/core/constants/app_constants.dart';
import 'package:float/features/flashcards/domain/entities/flashcard.dart';
import 'package:float/features/flashcards/domain/entities/fsrs_state.dart';
import 'package:float/features/study/domain/services/study_queue_mixer.dart';

// ── Fixtures ─────────────────────────────────────────────────────────────────

Flashcard _card(int id, {FsrsCardState state = FsrsCardState.newCard}) =>
    Flashcard(
      id: id,
      deckId: 1,
      word: 'word$id',
      translation: 'trans$id',
      createdAt: DateTime.utc(2025),
      due: DateTime.now().toUtc(),
      stability: 0,
      difficulty: 5,
      reps: 0,
      lapses: 0,
      state: state,
    );

List<Flashcard> _newCards(int n) =>
    List.generate(n, (i) => _card(i + 1, state: FsrsCardState.newCard));

List<Flashcard> _reviewCards(int n) =>
    List.generate(n, (i) => _card(100 + i + 1, state: FsrsCardState.review));

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  const mixer = StudyQueueMixer();

  group('mix() — empty inputs', () {
    test('both empty → empty queue', () {
      expect(mixer.mix([], []), isEmpty);
    });

    test('only new cards → returns new cards', () {
      final cards = _newCards(3);
      final result = mixer.mix(cards, []);
      expect(result.length, 3);
      expect(result.every((c) => c.isNew), isTrue);
    });

    test('only review cards → returns review cards', () {
      final cards = _reviewCards(3);
      final result = mixer.mix([], cards);
      expect(result.length, 3);
      expect(result.every((c) => !c.isNew), isTrue);
    });
  });

  group('mix() — new-card cap', () {
    test('caps new cards at maxNewCardsPerDay (${AppConstants.maxNewCardsPerDay})', () {
      final tooMany = _newCards(AppConstants.maxNewCardsPerDay + 5);
      final result = mixer.mix(tooMany, []);
      final newCount = result.where((c) => c.isNew).length;
      expect(newCount, AppConstants.maxNewCardsPerDay);
    });

    test('does not cap when new cards <= maxNewCardsPerDay', () {
      final cards = _newCards(5);
      final result = mixer.mix(cards, []);
      expect(result.where((c) => c.isNew).length, 5);
    });
  });

  group('mix() — interleaving', () {
    test('all cards appear exactly once', () {
      final newCards = _newCards(4);
      final reviews = _reviewCards(8);
      final result = mixer.mix(newCards, reviews);

      final allIds = [...newCards, ...reviews].map((c) => c.id);
      final resultIds = result.map((c) => c.flashcard.id);

      expect(result.length, 12);
      for (final id in allIds) {
        expect(resultIds, contains(id));
      }
    });

    test('no duplicates in the mixed queue', () {
      final result = mixer.mix(_newCards(5), _reviewCards(10));
      final ids = result.map((c) => c.flashcard.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('new cards are interleaved, not all at the front', () {
      // With 1 new card and 5 reviews, the new card should NOT be first
      final result = mixer.mix(_newCards(1), _reviewCards(5));
      expect(result.first.isNew, isFalse,
          reason: 'reviews should come before the first new card');
    });

    test('new card appears after every 4 reviews (1:4 ratio)', () {
      final result = mixer.mix(_newCards(2), _reviewCards(8));
      // Pattern: 4 reviews, 1 new, 4 reviews, 1 new
      final positions = result
          .asMap()
          .entries
          .where((e) => e.value.isNew)
          .map((e) => e.key)
          .toList();
      expect(positions[0], 4); // 5th card (index 4) is first new
      expect(positions[1], 9); // 10th card (index 9) is second new
    });

    test('remaining new cards appended when reviews exhausted', () {
      // 5 new, 0 reviews — all new cards come through
      final result = mixer.mix(_newCards(5), []);
      expect(result.length, 5);
      expect(result.every((c) => c.isNew), isTrue);
    });

    test('remaining reviews appended when new cards exhausted', () {
      final result = mixer.mix(_newCards(1), _reviewCards(10));
      // 1 new card capped. All 10 reviews must appear.
      expect(result.where((c) => !c.isNew).length, 10);
      expect(result.where((c) => c.isNew).length, 1);
    });
  });

  group('mix() — StudyCard metadata', () {
    test('cards from newCards list have isNew=true', () {
      final result = mixer.mix(_newCards(3), _reviewCards(3));
      final newOnes = result.where((c) => c.isNew);
      expect(newOnes.length, 3);
    });

    test('cards from reviewCards list have isNew=false', () {
      final result = mixer.mix(_newCards(3), _reviewCards(3));
      final reviewOnes = result.where((c) => !c.isNew);
      expect(reviewOnes.length, 3);
    });

    test('StudyCard.flashcard preserves original word and translation', () {
      final reviews = _reviewCards(1);
      final result = mixer.mix([], reviews);
      expect(result.first.flashcard.word, 'word101');
      expect(result.first.flashcard.translation, 'trans101');
    });
  });
}
