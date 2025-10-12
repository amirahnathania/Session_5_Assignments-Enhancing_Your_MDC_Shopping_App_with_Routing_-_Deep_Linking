import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as int?;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body: Center(
        child: Text(
          productId != null
              ? 'Menampilkan detail produk dengan ID: $productId'
              : 'Produk tidak ditemukan',
        ),
      ),
    );
  }
}