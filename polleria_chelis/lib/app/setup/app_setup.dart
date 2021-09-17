import 'package:polleria_chelis/views/admin/orders/admin_orders_view.dart';
import 'package:polleria_chelis/views/admin/orders_detail/admin_orders_detail_view.dart';
import 'package:polleria_chelis/views/admin/products/admin_products_view.dart';
import 'package:polleria_chelis/views/users/1_onboarding/onboarding_view.dart';
import 'package:polleria_chelis/views/users/2_login_sms/sms_phone_code_view.dart';
import 'package:polleria_chelis/views/users/2_login_sms/sms_phone_number_view.dart';
import 'package:polleria_chelis/views/users/3_products/products_view.dart';
import 'package:polleria_chelis/views/users/4_product_detail/product_detail_view.dart';
import 'package:polleria_chelis/views/users/5_order/order_view.dart';
import 'package:polleria_chelis/views/users/6_order_shipping/shipping_order_view.dart';
import 'package:polleria_chelis/views/users/7_payment/payment_view.dart';
import 'package:polleria_chelis/views/users/user_orders/user_orders_view.dart';
import 'package:polleria_chelis/views/users/user_profile/user_profile_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: OnboardingView, initial: true),
    MaterialRoute(page: SmsPhoneNumberView),
    MaterialRoute(page: SmsPhoneCodeView),
    MaterialRoute(page: ProductsView),
    MaterialRoute(page: ProductDetailView),
    MaterialRoute(page: UserProfileView),
    MaterialRoute(page: UserOrdersView),
    MaterialRoute(page: OrderView),
    MaterialRoute(page: ShippingOrderView),
    MaterialRoute(page: PaymentView),
    
    
    MaterialRoute(page: AdminOrdersView),
    MaterialRoute(page: AdminOrdersDetailView),
    MaterialRoute(page: AdminProductsView)

  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}