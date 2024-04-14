import 'package:flutter/material.dart';

class WalletMoney extends StatelessWidget {
  const WalletMoney({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.text,
  });
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageIcon(
            const AssetImage("assets/images/wallet.png"),
            size: 20,
            color: iconColor,
          ),
          Text("₹$text",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }
}
