class Product {
  final String id;
  final String name;
  final int price;
  final String description;
  final String thumbnail;
  final String category;
  final int stock;
  final String brand;
  final bool isFeatured;
  final int? userId;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.stock,
    required this.brand,
    required this.isFeatured,
    this.userId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      price: json['price'] is int
          ? json['price']
          : int.tryParse(json['price'].toString()) ?? 0,
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      category: json['category'] ?? '',
      stock: json['stock'] is int
          ? json['stock']
          : int.tryParse(json['stock']?.toString() ?? '0') ?? 0,
      brand: json['brand'] ?? '',
      isFeatured:
          json['is_featured'] == true ||
          json['is_featured']?.toString() == 'true',
      userId: json['user_id'] != null
          ? int.tryParse(json['user_id'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'description': description,
    'thumbnail': thumbnail,
    'category': category,
    'stock': stock,
    'brand': brand,
    'is_featured': isFeatured,
    'user_id': userId,
  };
}
