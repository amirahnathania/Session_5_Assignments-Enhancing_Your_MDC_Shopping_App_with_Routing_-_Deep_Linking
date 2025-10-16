import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // TAMBAHKAN IMPORT INI
import 'model/product.dart';
import 'model/products_repository.dart';
import 'model/cart.dart'; // TAMBAHKAN IMPORT INI

const kThaniaPink = Color(0xFFF6D7E4);
const kThaniaSoftPink = Color(0xFFFDEEF5);
const kThaniaText = Color(0xFF4A3F35);
const kThaniaAccent = Color(0xFFEFBAD6);

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    Product? product;

    if (args is int) {
      final allProducts = ProductsRepository.loadProducts(Category.all);
      try {
        product = allProducts.firstWhere((p) => p.id == args);
      } catch (e) {
        product = null;
      }
    } else if (args is Product) {
      product = args;
    }

    if (product == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Produk'),
          backgroundColor: kThaniaPink,
          foregroundColor: kThaniaText,
        ),
        body: const Center(
          child: Text('Produk tidak ditemukan', style: TextStyle(color: kThaniaText)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kThaniaPink,
        title: Text(
          product.name,
          style: const TextStyle(
            color: kThaniaText,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: kThaniaText),
      ),
      backgroundColor: kThaniaSoftPink,
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌸 Gambar produk
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.asset(
                product.assetName,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 280,
              ),
            ),

            const SizedBox(height: 20),

            // 🌸 Detail produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kThaniaText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.hargaRupiah,
                    style: const TextStyle(
                      fontSize: 18,
                      color: kThaniaAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Category: ${product.category.name}",
                    style: const TextStyle(
                      color: kThaniaText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (product.isFeatured)
                    const Row(
                      children: [
                        Icon(Icons.star, color: kThaniaAccent, size: 18),
                        SizedBox(width: 4),
                        Text(
                          "Featured Product",
                          style: TextStyle(
                            color: kThaniaText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  const Text(
                    "Description:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kThaniaText,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description?.isNotEmpty == true
                        ? product.description!
                        : "Tidak ada deskripsi produk.",
                    style: const TextStyle(
                      color: kThaniaText,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  // TAMBAHKAN: Tombol Add to Cart yang besar di bawah deskripsi
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // SAMA DENGAN FLOATING ACTION BUTTON
                        final cart = Provider.of<Cart>(context, listen: false);
                        cart.addItem(product!);
                        
                        print('✅ Product added to cart: ${product.name}');
                        print('🛒 Cart items count: ${cart.items.length}');
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} added to cart! 🛒'),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'View Cart',
                              onPressed: () {
                                Navigator.pushNamed(context, '/cart');
                              },
                            ),
                            backgroundColor: kThaniaAccent,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kThaniaAccent,
                        foregroundColor: kThaniaText,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_shopping_cart),
                          const SizedBox(width: 8),
                          const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}