import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:float/features/flashcards/presentation/providers/flashcard_providers.dart';

class AddFlashcardPage extends ConsumerStatefulWidget {
  const AddFlashcardPage({super.key, required this.deckId});
  final int deckId;

  @override
  ConsumerState<AddFlashcardPage> createState() => _AddFlashcardPageState();
}

class _AddFlashcardPageState extends ConsumerState<AddFlashcardPage> {
  final _wordController = TextEditingController();
  final _translationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isSaving = false;

  @override
  void dispose() {
    _wordController.dispose();
    _translationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Flashcard')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: _wordController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Word / Phrase',
                hintText: 'e.g. Bonjour',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _translationController,
              decoration: const InputDecoration(
                labelText: 'Translation',
                hintText: 'e.g. Hello',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _isSaving ? null : _save,
              child: _isSaving
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save Card'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _isSaving ? null : _saveAndAddAnother,
              child: const Text('Save & Add Another'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    await ref.read(flashcardActionsProvider.notifier).createCard(
          deckId: widget.deckId,
          word: _wordController.text.trim(),
          translation: _translationController.text.trim(),
        );
    if (mounted) context.pop();
  }

  Future<void> _saveAndAddAnother() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    await ref.read(flashcardActionsProvider.notifier).createCard(
          deckId: widget.deckId,
          word: _wordController.text.trim(),
          translation: _translationController.text.trim(),
        );
    if (mounted) {
      _wordController.clear();
      _translationController.clear();
      setState(() => _isSaving = false);
    }
  }
}
