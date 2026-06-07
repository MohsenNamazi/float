import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:float/features/flashcards/domain/entities/flashcard.dart';
import 'package:float/features/flashcards/presentation/providers/flashcard_providers.dart';

class DeckDetailPage extends ConsumerWidget {
  const DeckDetailPage({super.key, required this.deckId});
  final int deckId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsAsync = ref.watch(flashcardsForDeckProvider(deckId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deck'),
        actions: [
          FilledButton.icon(
            onPressed: () => context.go('/deck/$deckId/study'),
            icon: const Icon(Icons.play_arrow_rounded, size: 20),
            label: const Text('Study'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: cardsAsync.when(
        data: (cards) => cards.isEmpty
            ? _EmptyCardsState(
                onAdd: () => context.go('/deck/$deckId/add-card'),
              )
            : _CardList(cards: cards),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/deck/$deckId/add-card'),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

class _CardList extends StatelessWidget {
  const _CardList({required this.cards});
  final List<Flashcard> cards;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: cards.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final card = cards[i];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: scheme.outlineVariant.withAlpha(80),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.word,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      card.translation,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              _FsrsStateBadge(state: card.state.name),
            ],
          ),
        );
      },
    );
  }
}

class _FsrsStateBadge extends StatelessWidget {
  const _FsrsStateBadge({required this.state});
  final String state;

  static const _colors = {
    'newCard': Color(0xFF5B9BD5),
    'learning': Color(0xFFD4A842),
    'review': Color(0xFF7BA05B),
    'relearning': Color(0xFFE07070),
  };

  @override
  Widget build(BuildContext context) {
    final color = _colors[state] ?? Colors.grey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Text(
        state,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _EmptyCardsState extends StatelessWidget {
  const _EmptyCardsState({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.credit_card_outlined,
              size: 64, color: scheme.primary.withAlpha(120)),
          const SizedBox(height: 20),
          Text('No cards yet',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            'Add your first flashcard to get started.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Card'),
          ),
        ],
      ),
    );
  }
}
