
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';
import 'package:polleria_chelis/models/enum/order_status.dart';
import 'package:polleria_chelis/models/orders.dart';
import 'package:polleria_chelis/views/widgets/app_bar_widget.dart';
import 'package:polleria_chelis/models/enum/shipping_methods.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';
import 'admin_orders_view_model.dart';

class AdminOrdersView extends StatelessWidget{
  const AdminOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminOrdersViewModel>.reactive(
      viewModelBuilder: () => AdminOrdersViewModel(),
      onModelReady: (model) => {model.getPendingOrdersForAdmin(), model.getAttendedOrdersForAdmin(), model.getSentOrdersForAdmin(), model.getDeliveredOrdersForAdmin(), model.getCancelledOrdersForAdmin()},
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme.primaryColor,
          appBar: CustomAppBar(model.getProductNumberInCart, model.navigateToSummaryView, false),
          body: this._bodyPage(context, model),//this._body(context, model),
        ),
      ),
    );
  }


  Widget _bodyPage(BuildContext context, AdminOrdersViewModel model){
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        Center(
          child: this._body(context, model, OrderStatus.PENDING.status, model.getPendingOrders),
        ),
        Center(
          child: this._body(context, model, OrderStatus.ATTENDED.status, model.getAttendedOrders),
        ),
        Center(
          child: this._body(context, model, OrderStatus.SENT.status, model.getSentOrders),
        ),
        Center(
          child: this._body(context, model, OrderStatus.DELIVERED.status, model.getDeliveredOrders),
        ),
        Center(
          child: this._body(context, model, OrderStatus.CANCELLED.status, model.getCancelledOrders),
        )
      ],
    );
  }


  Widget _body(BuildContext context, AdminOrdersViewModel model, String status, List<Orders> orders) {
    return Container(
      width: 100 * SizeConfig.widthMultipier,
      padding: EdgeInsets.only(
        right: (SizeConfig.widthMultipier * 2),
        top: (SizeConfig.widthMultipier * 2),
        bottom: (SizeConfig.widthMultipier * 2),
        left: (SizeConfig.widthMultipier * 2),
      ),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: this._centerDetail(model, context, status, orders),
    );
  }

  Widget _centerDetail(AdminOrdersViewModel model, BuildContext context, String status, List<Orders> orders) {
    return Column(
      children: [
        Text(status, style: AppTheme.darkText.headline6),
        Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) =>
                Card(
                  margin: EdgeInsets.all((2 * SizeConfig.widthMultipier)),
                  elevation: 5,
                  child: Container(
                      padding: EdgeInsets.only(
                        right: (SizeConfig.widthMultipier * 2),
                        top: (SizeConfig.widthMultipier * 2),
                        bottom: (SizeConfig.widthMultipier * 2),
                        left: (SizeConfig.widthMultipier * 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: (SizeConfig.widthMultipier * 75),
                                padding: EdgeInsets.only(
                                  bottom: (SizeConfig.widthMultipier * 1),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: (SizeConfig.widthMultipier * 45),
                                      child: Text(orders[index].userName, style: AppTheme.darkText.subtitle1),
                                    ),
                                    Text(orders[index].shipping.shippingMethods.method, style: AppTheme.darkText.subtitle2),
                                    SizedBox(width: (SizeConfig.widthMultipier * 2),),
                                    if(orders[index].shipping.shippingMethods == ShippingMethods.IN_STORE)
                                      Text(orders[index].shipping.store!.schedule[0].toString(), style: AppTheme.darkText.subtitle2),
                                  ],
                                ),
                              ),
                              Container(
                                width: (SizeConfig.widthMultipier * 75),
                                padding: EdgeInsets.only(
                                  top: (SizeConfig.widthMultipier * 1),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: (SizeConfig.widthMultipier * 45),
                                      child: Row(
                                        children: [
                                          OrderStatusExtension.getIconFromOrderStatus(orders[index].status.toString()),
                                          SizedBox(width: (SizeConfig.widthMultipier * 2),),
                                          Text(orders[index].status.toString(), style: AppTheme.darkText.subtitle2),
                                        ],
                                      ),
                                    ),
                                    Text(DateFormat('dd-MM-yyyy HH:mm').format(orders[index].creationDate.toDate()), style: AppTheme.darkText.subtitle2),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios_outlined , color: AppTheme.typographyColor,),
                            onPressed: () {
                              model.navigateToAdminOrdersDetail(orders[index]);
                            },
                          ),
                        ],
                      )
                  ),
                ),
          ),
        ),
      ],
    );
  }


}