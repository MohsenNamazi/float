import 'package:float/core/constants/app_constants.dart';
import 'package:float/features/flashcards/domain/entities/flashcard.dart';
import 'package:float/features/study/domain/entities/study_card.dart';

/// Merges the new-card queue and the due-review queue into an interleaved
/// study session using a 1-new-per-4-reviews ratio.
class StudyQueueMixer {
  const StudyQueueMixer();

  static const int _reviewsPerNewCard = 4;

  /// [newCards] should already be sorted by createdAt DESC.
  /// [reviewCards] should already be sorted by due ASC (most urgent first).
  List<StudyCard> mix(
    List<Flashcard> newCards,
    List<Flashcard> reviewCards,
  ) {
    final cappedNew = newCards
        .take(AppConstants.maxNewCardsPerDay)
        .map((c) => StudyCard(flashcard: c, isNew: true))
        .toList();

    final reviews = reviewCards
        .map((c) => StudyCard(flashcard: c, isNew: false))
        .toList();

    if (cappedNew.isEmpty) return reviews;
    if (reviews.isEmpty) return cappedNew;

    // Interleave: insert one new card every _reviewsPerNewCard review cards.
    final result = <StudyCard>[];
    var newIdx = 0;
    var reviewIdx = 0;
    var reviewCount = 0;

    while (newIdx < cappedNew.length || reviewIdx < reviews.length) {
      if (reviewIdx < reviews.length) {
        result.add(reviews[reviewIdx++]);
        reviewCount++;
      }

      if (reviewCount >= _reviewsPerNewCard || reviewIdx >= reviews.length) {
        if (newIdx < cappedNew.length) {
          result.add(cappedNew[newIdx++]);
          reviewCount = 0;
        }
      }
    }

    return result;
  }
}
