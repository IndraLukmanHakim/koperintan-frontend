import 'package:flutter/material.dart';
import 'package:pos/theme.dart';

class StatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Container(
          //   width: 60,
          //   height: 60,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //     image: DecorationImage(
          //       image: AssetImage('assets/1.png'),
          //     ),
          //     color: backgroundColor6,
          //   ),
          // ),
          // SizedBox(
          //   width: 12,
          // ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jumlah Order : 2 Items',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Rp. 28.000',
                  style: priceTextStyle,
                )
              ],
            ),
          ),
          // SizedBox(
          //   width: 12,
          // ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Status',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'PENDING',
                  style: priceTextStyle,
                )
              ],
            ),
          ),
          // Text(
          //   'PENDING',
          //   style: secondaryTextStyle.copyWith(
          //     fontSize: 12,
          //   ),
          // ),
        ],
      ),
    );
  }
}
