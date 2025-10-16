// lib/model/cart.dart
import 'package:flutter/material.dart';
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get totalPrice {
    return _items.fold(0, (total, item) {
      return total + (item.product.price * item.quantity);
    });
  }

  // FIXED: Tambahkan getter untuk total item count (jumlah semua quantity)
  int get itemCount {
    return _items.fold(0, (total, item) => total + item.quantity);
  }

  // FIXED: Tambahkan getter untuk unique item count (jumlah produk berbeda)
  int get uniqueItemCount {
    return _items.length;
  }

  void addItem(Product product) {
    // Cek apakah product sudah ada di cart
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].product.id == product.id) {
        _items[i].quantity++;
        notifyListeners();
        return;
      }
    }
    // Jika belum ada, tambahkan product baru
    _items.add(CartItem(product: product, quantity: 1));
    notifyListeners();
  }

  void removeItem(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeItem(product);
      return;
    }

    for (var i = 0; i < _items.length; i++) {
      if (_items[i].product.id == product.id) {
        _items[i].quantity = quantity;
        notifyListeners();
        return;
      }
    }
  }

  bool contains(Product product) {
    return _items.any((item) => item.product.id == product.id);
  }

  // BONUS: Method untuk mendapatkan quantity spesifik product
  int getQuantity(Product product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        return item.quantity;
      }
    }
    return 0;
  }
}