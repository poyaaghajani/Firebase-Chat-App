// import 'package:firebase_chat_app/common/routes/names.dart';
// import 'package:firebase_chat_app/common/store/config.dart';
// import 'package:firebase_chat_app/common/store/user.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class RouteWelcomeMiddleware extends GetMiddleware {
//   // priority 数字小优先级高
//   @override
//   int? priority = 0;
//
//   RouteWelcomeMiddleware({required this.priority});
//
//   @override
//   RouteSettings? redirect(String? route) {
//     print(ConfigStore.to.isFirstOpen);
//     if (ConfigStore.to.isFirstOpen == false) {
//       return null;
//     } else if (UserStore.to.isLogin == true) {
//       return RouteSettings(name: AppRoutes.Application);
//     } else {
//       return RouteSettings(name: AppRoutes.SIGN_IN);
//     }
//   }
// }
