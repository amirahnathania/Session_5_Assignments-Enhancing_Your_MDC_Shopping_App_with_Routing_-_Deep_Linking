import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'login.dart';
import 'colors.dart';
import 'supplemental/cut_corners_border.dart';
import 'ProductDetailScreen.dart';
import 'cart.dart';
import 'about.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'model/cart.dart';

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
      _showErrorSnackbar('Failed to process link');
    }
  }

  void _handleDeepLink(Uri uri) {
    try {
      if (uri.host == 'product' && uri.pathSegments.isNotEmpty) {
        final productId = int.tryParse(uri.pathSegments.first);
        if (productId != null) {
          final product = ProductsRepository.loadProductById(productId);
          if (product != null) {
            navigatorKey.currentState?.pushNamed(
              '/product',
              arguments: productId,
            );
          } else {
            navigatorKey.currentState?.pushNamed(
              '/error',
              arguments: 'Product with ID $productId not found',
            );
          }
        } else {
          navigatorKey.currentState?.pushNamed(
            '/error',
            arguments: 'Invalid product ID format',
          );
        }
      } else {
        navigatorKey.currentState?.pushNamed(
          '/error', 
          arguments: 'Unknown deep link: ${uri.toString()}'
        );
      }
    } catch (e) {
      print('Error handling deep link: $e');
      _showErrorSnackbar('Failed to open link');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
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
        '/home': (context) => const MainNavigationScreen(initialIndex: 0),
        '/cart': (context) => const MainNavigationScreen(initialIndex: 1),
        '/about': (context) => const MainNavigationScreen(initialIndex: 2),
        '/product': (context) {
          final productId = ModalRoute.of(context)?.settings.arguments as int?;
          if (productId == null) {
            return const ErrorScreen(message: 'Product ID not provided');
          }
          
          final product = ProductsRepository.loadProductById(productId);
          if (product != null) {
            return ProductDetailScreen(product: product);
          } else {
            return ErrorScreen(message: 'Product with ID $productId not found');
          }
        },
        '/error': (context) {
          final message = ModalRoute.of(context)?.settings.arguments as String?;
          return ErrorScreen(message: message ?? 'An error occurred');
        },
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => const MainNavigationScreen(initialIndex: 0));
        }
        
        return MaterialPageRoute(
          builder: (context) => ErrorScreen(
            message: 'Page "${settings.name}" not found'
          ),
        );
      },
      theme: _buildShrineTheme(),
    );
  }
}

// FIXED: Main Navigation Screen - NO APP BAR SAMA SEKALI
class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  
  const MainNavigationScreen({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  Widget _buildHomeScreen() {
    return const Home(showAppBar: false);
  }

  Widget _buildCartScreen() {
    return const CartScreen(showAppBar: true); // Biarkan CartScreen handle AppBar sendiri
  }

  Widget _buildAboutScreen() {
    return const AboutScreen(showAppBar: true); // Biarkan AboutScreen handle AppBar sendiri
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    // FIXED: HAPUS AppBar sama sekali dari MainNavigationScreen
    // Biarkan tiap screen handle AppBar mereka sendiri
    return Scaffold(
      appBar: null, // HAPUS APP BAR DI SINI
      body: _buildCurrentScreen(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0: return _buildHomeScreen();
      case 1: return _buildCartScreen();
      case 2: return _buildAboutScreen();
      default: return _buildHomeScreen();
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      backgroundColor: kShrinePink100,
      selectedItemColor: kShrineBrown900,
      unselectedItemColor: kShrineBrown900.withOpacity(0.6),
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'About',
        ),
      ],
    );
  }
}

// Error Screen tetap sama
class ErrorScreen extends StatelessWidget {
  final String message;
  
  const ErrorScreen({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        backgroundColor: kShrinePink100,
        foregroundColor: kShrineBrown900,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kShrineBrown900,
                foregroundColor: kShrineSurfaceWhite,
              ),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// Theme code tetap sama
TextTheme _buildShrineTextTheme(TextTheme base) {
  return base.copyWith(
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
  ).apply(
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kShrinePink100,
      selectedItemColor: kShrineBrown900,
      unselectedItemColor: kShrineBrown900.withOpacity(0.6),
    ),
  );
}