import 'package:flutter/material.dart';
import 'model/product.dart';
import 'model/products_repository.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadSampleCartItems();
  }

  void _loadSampleCartItems() {
    final allProducts = ProductsRepository.loadProducts(Category.all);
    setState(() {
      cartItems = allProducts.take(3).toList();
    });
  }

  void _removeFromCart(int productId) {
    setState(() {
      cartItems.removeWhere((product) => product.id == productId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Barang dihapus dari keranjang')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Keranjang anda kosong'),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: Image.asset(
                            product.assetName,
                            width: 50,
                            height: 50,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 50,
                                height: 50,
                                color: Colors.grey[200],
                                child: const Icon(Icons.fastfood),
                              );
                            },
                          ),
                          title: Text(product.name),
                          subtitle: Text(product.hargaRupiah),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle_outline,
                                color: Colors.red),
                            onPressed: () => _removeFromCart(product.id),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/product',
                              arguments: product.id,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                if (cartItems.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Melanjutkan ke pembayaran')),
                        );
                      },
                      child: const Text('Bayar'),
                    ),
                  ),
              ],
            ),
    );
  }
}