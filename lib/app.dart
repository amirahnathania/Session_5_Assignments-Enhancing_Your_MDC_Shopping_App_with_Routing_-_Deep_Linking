import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';

import 'home.dart';
import 'login.dart';
import 'colors.dart';
import 'supplemental/cut_corners_border.dart';
import 'ProductDetailScreen.dart';
import 'cart.dart';
import 'about.dart';
import 'model/product.dart';
import 'model/products_repository.dart';

class ShrineApp extends StatefulWidget {
  const ShrineApp({Key? key}) : super(key: key);

  @override
  State<ShrineApp> createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp> {
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) _handleDeepLink(uri);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleInitialLink();
    });
  }

  Future<void> _handleInitialLink() async {
    try {
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) _handleDeepLink(initialUri);
    } catch (e) {
      print('Error handling initial link: $e');
    }
  }

  void _handleDeepLink(Uri uri) {
    try {
      if (uri.host == 'product' && uri.pathSegments.isNotEmpty) {
        final productId = int.tryParse(uri.pathSegments.first);
        if (productId != null) {
          navigatorKey.currentState?.pushNamed(
            '/product',
            arguments: productId, // Kirim ID saja
          );
        }
      }
    } catch (e) {
      print('Error handling deep link: $e');
    }
  }


  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THANIA KSHOP',
      navigatorKey: navigatorKey,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/': (context) => const Home(), // Home tanpa parameter
        '/cart': (context) => const CartScreen(),
        '/about': (context) => const AboutScreen(),
        '/product': (context) {
          final productId = ModalRoute.of(context)?.settings.arguments as int?;
          final product = productId != null
              ? ProductsRepository.loadProductById(productId)
              : null;
          if (product != null) {
            return ProductDetailScreen(product: product);
          } else {
            return const Scaffold(
              body: Center(child: Text('Product not found')),
            );
          }
        },
        // Jangan pakai '/product' di routes karena butuh argument
      },
      theme: _kShrineTheme,
    );
  }
}

final ThemeData _kShrineTheme = _buildShrineTheme();

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headlineSmall: base.headlineSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        titleLarge: base.titleLarge?.copyWith(
          fontSize: 18.0,
        ),
        bodySmall: base.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyLarge: base.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}

ThemeData _buildShrineTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kShrinePink100,
      onPrimary: kShrineBrown900,
      secondary: kShrineBrown900,
      error: kShrineErrorRed,
    ),
    scaffoldBackgroundColor: kShrineSurfaceWhite,
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: kShrinePink100,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: kShrineBrown900,
      backgroundColor: kShrinePink100,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: CutCornersBorder(),
      focusedBorder: CutCornersBorder(
        borderSide: BorderSide(width: 2.0, color: kShrineBrown900),
      ),
      floatingLabelStyle: TextStyle(color: kShrineBrown900),
    ),
  );
}