import 'package:get/get.dart';
import 'package:taoju5/bapp/domain/repository/login/login_repository.dart';
import 'package:taoju5/bapp/routes/bapp_pages.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ModifyPasswordController extends GetxController {
  LoginRepository _repository = LoginRepository();
  String tel;
  String code;
  String passowrd;

  void setPassword(String text) {
    passowrd = text;
  }

  @override
  void onInit() {
    tel = Get.parameters["tel"];
    code = Get.parameters["code"];
    super.onInit();
  }

  Future submit() {
    if (GetUtils.isNullOrBlank(passowrd)) {
      EasyLoading.showInfo("密码不能为空哦");
      return Future.error(false);
    }
    return _repository.setPassword(params: {
      "mobile": tel,
      "mobile_code": code,
      "password": passowrd
    }).then((value) {
      Get.offAllNamed(BAppRoutes.login);
    });
  }
}
