import 'package:flutter/material.dart';

class CustomModalSheet extends StatelessWidget {
  const CustomModalSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, top: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          //  height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xffE3E6ED),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    //     height: 40,
                    width: 230,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Add New Bid",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        Flexible(
                          child: Text(
                              "The bid amount will be blocked from your Qube Wallet till the bidding ends",
                              softWrap: true,
                              style: TextStyle(
                                color: const Color(0xff0B0C11).withOpacity(.66),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Current Top Bid",
                        style: TextStyle(
                          color: const Color(0xff0B0C11).withOpacity(.66),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "₹540",
                        style: TextStyle(
                          color: Color(0xff0B0C11),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                          height: 6,
                          width: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xff0f0f10).withOpacity(0.24),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 18,
                              height: 6,
                              decoration: BoxDecoration(
                                color: const Color(0xff0b0c11),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ))
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                shape: BeveledRectangleBorder(
                    side: BorderSide(
                        width: 0.5,
                        color: const Color(0xff230046).withOpacity(.65)),
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(8))),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    hintText: "Enter Bid Amount",
                    hintStyle: TextStyle(
                      color: const Color(0xff0F0F10).withOpacity(.24),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.currency_rupee,
                      color: const Color(0xff230046).withOpacity(.65),
                      weight: 50,
                      size: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0B0C11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Bid",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
