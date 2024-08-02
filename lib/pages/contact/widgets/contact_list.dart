import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_chat_app/common/values/colors.dart';
import 'package:firebase_chat_app/pages/contact/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.zero,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: controller.state.contactList.length,
                (context, index) {
                  var item = controller.state.contactList[index];

                  return Container(
                    padding:
                        EdgeInsets.only(right: 15.w, top: 15.h, left: 15.w),
                    child: InkWell(
                      onTap: () {
                        if (item.id != null) {
                          controller.goChat(item);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 15.w),
                            child: SizedBox(
                              width: 54.w,
                              height: 54.w,
                              child: CachedNetworkImage(
                                imageUrl: item.photourl ?? '',
                              ),
                            ),
                          ),
                          Container(
                            width: 250.w,
                            padding: EdgeInsets.only(top: 8.h),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Color(0xffe5efe5),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 200.w,
                                  height: 42.h,
                                  child: Text(
                                    item.name ?? '',
                                    style: TextStyle(
                                      fontFamily: "Aviner",
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.thirdElement,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
