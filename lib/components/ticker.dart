import 'package:flutter/material.dart';

class TickerWidget extends StatelessWidget {
  const TickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 24,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xffF9F9FB).withOpacity(.16),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, //spaceAround
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
            child: Stack(
              children: [
                SizedBox(
                  height: 16,
                  width: 16,
                  child: Image.asset("assets/images/avatar.png"),
                ),
                Positioned(
                  left: 14,
                  top: 0,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Center(
                      child: Text("B1",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Text("₹200",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text("2m",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.6))),
        ],
      ),
    );
  }
}
