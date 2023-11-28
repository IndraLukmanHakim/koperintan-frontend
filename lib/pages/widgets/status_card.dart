import 'package:flutter/material.dart';
import 'package:pos/models/status_model.dart';
import 'package:pos/theme.dart';

class StatusCard extends StatelessWidget {
  @override
  final StatusModel status;
  const StatusCard(this.status, {super.key});

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah Order : ',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Rp. ${status.totalPrice}',
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
                      'Tanggal Transaksi',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${status.createdAt}',
                      style: priceTextStyle.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Point yang didapat : ',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${status.point}',
                      style: priceTextStyle.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'status',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${status.status}',
                      style: priceTextStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
