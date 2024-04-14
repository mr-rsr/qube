import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qube/components/ticker.dart';

class HomePageCard extends StatefulWidget {
  const HomePageCard(
      {super.key,
      required this.title,
      required this.description,
      required this.imageUrl});
  final String title;
  final String description;
  final List<dynamic> imageUrl;
  @override
  State<HomePageCard> createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {
  final PageController _imageController = PageController();
  int _currentImage = 0;
  late Timer _imageTimer;
  final PageController _controller = PageController(
    initialPage: 0,
    viewportFraction: 0.3,
  );
  final int _numPages = 10;
  int _currentPage = 0;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _controller.animateToPage(_currentPage + 1,
          duration: const Duration(seconds: 1), curve: Curves.ease);
    });

    _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _imageController.animateToPage(_currentImage + 1,
          duration: const Duration(seconds: 3), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    _imageTimer.cancel();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 480,
        maxWidth: 328,
      ),
      child: Stack(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxHeight: 480,
              maxWidth: 328,
            ),
            child: PageView.builder(
              controller: _imageController,
              itemCount: widget.imageUrl.length,
              itemBuilder: (context, index) {
                return Container(
                  constraints: const BoxConstraints(
                    maxHeight: 480,
                    maxWidth: 328,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                        image: NetworkImage(widget.imageUrl[index]),
                        fit: BoxFit.cover),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
              onPageChanged: (int page) {
                setState(() {
                  _currentImage = page;
                  if (_currentImage == widget.imageUrl.length - 1) {
                    // Reset to the first page when reaching the end
                    Timer(const Duration(milliseconds: 3000), () {
                      _imageController.jumpToPage(0);
                    });
                  }
                });
              },
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 480,
                maxWidth: 328,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0, top: 16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Ends in',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff0f0f10).withOpacity(0.24),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            height: 24,
                            width: 65,
                            child: const Center(
                              child: Text('15m 45s', //time
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 196,
                    width: 328,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                          Colors.black,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.title,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(widget.description,
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xffF9F9FB).withOpacity(.16),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, //spaceAround
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Top Bid',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                                    .withOpacity(0.6))),
                                        const Text('₹500',
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 55,
                                      child: VerticalDivider(
                                        color: Colors.white.withOpacity(0.6),
                                        thickness: 1,
                                        width: 1,
                                        indent: 4,
                                        endIndent: 4,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text('Bid #2',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white
                                                        .withOpacity(0.6))),
                                            const SizedBox(width: 5),
                                            const Text('₹450',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text('Bid #3',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white
                                                        .withOpacity(0.6))),
                                            const SizedBox(width: 5),
                                            const Text('₹450',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 12),
                              height: 140,
                              child: AbsorbPointer(
                                absorbing: true,
                                child: PageView.builder(
                                  controller: _controller,
                                  itemCount: _numPages,
                                  itemBuilder: (context, index) {
                                    return AnimatedOpacity(
                                      duration: const Duration(seconds: 1),
                                      opacity:
                                          index == _currentPage + 1 ? 1.0 : 0.5,
                                      child: Transform.scale(
                                        scale:
                                            index == _currentPage + 1 ? 1 : 0.9,
                                        child: const UnconstrainedBox(
                                            child: TickerWidget()),
                                      ),
                                    );
                                  },
                                  scrollDirection: Axis.vertical,
                                  onPageChanged: (int page) {
                                    setState(() {
                                      _currentPage = page;
                                      if (_currentPage == _numPages - 1) {
                                        // Reset to the first page when reaching the end
                                        _controller.jumpToPage(0);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
