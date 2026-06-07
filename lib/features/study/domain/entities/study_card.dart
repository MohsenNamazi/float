import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:float/features/flashcards/domain/entities/flashcard.dart';

part 'study_card.freezed.dart';

@freezed
class StudyCard with _$StudyCard {
  const factory StudyCard({
    required Flashcard flashcard,
    required bool isNew,
  }) = _StudyCard;
}

@freezed
class StudySessionState with _$StudySessionState {
  const factory StudySessionState({
    required List<StudyCard> queue,
    required int currentIndex,
    required bool isFlipped,
    required bool isComplete,
  }) = _StudySessionState;

  const StudySessionState._();

  StudyCard? get currentCard =>
      currentIndex < queue.length ? queue[currentIndex] : null;

  int get totalCards => queue.length;
  int get completedCards => currentIndex;
  double get progress => totalCards == 0 ? 1.0 : completedCards / totalCards;
}
