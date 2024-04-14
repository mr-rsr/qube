import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qube/components/card.dart';
import 'package:qube/components/wallet_money.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qube/view/bidding_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            SizedBox(
              height: 40,
              //color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/qube_logo.png",
                          height: 30, width: 30),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("Qube Bidding", //logoName
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  WalletMoney(
                    backgroundColor: const Color(0xffF0F1F5),
                    textColor: Colors.black,
                    iconColor: Colors.black,
                    text: "₹10,000",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child:
                                CircularProgressIndicator())); // Show a loading indicator while waiting for data
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    var products = snapshot.data!.docs;
                    return ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        var product = products[index].data();

                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BiddingScreen(
                                  productId: products[index].id.toString(),
                                  title: product['title'],
                                  description: product['description'],
                                  images: product['images'],
                                ),
                              )),
                          child: HomePageCard(
                            title: product['title'],
                            description: product['description'],
                            imageUrl: product['images'],
                          ),
                        );
                      },
                    );
                  }
                }),
            // const SizedBox(height: 20),
            // const HomePageCard(),
            // const SizedBox(height: 20),
            // const HomePageCard(),
            // const SizedBox(height: 20),
            // const HomePageCard(),
          ],
        ),
      ),
    );
  }
}
