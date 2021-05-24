/*
 * @Description: 窗帘安装方式
 * @Author: iamsmiling
 * @Date: 2021-05-08 12:12:01
 * @LastEditTime: 2021-05-12 11:14:20
 */
// ignore: import_of_legacy_library_into_null_safe
import 'package:taoju5_bc/utils/json_kit.dart';

class WindowInstalllModeEntity {
  late String label;
  late List<WindowInstallModeOptionEntity> options;

  WindowInstalllModeEntity.fromJson(Map json) {
    label = json["label"];
    options = JsonKit.asList(json["options"])
        .map((e) => WindowInstallModeOptionEntity.fromJson(e))
        .toList();
  }

  ///返回窗型图片
  String getMainImage(int windowOptionId) {
    for (int i = 0; i < options.length; i++) {
      WindowInstallModeOptionEntity o = options[i];
      if (o.windowOptionId == windowOptionId) {
        print(o.image);
        return o.image;
      }
    }
    return "";
  }

  ///安装方式可选项
  List<WindowInstallModeOptionEntity> getInstallOptions(int windowOptionId) {
    List<WindowInstallModeOptionEntity> list = [];
    for (int i = 0; i < options.length; i++) {
      WindowInstallModeOptionEntity o = options[i];
      if (o.windowOptionId == windowOptionId) {
        list.add(o);
      }
    }
    return list;
  }
}

class WindowInstallModeOptionEntity {
  late int windowOptionId;
  late String name;
  late String image;
  late bool selected;

  WindowInstallModeOptionEntity.fromJson(Map json) {
    windowOptionId = json["window_option_id"];
    name = json["name"];
    image = json["img"];
    selected = json["selected"];
  }
}