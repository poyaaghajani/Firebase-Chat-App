import 'package:firebase_chat_app/common/values/colors.dart';
import 'package:firebase_chat_app/common/values/shadows.dart';
import 'package:firebase_chat_app/common/widgets/button.dart';
import 'package:firebase_chat_app/pages/sign_in/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // build logo
    Widget _buildLogo() {
      return Container(
        width: 110.w,
        margin: EdgeInsets.only(top: 84.h),
        child: Column(
          children: [
            Container(
              width: 76.w,
              height: 76.h,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: 76.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackground,
                        boxShadow: const [Shadows.primaryShadow],
                        borderRadius: BorderRadius.circular(35.w),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Image.asset(
                      'assets/images/ic_launcher.png',
                      width: 76.w,
                      height: 76.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
              child: Text(
                "let's Chat",
                style: TextStyle(
                  color: AppColors.thirdElement,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildThirdPartyLogin() {
      return Container(
        width: 295.w,
        margin: EdgeInsets.only(bottom: 280.h),
        child: Column(
          children: [
            Text(
              'Sign in with social networks',
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                right: 50.w,
                left: 50.w,
              ),
              child: btnFlatButtonWidget(
                title: 'Google Login',
                width: 200.w,
                height: 50.h,
                onPressed: () {},
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _buildLogo(),
            const Spacer(),
            _buildThirdPartyLogin(),
          ],
        ),
      ),
    );
  }
}
