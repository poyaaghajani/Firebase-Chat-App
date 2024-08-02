import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/common/entities/entities.dart';
import 'package:firebase_chat_app/common/routes/names.dart';
import 'package:firebase_chat_app/common/store/store.dart';
import 'package:firebase_chat_app/common/widgets/toast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'index.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['openid'],
);

class SignInController extends GetxController {
  final state = SignInState();
  SignInController();

  final db = FirebaseFirestore.instance;

  Future handleSignIn() async {
    try {
      var user = await _googleSignIn.signIn();

      if (user != null) {
        final gAuthentication = await user.authentication;
        var credential = GoogleAuthProvider.credential(
          idToken: gAuthentication.idToken,
          accessToken: gAuthentication.accessToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? "";

        // Save user information to device
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;
        userProfile.accessToken = id;

        UserStore.to.saveProfile(userProfile);

        var userBase = await db
            .collection("users")
            .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userData, options) {
                  return userData.toFirestore();
                })
            .where("id", isEqualTo: id)
            .get();

        if (userBase.docs.isEmpty) {
          final data = UserData(
            email: email,
            id: id,
            photourl: photoUrl,
            name: displayName,
            location: '',
            fcmtoken: '',
            addtime: Timestamp.now(),
          );
          await db
              .collection("users")
              .withConverter(
                  fromFirestore: UserData.fromFirestore,
                  toFirestore: (UserData userData, options) {
                    return userData.toFirestore();
                  })
              .add(data);
        } else {
          toastInfo(msg: "login Success");
          Get.offAndToNamed(AppRoutes.Application);
        }
      }
    } catch (ex) {
      toastInfo(msg: "login Error");
      log(ex.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          log('user is currently logged out');
        } else {
          log('user logged in');
        }
      },
    );
  }
}
