import 'package:flutter/material.dart';
import 'package:pos/theme.dart';

class WhistlistCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          Image.asset(
            'assets/button_wishlist_blue.png',
            width: 34,
          ),
          SizedBox(
            width: 12,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: primaryTextColor,
              child: Image.asset(
                'assets/3 (1).png',
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
                  'Beras Medium',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  'Rp. 51.000',
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
