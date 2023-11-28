import 'package:flutter/material.dart';
import 'package:pos/pages/widgets/cart_card.dart';
import 'package:pos/providers/cart_provider.dart';
import 'package:pos/theme.dart';
import 'package:provider/provider.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: const Text('Keranjang Anda'),
        elevation: 0,
      );
    }

    Widget emptyCart() {
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
            'Opss! Keranjang anda masih kosong',
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Mari isi keranjang anda',
            style: secondaryTextStyle,
          ),
          Container(
            width: 154,
            height: 44,
            margin: const EdgeInsets.only(
              top: 20,
            ),
            child: TextButton(
              onPressed: () {
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
                'Explore Store',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
          )
        ],
      ));
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: cartProvider.cartList.map((cart) => CartCard(cart)).toList(),
        // children: [
        //   CartCard(),
        //   CartCard(),
        //   CartCard(),
        //   CartCard(),
        // ],
      );
    }

    Widget customBottomNav() {
      return Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        height: 180,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: primaryTextStyle,
                  ),
                  Text(
                    'Rp. ${cartProvider.totalPrice()}',
                    style: priceTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Point yang akan didapatkan',
                    style: secondaryTextStyle,
                  ),
                  Text(
                    '${cartProvider.totalPoint()}',
                    style: priceTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Divider(
              thickness: 0.4,
              color: subtitleColor,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lanjutkan ke Checkout',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: primaryTextColor,
                    )
                  ],
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
      body: cartProvider.cartList.isEmpty ? emptyCart() : content(),
      bottomNavigationBar:
          cartProvider.cartList.isEmpty ? const SizedBox() : customBottomNav(),

      // body: ListView(
      //   children: [
      //     header(),
      //     emptyCart(),
      //   ],
      // ),
    );
  }
}
