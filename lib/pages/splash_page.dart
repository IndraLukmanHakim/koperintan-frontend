import 'package:flutter/material.dart';
import 'package:pos/providers/auth_provider.dart';
import 'package:pos/providers/product_provider.dart';
import 'package:pos/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/category_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // State<SplashPage> createState() => _SplashPageState();
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  getInit() async {
    // ignore: use_build_context_synchronously

    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    // ignore: use_build_context_synchronously
    await Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryList();
    // Timer(const Duration(seconds: 1), () {
    //   Navigator.pushNamed(context, '/sign-in');
    // });

    // });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('token')) {
      await Provider.of<AuthProvider>(context, listen: false)
          .updateuser(prefs.getString('token'));
      print("dapat token");
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      print("tidak dapat token");
      Navigator.pushReplacementNamed(context, '/sign-in');
    }
  }

  @override
  void initState() {
    getInit();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/logo.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
