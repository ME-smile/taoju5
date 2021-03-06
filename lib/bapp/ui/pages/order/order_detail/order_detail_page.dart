/*
 * @Description: 商品详情页
 * @Author: iamsmiling
 * @Date: 2020-12-22 14:35:39
 * @LastEditTime: 2021-04-26 10:51:37
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taoju5/bapp/res/b_dimens.dart';
import 'package:taoju5/bapp/ui/pages/order/order_detail/fragment/order_datail_footer.dart';
import 'package:taoju5/bapp/ui/pages/order/order_detail/fragment/order_note_bar.dart';
import 'package:taoju5/bapp/ui/pages/order/order_detail/order_detail_skeleton.dart';
import 'package:taoju5/bapp/ui/widgets/base/x_loadstate_builder.dart';

import 'fragment/order_action_tip_bar.dart';
import 'fragment/order_address_card.dart';
import 'fragment/order_detail_body.dart';
import 'fragment/order_detail_bottom_action_bar.dart';
import 'fragment/order_detail_header.dart';
import 'fragment/order_detail_sheet.dart';
import 'fragment/order_logistics_card.dart';
import 'fragment/order_manual_script_card.dart';
import 'order_detail_controller.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      builder: (_) {
        return XLoadStateBuilder(
          loadState: _.loadState,
          retry: _.loadData,
          ifErrorBack: true,
          loadingWidget: OrderDetailSkeleton(),
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: Text("订单详情"),
              ),
              backgroundColor: Get.theme.primaryColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    OrderDetailHeader(),
                    OrderLogisticsCard(),
                    Divider(
                      indent: BDimens.gap32,
                      endIndent: BDimens.gap32,
                    ),
                    OrderAddressCard(),
                    Divider(
                      indent: BDimens.gap32,
                      endIndent: BDimens.gap32,
                    ),
                    OrderActionTipBar(),
                    Divider(
                      indent: BDimens.gap32,
                      endIndent: BDimens.gap32,
                    ),
                    OrderDetailBody(),
                    OrderDetailSheet(),
                    OrderNoteBar(),
                    OrderManualScriptCard(),
                    Divider(
                      indent: BDimens.gap32,
                      endIndent: BDimens.gap32,
                    ),
                    OrderDetailFooter(),
                  ],
                ),
              ),
              bottomNavigationBar: OrderDetailBottomActionBar(),
            );
          },
        );
      },
    );
  }
}
