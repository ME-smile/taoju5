/*
 * @Description: 选品页面
 * @Author: iamsmiling
 * @Date: 2021-01-10 13:23:31
 * @LastEditTime: 2021-01-19 16:14:40
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taoju5/bapp/routes/bapp_pages.dart';
import 'package:taoju5/bapp/ui/pages/product/product_list/fragment/product_list_body/product_grid_mode_section.dart';
import 'package:taoju5/bapp/ui/pages/product/product_list/fragment/product_list_body/product_grid_mode_skeleton.dart';
import 'package:taoju5/bapp/ui/pages/product/product_list/fragment/product_list_body/product_list_mode_section.dart';
import 'package:taoju5/bapp/ui/pages/product/product_list/fragment/product_list_filter/product_list_filter_page.dart';
import 'package:taoju5/bapp/ui/pages/product/product_list/fragment/product_list_header.dart';
import 'package:taoju5/bapp/ui/pages/product/product_list/product_list_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/selectable_product_list/selectable_product_list_controller.dart';
import 'package:taoju5/bapp/ui/pages/search/search_controller.dart';
import 'package:taoju5/bapp/ui/widgets/base/x_loadstate_builder.dart';
import 'package:taoju5/bapp/ui/widgets/common/x_search_bar.dart';

class SelectableProductListPage
    extends GetView<SelectableProductListController> {
  const SelectableProductListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: XSearchBar(
          preferredSize: Size.fromHeight(72),
          onTap: () =>
              Get.toNamed(BAppRoutes.search, arguments: SearchType.product),
        ),
        body: GetBuilder<ProductListParentController>(
            id: "tabview",
            builder: (ProductListParentController parentController) {
              return GetBuilder<ProductListController>(
                  init: ProductListController(type: "0"),
                  tag: "0",
                  builder: (_) {
                    return Column(children: [
                      ProductListHeader(),
                      Expanded(
                          child: Scaffold(
                        key: parentController.scaffoldKey,
                        endDrawer: ProductListFilterPage(),
                        endDrawerEnableOpenDragGesture: false,
                        body: XLoadStateBuilder(
                          loadState: _.loadState,
                          loadingWidget: ProductGridModeSkeleton(),
                          builder: (BuildContext context) {
                            return GetBuilder<ProductListController>(
                              init: ProductListController(type: "0"),
                              tag: "0",
                              autoRemove: false,
                              builder: (_) {
                                return parentController.isGridMode
                                    ? ProductGridModeSection(
                                        productList: _.productList,
                                        scrollController: _.scrollController,
                                        refreshController: _.refreshController,
                                        onLoading: _.loadMore,
                                        onRefresh: _.refreshData,
                                        enablePullDown: true,
                                        enablePullUp: true,
                                      )
                                    : ProductListModeSection(
                                        productList: _.productList,
                                        scrollController: _.scrollController,
                                        refreshController: _.refreshController,
                                        onLoading: _.loadMore,
                                        onRefresh: _.refreshData,
                                        enablePullDown: true,
                                        enablePullUp: true,
                                      );
                              },
                            );
                          },
                        ),
                      ))
                    ]);
                  });
            }));
  }
}
