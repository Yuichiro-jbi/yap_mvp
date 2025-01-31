// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'islander.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Islander _$IslanderFromJson(Map<String, dynamic> json) {
  return _Islander.fromJson(json);
}

/// @nodoc
mixin _$Islander {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get experience => throw _privateConstructorUsedError;
  int get sats => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get completedLessonIds => throw _privateConstructorUsedError;

  /// Serializes this Islander to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Islander
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IslanderCopyWith<Islander> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IslanderCopyWith<$Res> {
  factory $IslanderCopyWith(Islander value, $Res Function(Islander) then) =
      _$IslanderCopyWithImpl<$Res, Islander>;
  @useResult
  $Res call(
      {String id,
      String name,
      int experience,
      int sats,
      DateTime createdAt,
      List<String> completedLessonIds});
}

/// @nodoc
class _$IslanderCopyWithImpl<$Res, $Val extends Islander>
    implements $IslanderCopyWith<$Res> {
  _$IslanderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Islander
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? experience = null,
    Object? sats = null,
    Object? createdAt = null,
    Object? completedLessonIds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      sats: null == sats
          ? _value.sats
          : sats // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedLessonIds: null == completedLessonIds
          ? _value.completedLessonIds
          : completedLessonIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IslanderImplCopyWith<$Res>
    implements $IslanderCopyWith<$Res> {
  factory _$$IslanderImplCopyWith(
          _$IslanderImpl value, $Res Function(_$IslanderImpl) then) =
      __$$IslanderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int experience,
      int sats,
      DateTime createdAt,
      List<String> completedLessonIds});
}

/// @nodoc
class __$$IslanderImplCopyWithImpl<$Res>
    extends _$IslanderCopyWithImpl<$Res, _$IslanderImpl>
    implements _$$IslanderImplCopyWith<$Res> {
  __$$IslanderImplCopyWithImpl(
      _$IslanderImpl _value, $Res Function(_$IslanderImpl) _then)
      : super(_value, _then);

  /// Create a copy of Islander
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? experience = null,
    Object? sats = null,
    Object? createdAt = null,
    Object? completedLessonIds = null,
  }) {
    return _then(_$IslanderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      sats: null == sats
          ? _value.sats
          : sats // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedLessonIds: null == completedLessonIds
          ? _value._completedLessonIds
          : completedLessonIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IslanderImpl implements _Islander {
  const _$IslanderImpl(
      {required this.id,
      required this.name,
      required this.experience,
      required this.sats,
      required this.createdAt,
      final List<String> completedLessonIds = const []})
      : _completedLessonIds = completedLessonIds;

  factory _$IslanderImpl.fromJson(Map<String, dynamic> json) =>
      _$$IslanderImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int experience;
  @override
  final int sats;
  @override
  final DateTime createdAt;
  final List<String> _completedLessonIds;
  @override
  @JsonKey()
  List<String> get completedLessonIds {
    if (_completedLessonIds is EqualUnmodifiableListView)
      return _completedLessonIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedLessonIds);
  }

  @override
  String toString() {
    return 'Islander(id: $id, name: $name, experience: $experience, sats: $sats, createdAt: $createdAt, completedLessonIds: $completedLessonIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IslanderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.sats, sats) || other.sats == sats) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._completedLessonIds, _completedLessonIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, experience, sats,
      createdAt, const DeepCollectionEquality().hash(_completedLessonIds));

  /// Create a copy of Islander
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IslanderImplCopyWith<_$IslanderImpl> get copyWith =>
      __$$IslanderImplCopyWithImpl<_$IslanderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IslanderImplToJson(
      this,
    );
  }
}

abstract class _Islander implements Islander {
  const factory _Islander(
      {required final String id,
      required final String name,
      required final int experience,
      required final int sats,
      required final DateTime createdAt,
      final List<String> completedLessonIds}) = _$IslanderImpl;

  factory _Islander.fromJson(Map<String, dynamic> json) =
      _$IslanderImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get experience;
  @override
  int get sats;
  @override
  DateTime get createdAt;
  @override
  List<String> get completedLessonIds;

  /// Create a copy of Islander
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IslanderImplCopyWith<_$IslanderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
