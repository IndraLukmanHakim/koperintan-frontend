import 'package:flutter/material.dart';
import 'package:pos/models/cart_model.dart';
import 'package:pos/theme.dart';

class CheckoutCard extends StatelessWidget {
  @override
  final CartModel cart;
  const CheckoutCard(this.cart, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 12,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(cart.product!.galleries![0].url!),
              ),
              color: backgroundColor6,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.product!.name!,
                  // 'Gula ManisKita',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  'Rp. ${cart.product!.price}',
                  style: priceTextStyle,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            '${cart.quantity} item',
            style: secondaryTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
