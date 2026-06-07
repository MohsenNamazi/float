import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:float/features/decks/presentation/pages/deck_detail_page.dart';
import 'package:float/features/decks/presentation/pages/decks_page.dart';
import 'package:float/features/flashcards/presentation/pages/add_flashcard_page.dart';
import 'package:float/features/study/presentation/pages/study_session_page.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        name: 'decks',
        builder: (context, state) => const DecksPage(),
      ),
      GoRoute(
        path: '/deck/:deckId',
        name: 'deckDetail',
        builder: (context, state) {
          final deckId = int.parse(state.pathParameters['deckId']!);
          return DeckDetailPage(deckId: deckId);
        },
        routes: [
          GoRoute(
            path: 'study',
            name: 'study',
            pageBuilder: (context, state) {
              final deckId = int.parse(state.pathParameters['deckId']!);
              return CustomTransitionPage(
                key: state.pageKey,
                child: StudySessionPage(deckId: deckId),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  )),
                  child: child,
                ),
              );
            },
          ),
          GoRoute(
            path: 'add-card',
            name: 'addCard',
            pageBuilder: (context, state) {
              final deckId = int.parse(state.pathParameters['deckId']!);
              return MaterialPage(
                key: state.pageKey,
                child: AddFlashcardPage(deckId: deckId),
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Page not found: ${state.uri}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    ),
  );
}
