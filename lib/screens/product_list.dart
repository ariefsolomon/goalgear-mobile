import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:goalgear_mobile/models/product.dart';
import 'package:goalgear_mobile/screens/product_detail.dart';

class ItemListPage extends StatefulWidget {
  final bool onlyMine;
  const ItemListPage({super.key, this.onlyMine = false});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  bool _loading = true;
  String? _error;
  List<Product> _items = [];

  Future<void> _fetchItems() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final request = context.read<CookieRequest>();

    try {
      // Pilih endpoint berdasarkan onlyMine
      final endpoint = widget.onlyMine
          ? "http://localhost:8000/json/my/"
          : "http://localhost:8000/json/";

      // CookieRequest.get() -> langsung mengembalikan JSON decoded
      final data = await request.get(endpoint);

      List<Product> list = [];

      for (var d in data) {
        list.add(Product.fromJson(Map<String, dynamic>.from(d)));
      }

      // Reverse the list to show newest first
      list = list.reversed.toList();

      setState(() {
        _items = list;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.onlyMine ? "My Products" : "All Products"),
      ),

      // ===== BODY =====
      body: Builder(
        builder: (_) {
          if (_loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_error != null) {
            return Center(
              child: Text(
                "Error: $_error",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (_items.isEmpty) {
            return const Center(
              child: Text("No products found.", style: TextStyle(fontSize: 18)),
            );
          }

          return RefreshIndicator(
            onRefresh: _fetchItems,
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, i) {
                final item = _items[i];
                return Card(
                  child: ListTile(
                    leading: item.thumbnail.isNotEmpty
                        ? Image.network(
                            item.thumbnail,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image_not_supported),
                          )
                        : const Icon(Icons.image_not_supported),
                    title: Text(item.name),
                    subtitle: Text(item.description),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Rp ${item.price}"),
                        if (item.isFeatured)
                          const Text(
                            "Featured",
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: item),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
