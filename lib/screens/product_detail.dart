import 'package:flutter/material.dart';
import 'package:goalgear_mobile/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.thumbnail,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 200,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Text("ID: ${product.id}"),
            Text("Category: ${product.category}"),
            Text("Price: Rp ${product.price}"),
            Text("Brand: ${product.brand}"),
            Text("Stock: ${product.stock}"),
            Text("Featured: ${product.isFeatured ? 'Yes' : 'No'}"),
            if (product.userId != null) Text("User ID: ${product.userId}"),

            const SizedBox(height: 16),
            const Text(
              "Description:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
