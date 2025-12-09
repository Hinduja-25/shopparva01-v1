// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      brand: json['brand'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      rating: (json['rating'] as num).toDouble(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      offers: (json['offers'] as List<dynamic>)
          .map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'brand': instance.brand,
      'categories': instance.categories,
      'rating': instance.rating,
      'images': instance.images,
      'offers': instance.offers,
    };

_$OfferImpl _$$OfferImplFromJson(Map<String, dynamic> json) => _$OfferImpl(
      marketplace: json['marketplace'] as String,
      price: (json['price'] as num).toDouble(),
      seller: json['seller'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$OfferImplToJson(_$OfferImpl instance) =>
    <String, dynamic>{
      'marketplace': instance.marketplace,
      'price': instance.price,
      'seller': instance.seller,
      'url': instance.url,
    };
