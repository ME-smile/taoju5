/*
 * @Description: 搭配精选弹窗
 * @Author: iamsmiling
 * @Date: 2021-01-15 15:28:22
 * @LastEditTime: 2021-01-19 16:27:21
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taoju5/bapp/domain/model/product/product_model.dart';
import 'package:taoju5/bapp/res/b_dimens.dart';
import 'package:taoju5/bapp/ui/modal/base/x_base_modal.dart';
import 'package:taoju5/bapp/ui/pages/product/product_list/fragment/product_list_body/product_grid_mode_section.dart';

Future showMixedProductModal(BuildContext context,
    {@required List<ProductModel> productList}) {
  return showCupertinoModalPopup(
      builder: (BuildContext context) {
        return XBaseModal(
            header: Padding(
              padding: EdgeInsets.only(top: 16, bottom: BDimens.gap32),
              child: Text(
                "搭配精选",
                style: TextStyle(
                    fontSize: BDimens.sp32, fontWeight: FontWeight.w500),
              ),
            ),
            divider: Divider(
              height: .5,
              thickness: .5,
            ),
            // onClose: Navigator.of(context).pop,
            height: MediaQuery.of(context).size.height * .90,
            builder: (BuildContext context) {
              return Container(
                child: ProductGridModeSection(
                    productList: productList,
                    enablePullDown: false,
                    enablePullUp: false),
              );
            });
      },
      context: context);
}
