import 'package:freezed_annotation/freezed_annotation.dart';

import 'fsrs_state.dart';

part 'flashcard.freezed.dart';

@freezed
class Flashcard with _$Flashcard {
  const factory Flashcard({
    required int id,
    required int deckId,
    required String word,
    required String translation,
    required DateTime createdAt,
    required DateTime due,
    required double stability,
    required double difficulty,
    required int reps,
    required int lapses,
    required FsrsCardState state,
  }) = _Flashcard;

  const Flashcard._();

  bool get isNew => state == FsrsCardState.newCard;
  bool get isDue =>
      due.isBefore(DateTime.now().toUtc()) && state != FsrsCardState.newCard;
}
