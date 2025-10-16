import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'colors.dart';
import 'model/cart.dart';
import 'model/product.dart';

class CartScreen extends StatelessWidget {
  final bool showAppBar;
  
  const CartScreen({
    Key? key, 
    this.showAppBar = true
  }) : super(key: key);

  // Format currency ke Rupiah
  String _formatRupiah(num price) {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kShrinePink300, // BACKGROUND DARI COLORS.DART
      appBar: showAppBar ? AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: kShrinePink100, // WARNA DARI COLORS.DART
        foregroundColor: kShrineBrown900, // WARNA DARI COLORS.DART
        centerTitle: true,
        actions: [
          Consumer<Cart>(
            builder: (context, cart, child) {
              return IconButton(
                icon: Icon(Icons.delete_outline, color: kShrineBrown900),
                onPressed: cart.items.isEmpty ? null : () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Clear Cart'),
                      content: const Text('Are you sure you want to clear all items from your cart?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            cart.clear();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Cart cleared')),
                            );
                          },
                          child: const Text('Clear', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ) : null,
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: kShrineBrown900.withOpacity(0.5)),
                  const SizedBox(height: 20),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 20,
                      color: kShrineBrown900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add some products to get started!',
                    style: TextStyle(
                      fontSize: 14,
                      color: kShrineBrown900.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Header dengan jumlah item
              Container(
                padding: const EdgeInsets.all(16),
                color: kShrinePink100.withOpacity(0.3), // WARNA DARI COLORS.DART
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart, color: kShrineBrown900),
                    const SizedBox(width: 8),
                    Text(
                      '${cart.itemCount} ${cart.itemCount == 1 ? 'item' : 'items'} in cart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kShrineBrown900,
                      ),
                    ),
                  ],
                ),
              ),

              // List items
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    final subtotal = (item.product.price * item.quantity).toDouble();
                    
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      color: kShrineBackgroundWhite, // WARNA DARI COLORS.DART
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Product Image/Icon
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: kShrinePink100, // WARNA DARI COLORS.DART
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.shopping_bag,
                                color: kShrineBrown900, // WARNA DARI COLORS.DART
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: kShrineBrown900, // WARNA DARI COLORS.DART
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _formatRupiah(item.product.price.toDouble()),
                                    style: TextStyle(
                                      color: kShrineBrown900.withOpacity(0.7), // WARNA DARI COLORS.DART
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Quantity Controls
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: kShrinePink100), // WARNA DARI COLORS.DART
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove, size: 18, color: kShrineBrown900),
                                    onPressed: () {
                                      if (item.quantity > 1) {
                                        cart.updateQuantity(item.product, item.quantity - 1);
                                      } else {
                                        cart.removeItem(item.product);
                                      }
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(minWidth: 36),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      item.quantity.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kShrineBrown900,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, size: 18, color: kShrineBrown900),
                                    onPressed: () {
                                      cart.updateQuantity(item.product, item.quantity + 1);
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(minWidth: 36),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Subtotal
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _formatRupiah(subtotal),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: kShrinePurple, // WARNA DARI COLORS.DART
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${item.quantity} × ${_formatRupiah(item.product.price.toDouble())}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: kShrineBrown900.withOpacity(0.6), // WARNA DARI COLORS.DART
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Total Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kShrinePink100, // WARNA DARI COLORS.DART
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Items:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kShrineBrown900,
                          ),
                        ),
                        Text(
                          cart.itemCount.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kShrineBrown900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kShrineBrown900,
                          ),
                        ),
                        Text(
                          _formatRupiah(cart.totalPrice),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kShrinePurple, // WARNA DARI COLORS.DART
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Checkout functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Checkout - ${_formatRupiah(cart.totalPrice)}'),
                              backgroundColor: kShrinePurple, // WARNA DARI COLORS.DART
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kShrinePurple, // WARNA DARI COLORS.DART
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Checkout Now',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}