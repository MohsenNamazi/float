// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StudyCard {
  Flashcard get flashcard => throw _privateConstructorUsedError;
  bool get isNew => throw _privateConstructorUsedError;

  /// Create a copy of StudyCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudyCardCopyWith<StudyCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyCardCopyWith<$Res> {
  factory $StudyCardCopyWith(StudyCard value, $Res Function(StudyCard) then) =
      _$StudyCardCopyWithImpl<$Res, StudyCard>;
  @useResult
  $Res call({Flashcard flashcard, bool isNew});

  $FlashcardCopyWith<$Res> get flashcard;
}

/// @nodoc
class _$StudyCardCopyWithImpl<$Res, $Val extends StudyCard>
    implements $StudyCardCopyWith<$Res> {
  _$StudyCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudyCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? flashcard = null, Object? isNew = null}) {
    return _then(
      _value.copyWith(
            flashcard: null == flashcard
                ? _value.flashcard
                : flashcard // ignore: cast_nullable_to_non_nullable
                      as Flashcard,
            isNew: null == isNew
                ? _value.isNew
                : isNew // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of StudyCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FlashcardCopyWith<$Res> get flashcard {
    return $FlashcardCopyWith<$Res>(_value.flashcard, (value) {
      return _then(_value.copyWith(flashcard: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StudyCardImplCopyWith<$Res>
    implements $StudyCardCopyWith<$Res> {
  factory _$$StudyCardImplCopyWith(
    _$StudyCardImpl value,
    $Res Function(_$StudyCardImpl) then,
  ) = __$$StudyCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Flashcard flashcard, bool isNew});

  @override
  $FlashcardCopyWith<$Res> get flashcard;
}

/// @nodoc
class __$$StudyCardImplCopyWithImpl<$Res>
    extends _$StudyCardCopyWithImpl<$Res, _$StudyCardImpl>
    implements _$$StudyCardImplCopyWith<$Res> {
  __$$StudyCardImplCopyWithImpl(
    _$StudyCardImpl _value,
    $Res Function(_$StudyCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudyCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? flashcard = null, Object? isNew = null}) {
    return _then(
      _$StudyCardImpl(
        flashcard: null == flashcard
            ? _value.flashcard
            : flashcard // ignore: cast_nullable_to_non_nullable
                  as Flashcard,
        isNew: null == isNew
            ? _value.isNew
            : isNew // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$StudyCardImpl implements _StudyCard {
  const _$StudyCardImpl({required this.flashcard, required this.isNew});

  @override
  final Flashcard flashcard;
  @override
  final bool isNew;

  @override
  String toString() {
    return 'StudyCard(flashcard: $flashcard, isNew: $isNew)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyCardImpl &&
            (identical(other.flashcard, flashcard) ||
                other.flashcard == flashcard) &&
            (identical(other.isNew, isNew) || other.isNew == isNew));
  }

  @override
  int get hashCode => Object.hash(runtimeType, flashcard, isNew);

  /// Create a copy of StudyCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyCardImplCopyWith<_$StudyCardImpl> get copyWith =>
      __$$StudyCardImplCopyWithImpl<_$StudyCardImpl>(this, _$identity);
}

abstract class _StudyCard implements StudyCard {
  const factory _StudyCard({
    required final Flashcard flashcard,
    required final bool isNew,
  }) = _$StudyCardImpl;

  @override
  Flashcard get flashcard;
  @override
  bool get isNew;

  /// Create a copy of StudyCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudyCardImplCopyWith<_$StudyCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StudySessionState {
  List<StudyCard> get queue => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  bool get isFlipped => throw _privateConstructorUsedError;
  bool get isComplete => throw _privateConstructorUsedError;

  /// Create a copy of StudySessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudySessionStateCopyWith<StudySessionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudySessionStateCopyWith<$Res> {
  factory $StudySessionStateCopyWith(
    StudySessionState value,
    $Res Function(StudySessionState) then,
  ) = _$StudySessionStateCopyWithImpl<$Res, StudySessionState>;
  @useResult
  $Res call({
    List<StudyCard> queue,
    int currentIndex,
    bool isFlipped,
    bool isComplete,
  });
}

/// @nodoc
class _$StudySessionStateCopyWithImpl<$Res, $Val extends StudySessionState>
    implements $StudySessionStateCopyWith<$Res> {
  _$StudySessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudySessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queue = null,
    Object? currentIndex = null,
    Object? isFlipped = null,
    Object? isComplete = null,
  }) {
    return _then(
      _value.copyWith(
            queue: null == queue
                ? _value.queue
                : queue // ignore: cast_nullable_to_non_nullable
                      as List<StudyCard>,
            currentIndex: null == currentIndex
                ? _value.currentIndex
                : currentIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            isFlipped: null == isFlipped
                ? _value.isFlipped
                : isFlipped // ignore: cast_nullable_to_non_nullable
                      as bool,
            isComplete: null == isComplete
                ? _value.isComplete
                : isComplete // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudySessionStateImplCopyWith<$Res>
    implements $StudySessionStateCopyWith<$Res> {
  factory _$$StudySessionStateImplCopyWith(
    _$StudySessionStateImpl value,
    $Res Function(_$StudySessionStateImpl) then,
  ) = __$$StudySessionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<StudyCard> queue,
    int currentIndex,
    bool isFlipped,
    bool isComplete,
  });
}

/// @nodoc
class __$$StudySessionStateImplCopyWithImpl<$Res>
    extends _$StudySessionStateCopyWithImpl<$Res, _$StudySessionStateImpl>
    implements _$$StudySessionStateImplCopyWith<$Res> {
  __$$StudySessionStateImplCopyWithImpl(
    _$StudySessionStateImpl _value,
    $Res Function(_$StudySessionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudySessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queue = null,
    Object? currentIndex = null,
    Object? isFlipped = null,
    Object? isComplete = null,
  }) {
    return _then(
      _$StudySessionStateImpl(
        queue: null == queue
            ? _value._queue
            : queue // ignore: cast_nullable_to_non_nullable
                  as List<StudyCard>,
        currentIndex: null == currentIndex
            ? _value.currentIndex
            : currentIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        isFlipped: null == isFlipped
            ? _value.isFlipped
            : isFlipped // ignore: cast_nullable_to_non_nullable
                  as bool,
        isComplete: null == isComplete
            ? _value.isComplete
            : isComplete // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$StudySessionStateImpl extends _StudySessionState {
  const _$StudySessionStateImpl({
    required final List<StudyCard> queue,
    required this.currentIndex,
    required this.isFlipped,
    required this.isComplete,
  }) : _queue = queue,
       super._();

  final List<StudyCard> _queue;
  @override
  List<StudyCard> get queue {
    if (_queue is EqualUnmodifiableListView) return _queue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queue);
  }

  @override
  final int currentIndex;
  @override
  final bool isFlipped;
  @override
  final bool isComplete;

  @override
  String toString() {
    return 'StudySessionState(queue: $queue, currentIndex: $currentIndex, isFlipped: $isFlipped, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudySessionStateImpl &&
            const DeepCollectionEquality().equals(other._queue, _queue) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.isFlipped, isFlipped) ||
                other.isFlipped == isFlipped) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_queue),
    currentIndex,
    isFlipped,
    isComplete,
  );

  /// Create a copy of StudySessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudySessionStateImplCopyWith<_$StudySessionStateImpl> get copyWith =>
      __$$StudySessionStateImplCopyWithImpl<_$StudySessionStateImpl>(
        this,
        _$identity,
      );
}

abstract class _StudySessionState extends StudySessionState {
  const factory _StudySessionState({
    required final List<StudyCard> queue,
    required final int currentIndex,
    required final bool isFlipped,
    required final bool isComplete,
  }) = _$StudySessionStateImpl;
  const _StudySessionState._() : super._();

  @override
  List<StudyCard> get queue;
  @override
  int get currentIndex;
  @override
  bool get isFlipped;
  @override
  bool get isComplete;

  /// Create a copy of StudySessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudySessionStateImplCopyWith<_$StudySessionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
