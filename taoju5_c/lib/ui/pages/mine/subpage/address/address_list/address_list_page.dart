/*
 * @Description: 地址列表页
 * @Author: iamsmiling
 * @Date: 2021-04-14 09:40:34
 * @LastEditTime: 2021-04-17 18:31:54
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taoju5_c/res/R.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/address/address_list/address_list_controller.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/address/wdiget/addresss_card.dart';

class AddressListPage extends StatelessWidget {
  const AddressListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressListController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("地址管理"),
          ),
          body: ListView.separated(
              itemBuilder: (BuildContext context, int i) {
                return AddressCard(address: _.addresses[i]);
              },
              separatorBuilder: (BuildContext context, int i) =>
                  Divider(indent: R.dimen.dp24, endIndent: R.dimen.dp24),
              itemCount: _.addresses.length),
        );
      },
    );
  }
}
