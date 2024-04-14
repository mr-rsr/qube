import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qube/components/custom_modal_sheet.dart';
import 'package:qube/components/wallet_money.dart';
import 'package:qube/utils/show_custom_sheet.dart';

class BiddingScreen extends StatefulWidget {
  const BiddingScreen(
      {super.key,
      required this.productId,
      required this.images,
      required this.title,
      required this.description});
  final String productId;
  final List<dynamic> images;
  final String title;
  final String description;
  @override
  State<BiddingScreen> createState() => _BiddingScreenState();
}

class _BiddingScreenState extends State<BiddingScreen> {
  final PageController _productController = PageController();
  final TextEditingController _messageController = TextEditingController();
  int _currentPage = 0;
  late Timer _timerB;
  @override
  void initState() {
    super.initState();
    _timerB = Timer.periodic(const Duration(seconds: 3), (timer) {
      _productController.animateToPage(_currentPage + 1,
          duration: const Duration(seconds: 1), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    _timerB.cancel();
    _productController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: PageView.builder(
                controller: _productController,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return Image.network(widget.images[index], fit: BoxFit.cover);
                },
                onPageChanged: (int page) {
                  //  debugPrint("Page changed to $page");
                  setState(() {
                    _currentPage = page;
                    if (_currentPage == widget.images.length - 1) {
                      // Reset to the first page when reaching the end
                      Timer(const Duration(milliseconds: 3000), () {
                        _productController.jumpToPage(0);
                      });
                    }
                  });
                }),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.7),
                    Colors.black
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      onSubmitted: (value) {
                        if (value.isEmpty) {
                          return;
                        } else if (value.length > 100) {
                          return;
                        } else {
                          FirebaseFirestore.instance
                              .collection('products')
                              .doc(widget.productId)
                              .collection('messages')
                              .add({
                            'message': value,
                            'timestamp': FieldValue.serverTimestamp(),
                            'sender': FirebaseAuth.instance.currentUser!.uid,
                            'name':
                                FirebaseAuth.instance.currentUser!.displayName,
                            'isBid': false
                          });
                        }
                        _messageController.clear();
                        // Clear the text field
                        // setState(() {
                        //   _messageController.clear();
                        // });
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 0),
                        hintText: "Say something nice...",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.32),
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(33),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(33),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(33),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        showCustomModal(
                            context,
                            CustomModalSheet(
                              title: "Add New Bid",
                              id: widget.productId,
                            ));
                      },
                      child: const Center(
                        child: Text("Bid",
                            style: TextStyle(
                              color: Color(0xff0B0C11),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 56,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 180,
                            child: Text(
                              widget.description,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      WalletMoney(
                          backgroundColor:
                              const Color(0xff0f0f10).withOpacity(.24),
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          text: "10,000"),
                      const SizedBox(width: 16),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Top Bid',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.6))),
                          const Text('₹500',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                          Text('Bid #2',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white.withOpacity(0.6))),
                          const Text('₹460',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                          Text('Bid #2',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white.withOpacity(0.6))),
                          const Text('₹440',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 80,
            right: 0,
            left: 0,
            //right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 200,
                  width: 250,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .doc(widget.productId)
                        .collection("messages")
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: SizedBox());
                      } else if (snapshot.hasError) {
                        debugPrint("error");
                        return const SizedBox();
                      } else {
                        var messages = snapshot.data!.docs;
                        return ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            var message = messages[index].data();
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xff0f0f10).withOpacity(0.24),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      // color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    height: 16,
                                    width: 16,
                                    child: Image.network(message['sender'] ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? FirebaseAuth
                                            .instance.currentUser!.photoURL!
                                        : "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    message['sender'] ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? "You: "
                                        : "${message['sender']}: ",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      message['message'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 82,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('My Bids',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(0.6))),
                      ListView(
                        padding: const EdgeInsets.only(top: 6),
                        shrinkWrap: true,
                        children: [
                          Row(
                            children: [
                              const Text('₹4400',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white)),
                              const SizedBox(
                                width: 5,
                              ),
                              Text('12m',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white.withOpacity(0.6))),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
          ),
          // Positioned(
          //   bottom: 60,
          //   child:
          // )
        ],
      ),
    );
  }
}
