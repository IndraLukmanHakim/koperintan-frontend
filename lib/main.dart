import 'package:flutter/material.dart';
import 'package:pos/pages/cart_page.dart';
import 'package:pos/pages/checkout_page.dart';
import 'package:pos/pages/checkout_success_page.dart';
import 'package:pos/pages/edit_profile_page.dart';
import 'package:pos/pages/home/main_page.dart';
import 'package:pos/pages/home/profile_page.dart';
import 'package:pos/pages/sign_in_page.dart';
import 'package:pos/pages/sign_up_page.dart';
import 'package:pos/pages/splash_page.dart';
import 'package:pos/pages/status_order_page.dart';
import 'package:pos/providers/auth_provider.dart';
import 'package:pos/providers/cart_provider.dart';
import 'package:pos/providers/category_provider.dart';
import 'package:pos/providers/page_provider.dart';
import 'package:pos/providers/product_provider.dart';
import 'package:pos/providers/splash_provider.dart';
import 'package:pos/providers/transaction_provider.dart';
import 'package:pos/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  @override
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (create) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SplashProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        home: const SplashPage(),
        routes: {
          // '/': (context) => SplashPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/home': (context) => const MainPage(),
          '/profile': (context) => const ProfilPage(),
          '/edit-profile': (context) => EditProfilePage(),
          // '/product': (context) => ProductPage(product),
          '/cart': (context) => const CartPage(),
          '/checkout': (context) => const CheckoutPage(),
          '/checkout-success': (context) => const CheckoutSuccessPage(),
          '/status-order': (context) => const StatusorderPage(),
          '/change-password': (context) => const (),
        },
      ),
    );
  }
}
