import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String title,
    required String description,
    required String brand,
    required List<String> categories,
    required double rating,
    required List<String> images,
    required List<Offer> offers,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

@freezed
class Offer with _$Offer {
  const factory Offer({
    required String marketplace,
    required double price,
    required String seller,
    required String url,
  }) = _Offer;

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
}
