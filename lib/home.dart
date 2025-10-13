import 'package:flutter/material.dart';
import 'supplemental/asymmetric_view.dart';
import 'category_menu_page.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'backdrop.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Category _currentCategory = Category.all;

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  void _onProductTap(Product product) {
    Navigator.pushNamed(context, '/product', arguments: product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      currentCategory: _currentCategory,
      frontLayer: AsymmetricView(
        products: ProductsRepository.loadProducts(_currentCategory),
        onProductTap: _onProductTap,
      ),
      backLayer: CategoryMenuPage(
        currentCategory: _currentCategory,
        onCategoryTap: _onCategoryTap,
      ),
      frontTitle: const Text('THANIA KSHOP'),
      backTitle: const Text('MENU'),
    );
  }
}
