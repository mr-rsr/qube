import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qube/res/string.dart';
import 'package:qube/utils/google_login.dart';
import 'package:qube/view/index_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 5),
            const Text(logoName,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            Image.asset("assets/images/qube_logo.png", height: 108, width: 108),
            const SizedBox(height: 5),
            // login with google button
            SizedBox(
              width: 250,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0B0C11),
                  // foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    //color: Colors.white,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  googleSignIn().then((value) {
                    if (value != null) {
                      setState(() {
                        isLoading = false;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const IndexPage()),
                            (route) => false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login successful!"),
                          ),
                        );
                      });
                    } else {
                      setState(() {
                        isLoading = false;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("login failed, please try again!"),
                        ));
                      });
                    }
                  }).catchError((onError) {
                    setState(() {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("login failed, please try again!"),
                      ));
                    });
                  });
                },
                child: !isLoading
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            height: 20,
                            width: 20,
                            image: AssetImage('assets/images/googleLogo.png'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Login with Google',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              )),
                        ],
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Logging in...',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              )),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
