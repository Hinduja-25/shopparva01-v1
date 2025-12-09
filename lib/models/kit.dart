import 'package:freezed_annotation/freezed_annotation.dart';
import 'product.dart';

part 'kit.freezed.dart';
part 'kit.g.dart';

@freezed
class Kit with _$Kit {
  const factory Kit({
    required String id,
    required String name,
    required List<String> tags,
    required double budget,
    required List<Product> items,
    required double totalPrice,
  }) = _Kit;

  factory Kit.fromJson(Map<String, dynamic> json) => _$KitFromJson(json);
}
