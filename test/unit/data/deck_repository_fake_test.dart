import 'package:flutter_test/flutter_test.dart';
import 'package:float/features/decks/domain/entities/deck.dart';
import 'package:float/features/decks/domain/repositories/deck_repository.dart';

// ── In-memory fake ────────────────────────────────────────────────────────────

class FakeDeckRepository implements DeckRepository {
  final List<Deck> _decks = [];
  int _nextId = 1;

  Deck _make({required int id, required String name, required String colorThemeId}) =>
      Deck(id: id, name: name, colorThemeId: colorThemeId, createdAt: DateTime.utc(2025));

  @override
  Stream<List<Deck>> watchAll() => Stream.value(List.unmodifiable(_decks));

  @override
  Future<List<Deck>> getAll() async => List.unmodifiable(_decks);

  @override
  Future<Deck?> getById(int id) async =>
      _decks.where((d) => d.id == id).firstOrNull;

  @override
  Future<int> create({required String name, required String colorThemeId}) async {
    final id = _nextId++;
    _decks.add(_make(id: id, name: name, colorThemeId: colorThemeId));
    return id;
  }

  @override
  Future<void> update(Deck deck) async {
    final idx = _decks.indexWhere((d) => d.id == deck.id);
    if (idx != -1) _decks[idx] = deck;
  }

  @override
  Future<void> deleteById(int id) async {
    _decks.removeWhere((d) => d.id == id);
  }
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late FakeDeckRepository repo;

  setUp(() => repo = FakeDeckRepository());

  group('create()', () {
    test('returns auto-incrementing id', () async {
      final id1 = await repo.create(name: 'A', colorThemeId: 'pastelOcean');
      final id2 = await repo.create(name: 'B', colorThemeId: 'sageGarden');
      expect(id1, 1);
      expect(id2, 2);
    });

    test('persists the deck', () async {
      await repo.create(name: 'Spanish', colorThemeId: 'terracotta');
      expect((await repo.getAll()).length, 1);
    });

    test('preserves name and colorThemeId', () async {
      final id = await repo.create(name: 'French', colorThemeId: 'honey');
      final deck = await repo.getById(id);
      expect(deck?.name, 'French');
      expect(deck?.colorThemeId, 'honey');
    });
  });

  group('getAll()', () {
    test('returns empty list initially', () async {
      expect(await repo.getAll(), isEmpty);
    });

    test('returns all created decks', () async {
      await repo.create(name: 'A', colorThemeId: 'x');
      await repo.create(name: 'B', colorThemeId: 'y');
      expect((await repo.getAll()).length, 2);
    });
  });

  group('getById()', () {
    test('returns null for unknown id', () async {
      expect(await repo.getById(99), isNull);
    });

    test('returns correct deck by id', () async {
      await repo.create(name: 'A', colorThemeId: 'x');
      final id = await repo.create(name: 'B', colorThemeId: 'y');
      final deck = await repo.getById(id);
      expect(deck?.name, 'B');
    });
  });

  group('update()', () {
    test('updates name in place', () async {
      final id = await repo.create(name: 'Old', colorThemeId: 'x');
      final deck = (await repo.getById(id))!;
      await repo.update(deck.copyWith(name: 'New'));
      expect((await repo.getById(id))?.name, 'New');
    });

    test('silently ignores update for unknown id', () async {
      final ghost = Deck(
          id: 999, name: 'Ghost', colorThemeId: 'x', createdAt: DateTime.utc(2025));
      await expectLater(repo.update(ghost), completes);
      expect(await repo.getAll(), isEmpty);
    });
  });

  group('deleteById()', () {
    test('removes the deck', () async {
      final id = await repo.create(name: 'A', colorThemeId: 'x');
      await repo.deleteById(id);
      expect(await repo.getAll(), isEmpty);
    });

    test('only removes the targeted deck', () async {
      final id1 = await repo.create(name: 'A', colorThemeId: 'x');
      await repo.create(name: 'B', colorThemeId: 'y');
      await repo.deleteById(id1);
      final remaining = await repo.getAll();
      expect(remaining.length, 1);
      expect(remaining.first.name, 'B');
    });

    test('silently ignores unknown id', () async {
      await expectLater(repo.deleteById(999), completes);
    });
  });

  group('watchAll()', () {
    test('emits current deck list', () async {
      await repo.create(name: 'A', colorThemeId: 'x');
      final list = await repo.watchAll().first;
      expect(list.length, 1);
    });

    test('emits empty list when no decks exist', () async {
      final list = await repo.watchAll().first;
      expect(list, isEmpty);
    });
  });
}
