import 'package:flutter/material.dart';
import 'package:pos/pages/widgets/status_card.dart';
import 'package:pos/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'package:pos/theme.dart';

class StatusorderPage extends StatelessWidget {
  const StatusorderPage({super.key});


  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    getStatus() async {
      await Provider.of<TransactionProvider>(context, listen: false)
          .getStatus(authProvider.user!.token);
    }

    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    Widget header() {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Status Order',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: Icon(
              Icons.check,
              color: primaryColor,
            ),
          )
        ],
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
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
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
      // appBar: header(),
      // body: content(),
    );
  }
}
