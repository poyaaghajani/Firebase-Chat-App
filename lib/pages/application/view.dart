import 'package:firebase_chat_app/common/values/colors.dart';
import 'package:firebase_chat_app/pages/application/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildPageView() {
      return PageView(
        controller: controller.pageController,
        onPageChanged: controller.handlePage,
        children: [
          Container(
            child: Text('Chat'),
          ),
          Container(
            child: Text('Contact'),
          ),
          Container(
            child: Text('Profile'),
          ),
        ],
      );
    }

    Widget buildBottomNavBar() {
      return Obx(
        () => BottomNavigationBar(
          items: controller.bottomTabs,
          currentIndex: controller.state.page,
          type: BottomNavigationBarType.fixed,
          onTap: controller.handleNavBarTap,
          unselectedItemColor: AppColors.tabBarElement,
          selectedItemColor: AppColors.thirdElementText,
        ),
      );
    }

    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: buildBottomNavBar(),
    );
  }
}
