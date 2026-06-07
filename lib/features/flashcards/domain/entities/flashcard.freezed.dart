// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flashcard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Flashcard {
  int get id => throw _privateConstructorUsedError;
  int get deckId => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get due => throw _privateConstructorUsedError;
  double get stability => throw _privateConstructorUsedError;
  double get difficulty => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  int get lapses => throw _privateConstructorUsedError;
  FsrsCardState get state => throw _privateConstructorUsedError;

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlashcardCopyWith<Flashcard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlashcardCopyWith<$Res> {
  factory $FlashcardCopyWith(Flashcard value, $Res Function(Flashcard) then) =
      _$FlashcardCopyWithImpl<$Res, Flashcard>;
  @useResult
  $Res call({
    int id,
    int deckId,
    String word,
    String translation,
    DateTime createdAt,
    DateTime due,
    double stability,
    double difficulty,
    int reps,
    int lapses,
    FsrsCardState state,
  });
}

/// @nodoc
class _$FlashcardCopyWithImpl<$Res, $Val extends Flashcard>
    implements $FlashcardCopyWith<$Res> {
  _$FlashcardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deckId = null,
    Object? word = null,
    Object? translation = null,
    Object? createdAt = null,
    Object? due = null,
    Object? stability = null,
    Object? difficulty = null,
    Object? reps = null,
    Object? lapses = null,
    Object? state = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            deckId: null == deckId
                ? _value.deckId
                : deckId // ignore: cast_nullable_to_non_nullable
                      as int,
            word: null == word
                ? _value.word
                : word // ignore: cast_nullable_to_non_nullable
                      as String,
            translation: null == translation
                ? _value.translation
                : translation // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            due: null == due
                ? _value.due
                : due // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            stability: null == stability
                ? _value.stability
                : stability // ignore: cast_nullable_to_non_nullable
                      as double,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as double,
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as int,
            lapses: null == lapses
                ? _value.lapses
                : lapses // ignore: cast_nullable_to_non_nullable
                      as int,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as FsrsCardState,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FlashcardImplCopyWith<$Res>
    implements $FlashcardCopyWith<$Res> {
  factory _$$FlashcardImplCopyWith(
    _$FlashcardImpl value,
    $Res Function(_$FlashcardImpl) then,
  ) = __$$FlashcardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int deckId,
    String word,
    String translation,
    DateTime createdAt,
    DateTime due,
    double stability,
    double difficulty,
    int reps,
    int lapses,
    FsrsCardState state,
  });
}

/// @nodoc
class __$$FlashcardImplCopyWithImpl<$Res>
    extends _$FlashcardCopyWithImpl<$Res, _$FlashcardImpl>
    implements _$$FlashcardImplCopyWith<$Res> {
  __$$FlashcardImplCopyWithImpl(
    _$FlashcardImpl _value,
    $Res Function(_$FlashcardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deckId = null,
    Object? word = null,
    Object? translation = null,
    Object? createdAt = null,
    Object? due = null,
    Object? stability = null,
    Object? difficulty = null,
    Object? reps = null,
    Object? lapses = null,
    Object? state = null,
  }) {
    return _then(
      _$FlashcardImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        deckId: null == deckId
            ? _value.deckId
            : deckId // ignore: cast_nullable_to_non_nullable
                  as int,
        word: null == word
            ? _value.word
            : word // ignore: cast_nullable_to_non_nullable
                  as String,
        translation: null == translation
            ? _value.translation
            : translation // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        due: null == due
            ? _value.due
            : due // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        stability: null == stability
            ? _value.stability
            : stability // ignore: cast_nullable_to_non_nullable
                  as double,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as double,
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as int,
        lapses: null == lapses
            ? _value.lapses
            : lapses // ignore: cast_nullable_to_non_nullable
                  as int,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as FsrsCardState,
      ),
    );
  }
}

/// @nodoc

class _$FlashcardImpl extends _Flashcard {
  const _$FlashcardImpl({
    required this.id,
    required this.deckId,
    required this.word,
    required this.translation,
    required this.createdAt,
    required this.due,
    required this.stability,
    required this.difficulty,
    required this.reps,
    required this.lapses,
    required this.state,
  }) : super._();

  @override
  final int id;
  @override
  final int deckId;
  @override
  final String word;
  @override
  final String translation;
  @override
  final DateTime createdAt;
  @override
  final DateTime due;
  @override
  final double stability;
  @override
  final double difficulty;
  @override
  final int reps;
  @override
  final int lapses;
  @override
  final FsrsCardState state;

  @override
  String toString() {
    return 'Flashcard(id: $id, deckId: $deckId, word: $word, translation: $translation, createdAt: $createdAt, due: $due, stability: $stability, difficulty: $difficulty, reps: $reps, lapses: $lapses, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlashcardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deckId, deckId) || other.deckId == deckId) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.due, due) || other.due == due) &&
            (identical(other.stability, stability) ||
                other.stability == stability) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.lapses, lapses) || other.lapses == lapses) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    deckId,
    word,
    translation,
    createdAt,
    due,
    stability,
    difficulty,
    reps,
    lapses,
    state,
  );

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlashcardImplCopyWith<_$FlashcardImpl> get copyWith =>
      __$$FlashcardImplCopyWithImpl<_$FlashcardImpl>(this, _$identity);
}

abstract class _Flashcard extends Flashcard {
  const factory _Flashcard({
    required final int id,
    required final int deckId,
    required final String word,
    required final String translation,
    required final DateTime createdAt,
    required final DateTime due,
    required final double stability,
    required final double difficulty,
    required final int reps,
    required final int lapses,
    required final FsrsCardState state,
  }) = _$FlashcardImpl;
  const _Flashcard._() : super._();

  @override
  int get id;
  @override
  int get deckId;
  @override
  String get word;
  @override
  String get translation;
  @override
  DateTime get createdAt;
  @override
  DateTime get due;
  @override
  double get stability;
  @override
  double get difficulty;
  @override
  int get reps;
  @override
  int get lapses;
  @override
  FsrsCardState get state;

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlashcardImplCopyWith<_$FlashcardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
