// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Kit _$KitFromJson(Map<String, dynamic> json) {
  return _Kit.fromJson(json);
}

/// @nodoc
mixin _$Kit {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  double get budget => throw _privateConstructorUsedError;
  List<Product> get items => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;

  /// Serializes this Kit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Kit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KitCopyWith<Kit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KitCopyWith<$Res> {
  factory $KitCopyWith(Kit value, $Res Function(Kit) then) =
      _$KitCopyWithImpl<$Res, Kit>;
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> tags,
      double budget,
      List<Product> items,
      double totalPrice});
}

/// @nodoc
class _$KitCopyWithImpl<$Res, $Val extends Kit> implements $KitCopyWith<$Res> {
  _$KitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Kit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? tags = null,
    Object? budget = null,
    Object? items = null,
    Object? totalPrice = null,
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
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KitImplCopyWith<$Res> implements $KitCopyWith<$Res> {
  factory _$$KitImplCopyWith(_$KitImpl value, $Res Function(_$KitImpl) then) =
      __$$KitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> tags,
      double budget,
      List<Product> items,
      double totalPrice});
}

/// @nodoc
class __$$KitImplCopyWithImpl<$Res> extends _$KitCopyWithImpl<$Res, _$KitImpl>
    implements _$$KitImplCopyWith<$Res> {
  __$$KitImplCopyWithImpl(_$KitImpl _value, $Res Function(_$KitImpl) _then)
      : super(_value, _then);

  /// Create a copy of Kit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? tags = null,
    Object? budget = null,
    Object? items = null,
    Object? totalPrice = null,
  }) {
    return _then(_$KitImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KitImpl implements _Kit {
  const _$KitImpl(
      {required this.id,
      required this.name,
      required final List<String> tags,
      required this.budget,
      required final List<Product> items,
      required this.totalPrice})
      : _tags = tags,
        _items = items;

  factory _$KitImpl.fromJson(Map<String, dynamic> json) =>
      _$$KitImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final double budget;
  final List<Product> _items;
  @override
  List<Product> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final double totalPrice;

  @override
  String toString() {
    return 'Kit(id: $id, name: $name, tags: $tags, budget: $budget, items: $items, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_tags),
      budget,
      const DeepCollectionEquality().hash(_items),
      totalPrice);

  /// Create a copy of Kit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KitImplCopyWith<_$KitImpl> get copyWith =>
      __$$KitImplCopyWithImpl<_$KitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KitImplToJson(
      this,
    );
  }
}

abstract class _Kit implements Kit {
  const factory _Kit(
      {required final String id,
      required final String name,
      required final List<String> tags,
      required final double budget,
      required final List<Product> items,
      required final double totalPrice}) = _$KitImpl;

  factory _Kit.fromJson(Map<String, dynamic> json) = _$KitImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<String> get tags;
  @override
  double get budget;
  @override
  List<Product> get items;
  @override
  double get totalPrice;

  /// Create a copy of Kit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KitImplCopyWith<_$KitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
