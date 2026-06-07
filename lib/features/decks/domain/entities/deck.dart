import 'package:freezed_annotation/freezed_annotation.dart';

part 'deck.freezed.dart';

@freezed
class Deck with _$Deck {
  const factory Deck({
    required int id,
    required String name,
    required String colorThemeId,
    required DateTime createdAt,
  }) = _Deck;
}
