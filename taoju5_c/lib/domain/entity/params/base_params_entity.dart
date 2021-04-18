/*
 * @Description:  参数模型
 * @Author: iamsmiling
 * @Date: 2021-04-15 15:42:35
 * @LastEditTime: 2021-04-18 00:07:22
 */
import 'package:get/get.dart';

abstract class BaseParamsEntity {
  bool validate();

  bool isNullOrZero(dynamic val) {
    if (val == null) return true;
    if (val is num) return val == 0;
    if (val is String && GetUtils.isNum(val)) {
      val = num.parse(val);
      return val == 0;
    }
    return false;
  }

  bool isNullOrEmpty(dynamic val) {
    if (val == null) return true;
    if (val is Iterable) return val.isEmpty;
    return false;
  }

  bool isMobileNumber(String val) {
    if (GetUtils.isNullOrBlank(val)!) return false;
    return RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(val);
  }

  Map get params;
}
