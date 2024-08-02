import 'package:firebase_chat_app/common/values/colors.dart';
import 'package:firebase_chat_app/common/widgets/app.dart';
import 'package:firebase_chat_app/pages/contact/controller.dart';
import 'package:firebase_chat_app/pages/contact/widgets/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar buildAppBar() {
      return transparentAppBar(
        title: Text(
          'Contact',
          style: TextStyle(
            color: AppColors.primaryBackground,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: const ContactList(),
    );
  }
}
