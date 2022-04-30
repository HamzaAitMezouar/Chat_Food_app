import 'dart:ffi';

class Food {
  String name;
  Float price;
  Food({required this.name, required this.price});

  static Food fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      price: json['price'],
    );
  }
}
