import 'package:flutter/material.dart';
import 'package:goalgear_mobile/screens/product_form.dart';

// Card untuk Model Tombol
class ItemCard extends StatelessWidget {
  final dynamic item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // ----------------------------------------- warna card
      color: item.color,
      // ----------------------------------------- radius card
      borderRadius: BorderRadius.circular(16),
      // ----------------------------------------- child
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("Kamu telah menekan tombol ${item.name}!"),
            ),
          );
          // Navigasi ke form produk jika Create Products ditekan
          if (item.name == "Create Products") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductFormPage()),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30),
                const SizedBox(height: 8),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
