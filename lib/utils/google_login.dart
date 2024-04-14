import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential?> googleSignIn() async {
  final googleSignIn = GoogleSignIn();
  final googleUser = await googleSignIn.signIn();
  if (googleUser == null) return null;

  final googleAuth = await googleUser.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  UserCredential user =
      await FirebaseAuth.instance.signInWithCredential(credential);
  FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
    'name': user.user!.displayName,
    'email': user.user!.email,
    'photoUrl': user.user!.photoURL,
    'wallet': 10000,
  });
  return user;
}
