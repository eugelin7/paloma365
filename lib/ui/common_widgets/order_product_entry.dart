import 'package:flutter/material.dart';
import 'package:testtask/=models=/product.dart';

class OrderProductEntry extends StatelessWidget {
  final Product product;
  final int amount;
  final double? height;
  final bool topBorder;
  final bool bottomBorder;

  const OrderProductEntry({
    super.key,
    required this.product,
    required this.amount,
    this.height,
    this.topBorder = false,
    this.bottomBorder = false,
  });

  static const kTextStyle = TextStyle(fontSize: 16.5);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border(
          top: topBorder
              ? BorderSide(color: Colors.grey.shade300)
              : const BorderSide(color: Colors.transparent),
          bottom: bottomBorder
              ? BorderSide(color: Colors.grey.shade300)
              : const BorderSide(color: Colors.transparent),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: kTextStyle,
            ),
          ),
          const SizedBox(width: 10),
          Text(amount.toString(), style: kTextStyle),
          const SizedBox(width: 22),
        ],
      ),
    );
  }
}
