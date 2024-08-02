import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/common/entities/entities.dart';
import 'package:firebase_chat_app/common/store/store.dart';
import 'package:firebase_chat_app/pages/contact/state.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  ContactController();
  final state = ContactState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  /// We do not want show current user on contact list
  Future asyncLoadAllData() async {
    var userbase = await db
        .collection("users")
        .where("id", isNotEqualTo: token)
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) {
            return userData.toFirestore();
          },
        )
        .get();

    for (var doc in userbase.docs) {
      state.contactList.add(doc.data());
    }
  }

  Future goChat(UserData toUserData) async {
    var fromMessages = await db
        .collection('message')
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) {
            return msg.toFirestore();
          },
        )
        .where('from_uid', isEqualTo: token)
        .where('to_uid', isEqualTo: toUserData.id)
        .get();

    var toMessages = await db
        .collection('message')
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) {
            return msg.toFirestore();
          },
        )
        .where('from_uid', isEqualTo: toUserData.id)
        .where('to_uid', isEqualTo: token)
        .get();

    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();

      UserLoginResponseEntity userData =
          UserLoginResponseEntity.fromJson(jsonDecode(profile));

      var msgData = Msg(
        from_uid: userData.accessToken,
        to_uid: toUserData.id,
        from_name: userData.displayName,
        to_name: toUserData.name,
        from_avatar: userData.photoUrl,
        to_avatar: toUserData.photourl,
        last_msg: '',
        last_time: Timestamp.now(),
        msg_num: 0,
      );

      db
          .collection("message")
          .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (msg, options) {
              return msg.toFirestore();
            },
          )
          .add(msgData)
          .then((value) {
        Get.toNamed('/chat', parameters: {
          'doc_id': value.id,
          'to_uid': toUserData.id ?? '',
          'to_name': toUserData.name ?? '',
          'to_avatar': toUserData.photourl ?? '',
        });
      });
    } else {
      if (fromMessages.docs.isNotEmpty) {
        Get.toNamed('/chat', parameters: {
          'doc_id': fromMessages.docs.first.id,
          'to_uid': toUserData.id ?? '',
          'to_name': toUserData.name ?? '',
          'to_avatar': toUserData.photourl ?? '',
        });
      }
      if (toMessages.docs.isNotEmpty) {
        Get.toNamed('/chat', parameters: {
          'doc_id': toMessages.docs.first.id,
          'to_uid': toUserData.id ?? '',
          'to_name': toUserData.name ?? '',
          'to_avatar': toUserData.photourl ?? '',
        });
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }
}
