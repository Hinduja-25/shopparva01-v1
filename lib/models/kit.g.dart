// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KitImpl _$$KitImplFromJson(Map<String, dynamic> json) => _$KitImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      budget: (json['budget'] as num).toDouble(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$KitImplToJson(_$KitImpl instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tags': instance.tags,
      'budget': instance.budget,
      'items': instance.items,
      'totalPrice': instance.totalPrice,
    };
