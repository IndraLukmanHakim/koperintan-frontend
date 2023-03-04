import 'package:flutter/material.dart';
import 'package:pos/models/product_model.dart';
import 'package:pos/theme.dart';

import '../product_page.dart';

class ProductTile extends StatelessWidget {
  @override
  final ProductModel product;
  ProductTile(this.product);
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product),
          ),
        );
      },
      // () {
      //   Navigator.pushNamed(context, '/product');
      // },
      child: Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: primaryTextColor,
                child: Image.network(
                  product.galleries![0].url!,
                  // "http://10.162.1.11:8000/storage/gallery/1.png",
                  // 'assets/2 (1).png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
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
                  product.category!.name!,
                  style: secondaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  product.name!,
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Rp. ${product.price}',
                  style: priceTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
