import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:float/features/flashcards/domain/entities/fsrs_state.dart';
import 'package:float/features/flashcards/presentation/providers/flashcard_providers.dart';
import 'package:float/features/study/domain/entities/study_card.dart';
import 'package:float/features/study/domain/services/fsrs_engine.dart';
import 'package:float/features/study/domain/services/study_queue_mixer.dart';

part 'study_session_provider.g.dart';

@riverpod
class StudySession extends _$StudySession {
  static const _engine = FsrsEngine();
  static const _mixer = StudyQueueMixer();

  @override
  Future<StudySessionState> build(int deckId) async {
    final repo = ref.watch(flashcardRepositoryProvider);
    final newCards = await repo.getNewCards(deckId);
    final dueCards = await repo.getDueCards(deckId);
    final queue = _mixer.mix(newCards, dueCards);

    return StudySessionState(
      queue: queue,
      currentIndex: 0,
      isFlipped: false,
      isComplete: queue.isEmpty,
    );
  }

  void flip() {
    final current = state.valueOrNull;
    if (current == null || current.isComplete) return;
    state = AsyncValue.data(current.copyWith(isFlipped: !current.isFlipped));
  }

  Future<void> rate(FsrsRating rating) async {
    final current = state.valueOrNull;
    if (current == null || current.currentCard == null) return;

    final card = current.currentCard!.flashcard;
    final result = _engine.review(card: card, rating: rating);

    final repo = ref.read(flashcardRepositoryProvider);
    await repo.updateAfterReview(
      id: card.id,
      due: result.due,
      stability: result.stability,
      difficulty: result.difficulty,
      reps: result.reps,
      lapses: result.lapses,
      state: result.state,
    );

    final nextIndex = current.currentIndex + 1;
    final isComplete = nextIndex >= current.totalCards;

    state = AsyncValue.data(
      current.copyWith(
        currentIndex: nextIndex,
        isFlipped: false,
        isComplete: isComplete,
      ),
    );
  }
}
