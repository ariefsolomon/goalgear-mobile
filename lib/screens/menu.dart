import 'package:flutter/material.dart';
import 'package:goalgear_mobile/widgets/item_card.dart';
import 'package:goalgear_mobile/widgets/left_drawer.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  // Daftar Model Tombol
  final List<ItemHomepage> items = [
    ItemHomepage("All Products", Icons.store, Colors.blue),
    ItemHomepage("My Products", Icons.shopping_bag, Colors.green),
    ItemHomepage("Create Products", Icons.add_circle, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ================ App Bar ================
      appBar: AppBar(
        title: const Text(
          'GoalGear Mobile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      // ================ Left Drawer ================
      drawer: const LeftDrawer(),
      // ================ Body ================
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          children: items.map((item) => ItemCard(item)).toList(),
        ),
      ),
    );
  }
}

// Model Tombol
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}
