// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:pos/providers/page_provider.dart';
import 'package:pos/theme.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/transaction_provider.dart';

class CheckoutSuccessPage extends StatefulWidget {
  const CheckoutSuccessPage({super.key});

  @override
  State<CheckoutSuccessPage> createState() => _CheckoutSuccessPageState();
}

class _CheckoutSuccessPageState extends State<CheckoutSuccessPage> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageprovider = Provider.of<PageProvider>(context);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    // Widget
    getstatus() async {
      await Provider.of<TransactionProvider>(context, listen: false)
          .getStatus(authProvider.user!.token);
    }

    header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: const Text(
          'Checkout Success',
        ),
        elevation: 0,
      );
    }

    Widget content() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_empty_cart.png',
              width: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Transaksi berhasil!',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Terima kasih, pesanan anda akan segera diproses',
              style: secondaryTextStyle,
              textAlign: TextAlign.center,
            ),
            Container(
              width: 196,
              height: 44,
              margin: EdgeInsets.only(
                top: defaultMargin,
              ),
              child: TextButton(
                onPressed: () {
                  pageprovider.currentIndex = 0;
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Kembali Ke Home',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
            Container(
              width: 196,
              height: 44,
              margin: const EdgeInsets.only(
                top: 12,
              ),
              child: TextButton(
                onPressed: () async {
                  getstatus();
                  pageprovider.currentIndex = 0;
                  Navigator.pushNamed(context, '/status-order');
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff39374B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Lihat Status Pesanan',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                    color: const Color(0xffB7B6BF),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(),
    );
  }
}
