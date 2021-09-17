// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../models/orders.dart';
import '../../models/products.dart';
import '../../views/admin/orders/admin_orders_view.dart';
import '../../views/admin/orders_detail/admin_orders_detail_view.dart';
import '../../views/admin/products/admin_products_view.dart';
import '../../views/users/1_onboarding/onboarding_view.dart';
import '../../views/users/2_login_sms/sms_phone_code_view.dart';
import '../../views/users/2_login_sms/sms_phone_number_view.dart';
import '../../views/users/3_products/products_view.dart';
import '../../views/users/4_product_detail/product_detail_view.dart';
import '../../views/users/5_order/order_view.dart';
import '../../views/users/6_order_shipping/shipping_order_view.dart';
import '../../views/users/7_payment/payment_view.dart';
import '../../views/users/user_orders/user_orders_view.dart';
import '../../views/users/user_profile/user_profile_view.dart';

class Routes {
  static const String onboardingView = '/';
  static const String smsPhoneNumberView = '/sms-phone-number-view';
  static const String smsPhoneCodeView = '/sms-phone-code-view';
  static const String productsView = '/products-view';
  static const String productDetailView = '/product-detail-view';
  static const String userProfileView = '/user-profile-view';
  static const String userOrdersView = '/user-orders-view';
  static const String orderView = '/order-view';
  static const String shippingOrderView = '/shipping-order-view';
  static const String paymentView = '/payment-view';
  static const String adminOrdersView = '/admin-orders-view';
  static const String adminOrdersDetailView = '/admin-orders-detail-view';
  static const String adminProductsView = '/admin-products-view';
  static const all = <String>{
    onboardingView,
    smsPhoneNumberView,
    smsPhoneCodeView,
    productsView,
    productDetailView,
    userProfileView,
    userOrdersView,
    orderView,
    shippingOrderView,
    paymentView,
    adminOrdersView,
    adminOrdersDetailView,
    adminProductsView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.onboardingView, page: OnboardingView),
    RouteDef(Routes.smsPhoneNumberView, page: SmsPhoneNumberView),
    RouteDef(Routes.smsPhoneCodeView, page: SmsPhoneCodeView),
    RouteDef(Routes.productsView, page: ProductsView),
    RouteDef(Routes.productDetailView, page: ProductDetailView),
    RouteDef(Routes.userProfileView, page: UserProfileView),
    RouteDef(Routes.userOrdersView, page: UserOrdersView),
    RouteDef(Routes.orderView, page: OrderView),
    RouteDef(Routes.shippingOrderView, page: ShippingOrderView),
    RouteDef(Routes.paymentView, page: PaymentView),
    RouteDef(Routes.adminOrdersView, page: AdminOrdersView),
    RouteDef(Routes.adminOrdersDetailView, page: AdminOrdersDetailView),
    RouteDef(Routes.adminProductsView, page: AdminProductsView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    OnboardingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnboardingView(),
        settings: data,
      );
    },
    SmsPhoneNumberView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SmsPhoneNumberView(),
        settings: data,
      );
    },
    SmsPhoneCodeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SmsPhoneCodeView(),
        settings: data,
      );
    },
    ProductsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ProductsView(),
        settings: data,
      );
    },
    ProductDetailView: (data) {
      var args = data.getArgs<ProductDetailViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProductDetailView(product: args.product),
        settings: data,
      );
    },
    UserProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserProfileView(),
        settings: data,
      );
    },
    UserOrdersView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const UserOrdersView(),
        settings: data,
      );
    },
    OrderView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const OrderView(),
        settings: data,
      );
    },
    ShippingOrderView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ShippingOrderView(),
        settings: data,
      );
    },
    PaymentView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PaymentView(),
        settings: data,
      );
    },
    AdminOrdersView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AdminOrdersView(),
        settings: data,
      );
    },
    AdminOrdersDetailView: (data) {
      var args = data.getArgs<AdminOrdersDetailViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AdminOrdersDetailView(order: args.order),
        settings: data,
      );
    },
    AdminProductsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AdminProductsView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ProductDetailView arguments holder class
class ProductDetailViewArguments {
  final Products product;
  ProductDetailViewArguments({required this.product});
}

/// AdminOrdersDetailView arguments holder class
class AdminOrdersDetailViewArguments {
  final Orders order;
  AdminOrdersDetailViewArguments({required this.order});
}
