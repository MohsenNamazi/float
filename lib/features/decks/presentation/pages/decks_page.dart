import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:float/features/decks/domain/entities/deck.dart';
import 'package:float/features/decks/presentation/providers/deck_providers.dart';
import 'package:float/features/decks/presentation/widgets/deck_card.dart';
import 'package:float/features/flashcards/presentation/providers/flashcard_providers.dart';
import 'package:float/theme/app_colors.dart';
import 'package:float/theme/theme_provider.dart';

class DecksPage extends ConsumerWidget {
  const DecksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksAsync = ref.watch(decksStreamProvider);
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Float'),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette_outlined),
            tooltip: 'Change theme',
            onPressed: () => _showThemePicker(context, ref, theme),
          ),
        ],
      ),
      body: decksAsync.when(
        data: (decks) => decks.isEmpty
            ? _EmptyState(onCreateTap: () => _showCreateDialog(context, ref))
            : _DeckGrid(decks: decks),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateDialog(context, ref),
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Deck'),
      ),
    );
  }

  Future<void> _showCreateDialog(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    var selectedColor = 'pastelOcean';

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Deck'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Deck name (e.g. Spanish verbs)',
              ),
            ),
            const SizedBox(height: 16),
            _ColorPicker(
              selected: selectedColor,
              onChanged: (c) => selectedColor = c,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isEmpty) return;
              await ref.read(deckActionsProvider.notifier).createDeck(
                    name: name,
                    colorThemeId: selectedColor,
                  );
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showThemePicker(
    BuildContext context,
    WidgetRef ref,
    AppThemeVariant current,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => _ThemePickerSheet(current: current, ref: ref),
    );
  }
}

class _DeckGrid extends ConsumerWidget {
  const _DeckGrid({required this.decks});
  final List<Deck> decks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: decks.length,
      itemBuilder: (context, i) {
        final deck = decks[i];
        final cardsAsync =
            ref.watch(flashcardsForDeckProvider(deck.id));
        final cardCount = cardsAsync.valueOrNull?.length ?? 0;

        return DeckCard(
          deck: deck,
          cardCount: cardCount,
          onTap: () => context.go('/deck/${deck.id}'),
          onDelete: () => ref
              .read(deckActionsProvider.notifier)
              .deleteDeck(deck.id),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onCreateTap});
  final VoidCallback onCreateTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.layers_outlined,
            size: 72,
            color: scheme.primary.withAlpha(120),
          ),
          const SizedBox(height: 24),
          Text(
            'No decks yet',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first flashcard deck\nto start learning.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: onCreateTap,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Create Deck'),
          ),
        ],
      ),
    );
  }
}

class _ColorPicker extends StatefulWidget {
  const _ColorPicker({required this.selected, required this.onChanged});
  final String selected;
  final void Function(String) onChanged;

  @override
  State<_ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<_ColorPicker> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: deckAccentColors.entries.map((entry) {
        final isSelected = entry.key == _selected;
        return GestureDetector(
          onTap: () {
            setState(() => _selected = entry.key);
            widget.onChanged(entry.key);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: entry.value,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 2.5,
                    )
                  : null,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: entry.value.withAlpha(100),
                        blurRadius: 8,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ThemePickerSheet extends StatelessWidget {
  const _ThemePickerSheet({required this.current, required this.ref});
  final AppThemeVariant current;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('App Theme', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ...AppThemeVariant.values.map(
              (v) => ListTile(
                title: Text(v.displayName),
                trailing: v == current
                    ? Icon(
                        Icons.check_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () {
                  ref.read(themeNotifierProvider.notifier).select(v);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
