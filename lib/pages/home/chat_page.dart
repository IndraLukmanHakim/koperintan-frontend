import 'package:flutter/material.dart';
import 'package:pos/providers/auth_provider.dart';
import 'package:pos/theme.dart';
import 'package:provider/provider.dart';

import '../../providers/page_provider.dart';
import '../../providers/transaction_provider.dart';
import '../widgets/status_card.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'Status Pesanan',
          style: priceTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          color: backgroundColor3,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon_headset.png',
                width: 80,
                height: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Belum ada pesan?',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Anda belum pernah menyelesaikan transaksi',
                style: secondaryTextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 44,
                child: TextButton(
                  onPressed: () {
                    pageProvider.currentIndex = 0;
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Jelajahi Toko',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget contentisi() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // children: [
            //   StatusCard(),
            // ],
            children: transactionProvider.status
                .map((id) => StatusCard(id))
                .toList()
                .reversed
                .map((e) => e)
                .toList(),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await transactionProvider.getStatus(authProvider.user!.token);
        pageProvider.currentIndex = 2;
      },
      child: ListView(
        children: [
          header(),
          transactionProvider.status.isEmpty ? content() : contentisi(),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
