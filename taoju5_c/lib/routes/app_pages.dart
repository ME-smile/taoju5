/*
 * @Description: c端app
 * @Author: iamsmiling
 * @Date: 2021-02-02 22:39:50
 * @LastEditTime: 2021-04-24 21:03:09
 */

import 'package:get/get.dart';
import 'package:taoju5_c/ui/pages/article/article_detail_binding.dart';
import 'package:taoju5_c/ui/pages/article/article_detail_page.dart';
import 'package:taoju5_c/ui/pages/category/category_binding.dart';
import 'package:taoju5_c/ui/pages/category/category_page.dart';
import 'package:taoju5_c/ui/pages/fresco/fresco_page.dart';
import 'package:taoju5_c/ui/pages/image_crop/image_crop_binding.dart';
import 'package:taoju5_c/ui/pages/image_crop/image_crop_page.dart';
import 'package:taoju5_c/ui/pages/login/bussiness_login/business_login_binding.dart';
import 'package:taoju5_c/ui/pages/login/bussiness_login/business_password_login_page.dart';
import 'package:taoju5_c/ui/pages/login/bussiness_login/business_sms_login_page.dart';
import 'package:taoju5_c/ui/pages/login/customer_login/customer_login_binding.dart';
import 'package:taoju5_c/ui/pages/login/customer_login/customer_password_login_page.dart';
import 'package:taoju5_c/ui/pages/login/customer_login/customer_sms_login_page.dart';
import 'package:taoju5_c/ui/pages/login/guide/login_guide_binding.dart';
import 'package:taoju5_c/ui/pages/login/guide/login_guide_page.dart';
import 'package:taoju5_c/ui/pages/login/modify_password/modify_password_binding.dart';
import 'package:taoju5_c/ui/pages/login/modify_password/modify_password_first_page.dart';
import 'package:taoju5_c/ui/pages/login/modify_password/modify_password_second_page.dart';
import 'package:taoju5_c/ui/pages/login/modify_telephone/modify_telephone_binding.dart';
import 'package:taoju5_c/ui/pages/login/modify_telephone/modify_telephone_fisrt_page.dart';
import 'package:taoju5_c/ui/pages/login/modify_telephone/modify_telephone_second_page.dart';
import 'package:taoju5_c/ui/pages/main/main_page.dart';
import 'package:taoju5_c/ui/pages/mine/mine_binding.dart';
import 'package:taoju5_c/ui/pages/mine/mine_page.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/account/account_page.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/address/address_edit/address_edit_binding.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/address/address_edit/address_edit_page.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/address/address_list/address_list_binding.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/address/address_list/address_list_page.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/feedback/feedback_binding.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/feedback/feedback_page.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/profile/profile_binding.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/profile/profile_page.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/profile/subpage/modify_user_avatar/modify_user_avatar_binding.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/profile/subpage/modify_user_avatar/modify_user_avatar_page.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/profile/subpage/modify_user_nickname_page.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/setting/setting_binding.dart';
import 'package:taoju5_c/ui/pages/mine/subpage/setting/setting_page.dart';
import 'package:taoju5_c/ui/pages/product/product_detail/product_detail_binding.dart';
import 'package:taoju5_c/ui/pages/product/product_detail/product_detail_page.dart';
import 'package:taoju5_c/ui/pages/product/product_list/product_list_binding.dart';
import 'package:taoju5_c/ui/pages/product/product_list/product_list_controller.dart';
import 'package:taoju5_c/ui/pages/product/product_list/product_list_page.dart';
import 'package:taoju5_c/ui/pages/video/video_player_binding.dart';
import 'package:taoju5_c/ui/pages/video/video_player_page.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    ///登录
    GetPage(
      name: AppRoutes.fresco,
      page: () => FrescoPage(),
    ),

    ///登录
    GetPage(
        name: AppRoutes.loginGuide,
        page: () => LoginGuidePage(),
        binding: LoginGuideBinding()),
    GetPage(
        name: AppRoutes.customerPasswordLogin,
        page: () => CustomerPasswordLoginPage(),
        binding: CustomerLoginBinding()),
    GetPage(
        name: AppRoutes.customerSmsLogin,
        page: () => CustomerSmsLoginPage(),
        binding: CustomerLoginBinding()),

    GetPage(
        name: AppRoutes.businessPasswordLogin,
        page: () => BusinessPasswordLoginPage(),
        binding: BusinessLoginBinding()),
    GetPage(
        name: AppRoutes.businessSmsLogin,
        page: () => BusinessSmsLoginPage(),
        binding: BusinessLoginBinding()),

    GetPage(
        name: AppRoutes.modifyPassword1,
        page: () => ModifyPasswordFirstPage(),
        binding: ModifyPasswordBinding()),

    GetPage(
        name: AppRoutes.modifyPassword2,
        page: () => ModifyPasswordSecondPage(),
        binding: ModifyPasswordBinding()),

    GetPage(
        name: AppRoutes.modifyTelephone1,
        page: () => ModifyTelephoneFirstPage(),
        binding: ModifyTelephoneBinding()),

    GetPage(
        name: AppRoutes.modifyTelephone2,
        page: () => ModifyTelephoneSecondPage(),
        binding: ModifyTelephoneBinding()),

    GetPage(
        name: AppRoutes.main, page: () => MainPage(), binding: MineBinding()),

    GetPage(
        name: AppRoutes.mine,
        page: () => MinePage(),
        binding: MineBinding(),
        children: [
          GetPage(
              name: AppRoutes.profile,
              page: () => ProfilePage(),
              binding: ProfileBinding(),
              children: [
                GetPage(
                  name: AppRoutes.modifyUserNickname,
                  page: () => ModifyUserNicknamePage(),
                  binding: ProfileBinding(),
                ),
                GetPage(
                  name: AppRoutes.modifyUserAvatar,
                  page: () => ModifyUserAvatarPage(),
                  binding: ModifyUserAvatarBinding(),
                )
              ]),

          ///地址列表
          GetPage(
              name: AppRoutes.addressList,
              page: () => AddressListPage(),
              binding: AddressListBinding()),

          ///地址编辑
          GetPage(
              name: AppRoutes.addressEdit,
              page: () => AddresseEditPage(),
              binding: AddressEditBinding()),
          GetPage(
              name: AppRoutes.setting,
              page: () => SettingPage(),
              binding: SettingBinding()),
          GetPage(
            name: AppRoutes.account,
            page: () => AccountPage(),
          ),

          GetPage(
              name: AppRoutes.feedback,
              page: () => FeedbackPage(),
              binding: FeedbackBinding())
        ]),
    GetPage(
        name: AppRoutes.category,
        page: () => CategoryPage(),
        binding: CategoryBinding(),
        children: [
          GetPage(
              name: AppRoutes.productList,
              page: () => ProductListPage(),
              binding: ProductListBinding()),
          GetPage(
              name: AppRoutes.productDetail + "/:id",
              page: () => ProductDetailPage(),
              binding: ProductDetailBinding()),
        ]),

    GetPage(
        name: AppRoutes.imageCrop,
        page: () => ImageCropPage(),
        binding: ImageCropBinding()),

    GetPage(
        name: AppRoutes.videoPlayer,
        page: () => VideoPage(),
        binding: VideoBinding()),

    GetPage(
        name: AppRoutes.articleDetail,
        page: () => ArticleDetailPage(),
        binding: ArticleDetailBinding()),

    // ///显示地图
    // GetPage(
    //     name: AppRoutes.amap,
    //     page: () => AMapViewPage(),
    //     binding: AMapViewBinding()),
  ];
}