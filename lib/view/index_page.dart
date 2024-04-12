import 'package:flutter/material.dart';
import 'package:qube/view/home_page.dart';
import 'package:qube/view/wallet_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const <Widget>[HomePage(), WalletPage()],
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 70),
        color: Colors.white,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color(0xff0B0C11).withOpacity(.5),
          // selectedIconTheme: const IconThemeData(color: Colors.black),
          // unselectedIconTheme:
          //     IconThemeData(color: const Color(0xff0B0C11).withOpacity(.66)),
          onTap: (index) => _onItemTapped(index),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded, size: 32),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/wallet.png"),
                size: 32,
              ),
              label: "Wallet",
            ),
          ],
        ),
      ),
    );
  }
}
