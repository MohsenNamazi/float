import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:float/features/study/domain/entities/study_card.dart';
import 'package:float/features/study/presentation/providers/study_session_provider.dart';
import 'package:float/features/study/presentation/widgets/flip_card_widget.dart';
import 'package:float/features/study/presentation/widgets/rating_buttons.dart';
import 'package:float/features/study/presentation/widgets/study_progress_bar.dart';

class StudySessionPage extends ConsumerWidget {
  const StudySessionPage({super.key, required this.deckId});
  final int deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(studySessionProvider(deckId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('Study'),
      ),
      body: sessionAsync.when(
        data: (session) => session.isComplete
            ? _CompletionView(onDone: () => context.pop())
            : _ActiveSession(
                session: session,
                deckId: deckId,
                ref: ref,
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _ActiveSession extends StatelessWidget {
  const _ActiveSession({
    required this.session,
    required this.deckId,
    required this.ref,
  });

  final StudySessionState session;
  final int deckId;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final card = session.currentCard!;
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            StudyProgressBar(
              progress: session.progress,
              completed: session.completedCards,
              total: session.totalCards,
            ),
            const SizedBox(height: 24),
            if (card.isNew)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: scheme.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'NEW',
                  style: TextStyle(
                    color: scheme.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Expanded(
              child: FlipCardWidget(
                isFlipped: session.isFlipped,
                onTap: () => ref
                    .read(studySessionProvider(deckId).notifier)
                    .flip(),
                front: _CardFace(
                  text: card.flashcard.word,
                  hint: 'Tap to reveal',
                  scheme: scheme,
                  isBack: false,
                ),
                back: _CardFace(
                  text: card.flashcard.translation,
                  hint: card.flashcard.word,
                  scheme: scheme,
                  isBack: true,
                ),
              ),
            ),
            const SizedBox(height: 24),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: session.isFlipped
                  ? RatingButtons(
                      key: const ValueKey('rating'),
                      onRate: (rating) => ref
                          .read(studySessionProvider(deckId).notifier)
                          .rate(rating),
                    )
                  : Padding(
                      key: const ValueKey('hint'),
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Tap the card to reveal the answer',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _CardFace extends StatelessWidget {
  const _CardFace({
    required this.text,
    required this.hint,
    required this.scheme,
    required this.isBack,
  });

  final String text;
  final String hint;
  final ColorScheme scheme;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    final bgColor =
        isBack ? scheme.primaryContainer : scheme.surfaceContainerLow;
    final textColor =
        isBack ? scheme.onPrimaryContainer : scheme.onSurface;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isBack
              ? scheme.primary.withAlpha(60)
              : scheme.outlineVariant.withAlpha(80),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            isBack ? hint : hint,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor.withAlpha(120),
                ),
          ),
        ],
      ),
    );
  }
}

class _CompletionView extends StatelessWidget {
  const _CompletionView({required this.onDone});
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: scheme.primary.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 52,
                color: scheme.primary,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Session Complete!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Great work. Come back tomorrow\nfor your next review.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 36),
            FilledButton(
              onPressed: onDone,
              child: const Text('Back to Decks'),
            ),
          ],
        ),
      ),
    );
  }
}
