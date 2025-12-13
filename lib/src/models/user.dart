import 'package:meta/meta.dart';

@immutable
class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    this.preferences,
  });

  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final UserPreferences? preferences;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      preferences: json['preferences'] != null
          ? UserPreferences.fromJson(json['preferences'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        if (phone != null) 'phone': phone,
        if (avatar != null) 'avatar': avatar,
        if (preferences != null) 'preferences': preferences!.toJson(),
      };

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatar,
    UserPreferences? preferences,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      preferences: preferences ?? this.preferences,
    );
  }
}

@immutable
class UserPreferences {
  const UserPreferences({
    this.theme = 'dark',
    this.notifications = true,
    this.language = 'en',
    this.categories = const [],
    this.budget = 0,
  });

  final String theme;
  final bool notifications;
  final String language;
  final List<String> categories;
  final int budget;

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      theme: json['theme'] as String? ?? 'dark',
      notifications: json['notifications'] as bool? ?? true,
      language: json['language'] as String? ?? 'en',
      categories: (json['categories'] as List?)?.cast<String>() ?? [],
      budget: (json['budget'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'theme': theme,
        'notifications': notifications,
        'language': language,
        'categories': categories,
        'budget': budget,
      };

  UserPreferences copyWith({
    String? theme,
    bool? notifications,
    String? language,
    List<String>? categories,
    int? budget,
  }) {
    return UserPreferences(
      theme: theme ?? this.theme,
      notifications: notifications ?? this.notifications,
      language: language ?? this.language,
      categories: categories ?? this.categories,
      budget: budget ?? this.budget,
    );
  }
}

@immutable
class Address {
  const Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    this.isDefault = false,
  });

  final String id;
  final String name;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final bool isDefault;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      pincode: json['pincode'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'address': address,
        'city': city,
        'state': state,
        'pincode': pincode,
        'isDefault': isDefault,
      };

  String get fullAddress => '$address, $city, $state - $pincode';

  Address copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? pincode,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

@immutable
class Order {
  const Order({
    required this.id,
    required this.orderNumber,
    required this.date,
    required this.status,
    required this.total,
    required this.items,
    required this.shippingAddress,
  });

  final String id;
  final String orderNumber;
  final DateTime date;
  final String status;
  final double total;
  final List<OrderItem> items;
  final Address shippingAddress;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      total: (json['total'] as num).toDouble(),
      items: (json['items'] as List)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      shippingAddress: Address.fromJson(json['shippingAddress'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderNumber': orderNumber,
        'date': date.toIso8601String(),
        'status': status,
        'total': total,
        'items': items.map((e) => e.toJson()).toList(),
        'shippingAddress': shippingAddress.toJson(),
      };
}

@immutable
class OrderItem {
  const OrderItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  final String productId;
  final String name;
  final int quantity;
  final double price;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'quantity': quantity,
        'price': price,
      };
}

@immutable
class WishlistItem {
  const WishlistItem({
    required this.id,
    required this.productId,
    required this.addedAt,
  });

  final String id;
  final String productId;
  final DateTime addedAt;

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'] as String,
      productId: json['productId'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'addedAt': addedAt.toIso8601String(),
      };
}
