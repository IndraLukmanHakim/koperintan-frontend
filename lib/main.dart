import 'package:flutter/material.dart';
import 'package:pos/pages/cart_page.dart';
import 'package:pos/pages/checkout_page.dart';
import 'package:pos/pages/checkout_success_page.dart';
import 'package:pos/pages/edit_profile_page.dart';
import 'package:pos/pages/home/main_page.dart';
import 'package:pos/pages/home/profile_page.dart';
import 'package:pos/pages/product_page.dart';
import 'package:pos/pages/sign_in_page.dart';
import 'package:pos/pages/sign_up_page.dart';
import 'package:pos/pages/splash_page.dart';
import 'package:pos/pages/status_order_page.dart';
import 'package:pos/pages/user.dart';
import 'package:pos/providers/auth_provider.dart';
import 'package:pos/providers/cart_provider.dart';
import 'package:pos/providers/product_provider.dart';
import 'package:pos/providers/transaction_provider.dart';
import 'package:pos/providers/wishlist_provider.dart';
import 'package:pos/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        routes: {
          '/': (context) => SplashPage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/home': (context) => MainPage(),
          '/profile': (context) => ProfilPage(),
          '/edit-profile': (context) => EditProfilePage(),
          // '/product': (context) => ProductPage(product),
          '/cart': (context) => CartPage(),
          '/checkout': (context) => CheckoutPage(),
          '/checkout-success': (context) => CheckoutSuccessPage(),
          '/status-order': (context) => StatusorderPage(),
        },
        // home: SplashPage(),
      ),
    );
  }
}
