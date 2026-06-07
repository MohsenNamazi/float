import 'dart:math';

import 'package:float/features/flashcards/domain/entities/flashcard.dart';
import 'package:float/features/flashcards/domain/entities/fsrs_state.dart';

/// Implements FSRS v5 (Free Spaced Repetition Scheduler).
/// Reference: https://github.com/open-spaced-repetition/fsrs4anki/wiki
class FsrsEngine {
  const FsrsEngine();

  // Default FSRS v5 weights (17 parameters)
  static const List<double> _w = [
    0.4072, 1.1829, 3.1262, 15.4722, // w[0-3]: initial stability per rating
    7.2102, 0.5316, 1.0651, 0.0589, //  w[4-7]
    1.4330, 0.1544, 1.0070, 1.9395, //  w[8-11]
    0.1100, 0.2900, 2.2700, 0.1400, //  w[12-15]
    2.9898, //                           w[16]
  ];

  static const double _targetRetention = 0.9;

  /// Returns the retrievability (recall probability) given stability and elapsed days.
  double retrievability(double stability, double elapsedDays) {
    if (stability <= 0) return 0;
    return pow(_targetRetention, elapsedDays / stability).toDouble();
  }

  /// Processes a card review and returns the updated FSRS values.
  FsrsReviewResult review({
    required Flashcard card,
    required FsrsRating rating,
  }) {
    final now = DateTime.now().toUtc();
    return card.state == FsrsCardState.newCard
        ? _processNewCard(card, rating, now)
        : _processExistingCard(card, rating, now);
  }

  FsrsReviewResult _processNewCard(
    Flashcard card,
    FsrsRating rating,
    DateTime now,
  ) {
    final stability = _initialStability(rating);
    final difficulty = _initialDifficulty(rating);

    final (state, interval) = switch (rating) {
      FsrsRating.again => (FsrsCardState.learning, const Duration(minutes: 1)),
      FsrsRating.hard => (FsrsCardState.learning, const Duration(minutes: 5)),
      FsrsRating.good => (FsrsCardState.learning, const Duration(minutes: 10)),
      FsrsRating.easy => (
          FsrsCardState.review,
          Duration(days: max(1, stability.round())),
        ),
    };

    return FsrsReviewResult(
      stability: stability,
      difficulty: difficulty,
      due: now.add(interval),
      state: state,
      reps: 1,
      lapses: card.lapses,
    );
  }

  FsrsReviewResult _processExistingCard(
    Flashcard card,
    FsrsRating rating,
    DateTime now,
  ) {
    final elapsed = now.difference(card.due).inSeconds / 86400.0;
    final r = retrievability(card.stability, elapsed.abs());
    final newDifficulty = _nextDifficulty(card.difficulty, rating);

    final double newStability;
    final int newLapses;
    final FsrsCardState newState;

    if (rating == FsrsRating.again) {
      newStability =
          _stabilityAfterForgetting(card.stability, newDifficulty, r);
      newLapses = card.lapses + 1;
      newState = FsrsCardState.relearning;
    } else {
      newStability =
          _stabilityAfterRecall(card.stability, newDifficulty, r, rating);
      newLapses = card.lapses;
      newState = FsrsCardState.review;
    }

    final intervalDays = max(1.0, newStability);
    return FsrsReviewResult(
      stability: newStability,
      difficulty: newDifficulty,
      due: now.add(Duration(hours: (intervalDays * 24).round())),
      state: newState,
      reps: card.reps + 1,
      lapses: newLapses,
    );
  }

  double _initialStability(FsrsRating rating) => _w[rating.value - 1];

  double _initialDifficulty(FsrsRating rating) => (_w[4] -
          exp(_w[5] * (rating.value - 1)) +
          1)
      .clamp(1.0, 10.0);

  double _nextDifficulty(double d, FsrsRating rating) {
    final dPrime = d - _w[6] * (rating.value - 3);
    // Mean reversion to prevent difficulty from drifting to extremes
    return (_w[7] * _initialDifficulty(FsrsRating.good) +
            (1 - _w[7]) * dPrime)
        .clamp(1.0, 10.0);
  }

  double _stabilityAfterRecall(
    double s,
    double d,
    double r,
    FsrsRating rating,
  ) {
    final hardPenalty = rating == FsrsRating.hard ? _w[15] : 1.0;
    final easyBonus = rating == FsrsRating.easy ? _w[16] : 1.0;
    return s *
        (exp(_w[8]) *
                (11 - d) *
                pow(s, -_w[9]) *
                (exp(_w[10] * (1 - r)) - 1) *
                hardPenalty *
                easyBonus +
            1);
  }

  double _stabilityAfterForgetting(double s, double d, double r) {
    return _w[11] *
        pow(d, -_w[12]) *
        (pow(s + 1, _w[13]) - 1) *
        exp(_w[14] * (1 - r));
  }
}

/// The result of a single FSRS card review.
class FsrsReviewResult {
  const FsrsReviewResult({
    required this.stability,
    required this.difficulty,
    required this.due,
    required this.state,
    required this.reps,
    required this.lapses,
  });

  final double stability;
  final double difficulty;
  final DateTime due;
  final FsrsCardState state;
  final int reps;
  final int lapses;
}
