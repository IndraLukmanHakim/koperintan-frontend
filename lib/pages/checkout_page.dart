
import 'package:flutter/material.dart';
import 'package:pos/pages/widgets/checkout_card.dart';
import 'package:pos/pages/widgets/loading_button.dart';
import 'package:pos/providers/auth_provider.dart';
import 'package:pos/providers/cart_provider.dart';
import 'package:pos/providers/transaction_provider.dart';
import 'package:pos/theme.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;

  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });

      String adrress = addressController.text;

      if (adrress.isNotEmpty &&
          await transactionProvider.checkout(
            // BUAT ADDRESS CONTROLLER
            // 'Jl. Kebon Jeruk No. 1',
            adrress,
            authProvider.user!.token!,
            cartProvider.cartList,
            cartProvider.totalPrice(),
            cartProvider.totalPoint(),
          )) {
        cartProvider.carts = [];
        Navigator.pushNamedAndRemoveUntil(
            context, '/checkout-success', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'Gagal Checkout! Masukkan Alamat Lengkap \n Contoh : Jl. Mulawarman RT. 99 No. 666',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Checkout Details',
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: [
          // NOTE: LIST ITEMS
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Items',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                // CheckoutCard(),
                Column(
                  children: cartProvider.cartList
                      .map(
                        (cart) => CheckoutCard(cart),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

          // ADDRESS DETAILS
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Detail Alamat',
                //   style: primaryTextStyle.copyWith(
                //     fontSize: 16,
                //     fontWeight: medium,
                //   ),
                // ),
                // SizedBox(
                //   height: 12,
                // ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alamat Lengkap',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: backgroundColor2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                            child: Row(
                          children: [
                            // Image.asset(
                            //   'assets/icon_your_address.png',
                            //   width: 17,
                            // ),
                            // SizedBox(
                            //   width: 16,
                            // ),
                            Expanded(
                              child: TextFormField(
                                style: primaryTextStyle,
                                controller: addressController,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Jl. Mulawarman RT. 99 No. 666',
                                  hintStyle: subtitleTextStyle,
                                ),
                              ),
                            ),
                          ],
                        )),
                      )
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     Column(
                //       children: [
                //         // Image.asset(
                //         //   'assets/icon_store_location.png',
                //         //   width: 40,
                //         // ),
                //         // Image.asset(
                //         //   'assets/icon_line.png',
                //         //   height: 30,
                //         // ),
                //         Image.asset(
                //           'assets/icon_your_address.png',
                //           width: 40,
                //         ),
                //       ],
                //     ),
                //     SizedBox(
                //       width: 12,
                //     ),
                //     Column(
                //       // crossAxisAlignment: CrossAxisAlignment.start,
                //       // children: [
                //       //   // Text(
                //       //   //   'Alamat',
                //       //   //   style: secondaryTextStyle.copyWith(
                //       //   //     fontWeight: light,
                //       //   //     fontSize: 12,
                //       //   //   ),
                //       //   // ),
                //       //   // Text(
                //       //   //   'Jln. Mulawarman RT 99 No. 666',
                //       //   //   style: primaryTextStyle.copyWith(
                //       //   //     fontWeight: medium,
                //       //   //   ),
                //       //   // ),
                //       //   SizedBox(
                //       //     height: defaultMargin,
                //       //   ),
                //       //   Text(
                //       //     'Alamat',
                //       //     style: secondaryTextStyle.copyWith(
                //       //       fontWeight: light,
                //       //       fontSize: 12,
                //       //     ),
                //       //   ),
                //       //   // Text(
                //       //   //   'Jln. Mulawarman RT 99 No. 666',
                //       //   //   style: primaryTextStyle.copyWith(
                //       //   //     fontWeight: medium,
                //       //   //   ),
                //       //   // ),
                //       //   Container(
                //       //     child: TextFormField(
                //       //       style: primaryTextStyle,
                //       //       controller: addressController,
                //       //       decoration: InputDecoration.collapsed(
                //       //         hintText: 'Alamat Lengkap',
                //       //         hintStyle: subtitleTextStyle,
                //       //       ),
                //       //     ),
                //       //   ),
                //       // ],

                //     ),
                //   ],
                // ),
              ],
            ),
          ),

          // PAYMENT SUMMARY
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pembayaran',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jumlah Produk',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${cartProvider.totalItems()} Items',
                      // '2 Items',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Harga Produk',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Rp. ${cartProvider.totalPrice()}',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Point yang akan didapatkan',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${cartProvider.totalPoint()}',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pengiriman',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Gratis',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff2E3141),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Harga',
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      'Rp. ${cartProvider.totalPrice()}',
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // NOTE: CHECKOUT BUTTON
          SizedBox(
            height: defaultMargin,
          ),
          Divider(
            thickness: 1,
            color: Color(0xff2E3141),
          ),
          isLoading
              ? Container(
                  margin: EdgeInsets.only(
                    bottom: 30,
                  ),
                  child: LoadingButton(),
                )
              : Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    vertical: defaultMargin,
                  ),
                  child: TextButton(
                    onPressed: () {
                      handleCheckout();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Checkout Sekarang',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(),
    );
  }
}
