import 'package:flutter/material.dart';
import 'package:pos/models/product_model.dart';
import 'package:pos/providers/wishlist_provider.dart';
import 'package:pos/theme.dart';
import 'package:provider/provider.dart';

class WishtlistCard extends StatelessWidget {
  @override
  final ProductModel product;
  WishtlistCard(this.product);
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      padding: EdgeInsets.only(
        top: 10,
        left: 12,
        bottom: 14,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: backgroundColor4,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              wishlistProvider.setProduct(product);
            },
            child: Image.asset(
              'assets/button_wishlist_blue.png',
              width: 34,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: primaryTextColor,
              child: Image.network(
                product.galleries![0].url!,
                width: 60,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  'Rp. ${product.price}',
                  style: priceTextStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
