
import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/models/enum/order_status.dart';
import 'package:polleria_chelis/models/enum/shipping_methods.dart';
import 'package:intl/intl.dart';
import 'package:polleria_chelis/views/widgets/app_bar_widget.dart';
import 'package:stacked/stacked.dart';

import 'user_orders_view_model.dart';

class UserOrdersView extends StatelessWidget{
  const UserOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserOrdersViewModel>.reactive(
      viewModelBuilder: () => UserOrdersViewModel(),
      onModelReady: (model) => {model.fetchOrders()},
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme.primaryColor,
          appBar: CustomAppBar(model.getProductNumberInCart, model.navigateToSummaryView, false),
          body: this._body(context, model),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, UserOrdersViewModel model) {
    return Container(
      width: 100 * SizeConfig.widthMultipier,
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.only(
            right: (SizeConfig.widthMultipier * 4),
            top: (SizeConfig.widthMultipier * 4),
            bottom: (SizeConfig.widthMultipier * 2),
            left: (SizeConfig.widthMultipier * 4),
          ),
          child: Column(
            children: [
              this._centerDetail(model, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _centerDetail(UserOrdersViewModel model, BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: model.getOrders.length,
        itemBuilder: (context, index) =>
            Card(
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all((2 * SizeConfig.widthMultipier)),
              elevation: 5,
              child: Container(
                padding: EdgeInsets.only(
                  right: (SizeConfig.widthMultipier * 2),
                  top: (SizeConfig.widthMultipier * 2),
                  bottom: (SizeConfig.widthMultipier * 2),
                  left: (SizeConfig.widthMultipier * 2),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              OrderStatusExtension.getIconFromOrderStatus(model.getOrders[index].status.toString()),
                              SizedBox(width: (SizeConfig.widthMultipier * 2),),
                              Text(model.getOrders[index].status.toString(), style: AppTheme.darkText.subtitle2),
                            ],
                          ),
                        ),
                        Text(DateFormat('dd-MM-yyyy HH:mm').format(model.getOrders[index].creationDate.toDate()), style: AppTheme.darkText.subtitle2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        model.getOrders[index].shipping.shippingMethods == ShippingMethods.IN_STORE ? Icon(Icons.storefront) : Icon(Icons.delivery_dining_outlined),
                        SizedBox(width: (SizeConfig.widthMultipier * 2),),
                        Text(model.getOrders[index].shipping.shippingMethods.method, style: AppTheme.darkText.subtitle1),
                      ],
                    ),
                    Text(model.getOrders[index].shipping.paymentMethod.toString() == "null" ? "" : model.getOrders[index].shipping.paymentMethod.toString(), style: AppTheme.darkText.subtitle2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(Strings.Total, style: AppTheme.darkText.subtitle1),
                        SizedBox(width: (SizeConfig.widthMultipier * 2),),
                        Text(NumberFormat.simpleCurrency().format(model.getOrders[index].total), style: AppTheme.darkText.subtitle2)
                      ],
                    ),
                  ],
                ),
              ),

            ),
      ),
    );
  }


}