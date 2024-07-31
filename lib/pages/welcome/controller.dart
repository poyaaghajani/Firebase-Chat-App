import 'package:firebase_chat_app/common/routes/names.dart';
import 'package:firebase_chat_app/common/store/config.dart';
import 'package:firebase_chat_app/pages/welcome/index.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();
  WelcomeController();

  changePage(int index) {
    state.index.value = index;
  }

  handleSignIn() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}
