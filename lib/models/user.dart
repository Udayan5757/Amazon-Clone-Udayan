import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String type;
  final String address;
  final String token;
  final List<dynamic> cart;
  final List<dynamic> wishList;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.address,
    required this.token,
    required this.cart,
    required this.wishList,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'address': address,
      'token': token,
      'cart': cart,
      'wishList':wishList,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'],
      type: map['type'] ?? '',
      address: map['address'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      wishList: List<Map<String, dynamic>>.from(
        map['wishList']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? type,
    String? address,
    String? token,
    List<dynamic>? cart,
    List<dynamic>? wishList,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      address: address ?? this.address,
      token: token ?? this.token,
      cart: cart ?? this.cart,
      wishList: wishList ?? this.wishList,
    );
  }
}
