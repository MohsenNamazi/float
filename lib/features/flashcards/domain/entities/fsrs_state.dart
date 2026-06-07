enum FsrsCardState {
  newCard,
  learning,
  review,
  relearning;

  bool get isNew => this == newCard;
  bool get isDue => this == review || this == relearning || this == learning;

  static FsrsCardState fromIndex(int index) =>
      FsrsCardState.values[index.clamp(0, FsrsCardState.values.length - 1)];
}

enum FsrsRating {
  again(1),
  hard(2),
  good(3),
  easy(4);

  const FsrsRating(this.value);
  final int value;

  String get label => switch (this) {
        FsrsRating.again => 'Again',
        FsrsRating.hard => 'Hard',
        FsrsRating.good => 'Good',
        FsrsRating.easy => 'Easy',
      };
}
