import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/models/enum/order_status.dart';
import 'package:polleria_chelis/models/enum/payment_methods.dart';
import 'package:polleria_chelis/models/orders.dart';
import 'package:polleria_chelis/views/widgets/app_bar_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';
import 'admin_orders_detail_view_model.dart';

class AdminOrdersDetailView extends StatelessWidget {
  AdminOrdersDetailView({required this.order});

  final Orders order;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminOrdersDetailViewModel>.reactive(
      viewModelBuilder: () => AdminOrdersDetailViewModel(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme.primaryColor,
          appBar: CustomAppBar(
              model.getProductNumberInCart, model.navigateToSummaryView, false),
          body: this._body(context, model),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, AdminOrdersDetailViewModel model) {
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
      child: Container(
        padding: EdgeInsets.only(
          top: (SizeConfig.widthMultipier * 2),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(Strings.labelFor + order.userName,
                  style: AppTheme.darkText.headline6),
            ),
            SizedBox(
              height: (SizeConfig.heightMultiplier * 2),
            ),
            model.isDeliveryOrder(order)
                ? this._getDeliveryDetail(model)
                : this._getInStoreDetail(),
            SizedBox(
              height: (SizeConfig.heightMultiplier * 4),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: (SizeConfig.widthMultipier * 55),
                  child: Text(Strings.labelProduct, style: AppTheme.darkText.subtitle1),
                ),
                Container(
                  width: (SizeConfig.widthMultipier * 15),
                  child: Text(Strings.labelPrice, style: AppTheme.darkText.subtitle1),
                ),
                Container(
                  width: (SizeConfig.widthMultipier * 20),
                  child: Text(Strings.labelQuantity, style: AppTheme.darkText.subtitle1),
                ),
              ],
            ),
            this._getListProducts(),
            SizedBox(
              height: (SizeConfig.heightMultiplier * 4),
            ),
            this._getPriceDetail(),
            this._bottonDetail(model),
          ],
        ),
      ),
    );
  }

  Widget _getListProducts() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: order.products.length,
      itemBuilder: (context, index) => Card(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: (SizeConfig.widthMultipier * 55),
                child: Text(order.products[index].product.name,
                    style: AppTheme.darkText.subtitle2),
              ),
              Container(
                width: (SizeConfig.widthMultipier * 15),
                child: Text(order.products[index].product.price.toString(),
                    style: AppTheme.darkText.subtitle2),
              ),
              Container(
                width: (SizeConfig.widthMultipier * 20),
                child: Text(order.products[index].quantity.toString(),
                    style: AppTheme.darkText.subtitle2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getInStoreDetail() {
    return Container(
      child: Column(
        children: [
          Align(
            child:
                Text(Strings.labelDeliveryData, style: AppTheme.darkText.subtitle1),
            alignment: Alignment.centerLeft,
          ),
          Align(
            child: Text(order.shipping.store!.address,
                style: AppTheme.darkText.subtitle2),
            alignment: Alignment.centerLeft,
          ),
          SizedBox(
            height: (SizeConfig.heightMultiplier * 2),
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: (SizeConfig.widthMultipier * 2),
                  ),
                  Text(Strings.labelStore, style: AppTheme.darkText.subtitle1),
                  Text(order.shipping.store!.name,
                      style: AppTheme.darkText.subtitle2),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: (SizeConfig.widthMultipier * 2),
                  ),
                  Text(Strings.labelSchedule, style: AppTheme.darkText.subtitle1),
                  Text(order.shipping.store!.schedule[0],
                      style: AppTheme.darkText.subtitle2),
                ],
              ),
            ],
          ),
          SizedBox(
            height: (SizeConfig.heightMultiplier * 2),
          ),
          Row(
            children: [
              Text(Strings.labelOrder, style: AppTheme.darkText.subtitle1),
              Text(order.id!, style: AppTheme.darkText.subtitle2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getDeliveryDetail(AdminOrdersDetailViewModel model) {
    return Container(
      child: Column(
        children: [
          Align(
            child:
                Text(Strings.labelDeliveryData, style: AppTheme.darkText.subtitle1),
            alignment: Alignment.centerLeft,
          ),
          Align(
            child: FutureBuilder<String>(
              future: model.getAddress(order.shipping.address!.latitude,
                  order.shipping.address!.longitude),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!,
                      style: AppTheme.darkText.subtitle2);
                } else {
                  return Text(Strings.labelAddresUnknow,
                      style: AppTheme.darkText.subtitle2);
                }
              },
            ),
            alignment: Alignment.centerLeft,
          ),
          SizedBox(
            height: (SizeConfig.heightMultiplier * 2),
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: (SizeConfig.widthMultipier * 2),
                  ),
                  Text(Strings.labelPay, style: AppTheme.darkText.subtitle1),
                  Text(order.shipping.paymentMethod!,
                      style: AppTheme.darkText.subtitle2),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: (SizeConfig.widthMultipier * 2),
                  ),
                  Text(Strings.labelLocation, style: AppTheme.darkText.subtitle1),
                  Text(Strings.labelOpenMap,
                      style: AppTheme.darkText.subtitle2),
                  IconButton(
                    icon: const Icon(Icons.map_outlined , color: AppTheme.typographyColor,),
                    onPressed: () {
                      model.openMap(order.shipping.address!.latitude, order.shipping.address!.longitude);
                    },
                  ),
                ],
              ),
              if (order.shipping.paymentMethod! == PaymentMethods.CASH.method)
                Row(
                  children: [
                    SizedBox(
                      width: (SizeConfig.widthMultipier * 2),
                    ),
                    Text(Strings.labelPayWith, style: AppTheme.darkText.subtitle1),
                    Text(
                        NumberFormat.simpleCurrency()
                            .format(order.shipping.cashDenomination!),
                        style: AppTheme.darkText.subtitle2),
                  ],
                ),
            ],
          ),
          SizedBox(
            height: (SizeConfig.heightMultiplier * 4),
          ),
          Row(
            children: [
              Text(Strings.labelOrder, style: AppTheme.darkText.subtitle1),
              Text(order.id!, style: AppTheme.darkText.subtitle2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getPriceDetail() {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.SubTotal, style: AppTheme.darkText.subtitle2),
                Text(NumberFormat.simpleCurrency().format(order.subtotal),
                    style: AppTheme.darkText.subtitle2),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.Shipping, style: AppTheme.darkText.subtitle2),
                Text(NumberFormat.simpleCurrency().format(order.shippingPrice),
                    style: AppTheme.darkText.subtitle2),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.Total, style: AppTheme.darkText.subtitle1),
                Text(NumberFormat.simpleCurrency().format(order.total),
                    style: AppTheme.darkText.subtitle1),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottonDetail(AdminOrdersDetailViewModel model) {
    if (order.status == OrderStatus.PENDING.status) {
      return this.getButtonsOfPendingStatus(model);
    } else if (order.status == OrderStatus.ATTENDED.status) {
      return this.getButtonsOfAttendedStatus(model);
    } else if (order.status == OrderStatus.SENT.status) {
      return this.getButtonsOfSentStatus(model);
    } else if (order.status == OrderStatus.DELIVERED.status) {
      return this.getButtonsOfDeliveredStatus(model);
    } else if (order.status == OrderStatus.CANCELLED.status) {
      return this.getButtonsOfCancelledStatus(model);
    } else {
      return this.getButtonsOfPendingStatus(model);
    }
  }

  Widget getButtonsOfPendingStatus(AdminOrdersDetailViewModel model) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: (SizeConfig.heightMultiplier * 2),
          ),
          width: double.infinity,
          child: model.isDeliveryOrder(order)
              ? TextButton(
                  child: Text(Strings.sentLabelButton,
                      style: AppTheme.lightText.subtitle2),
                  style: TextButton.styleFrom(
                    backgroundColor: OrderStatusExtension.getOrderStatusColor(
                        OrderStatus.SENT),
                  ),
                  onPressed: () => model.updateOrderStatus(
                      order.id!, OrderStatus.SENT.status),
                )
              : TextButton(
                  child: Text(Strings.attendedLabelButton,
                      style: AppTheme.lightText.subtitle2),
                  style: TextButton.styleFrom(
                    backgroundColor: OrderStatusExtension.getOrderStatusColor(
                        OrderStatus.ATTENDED),
                  ),
                  onPressed: () => model.updateOrderStatus(
                      order.id!, OrderStatus.ATTENDED.status),
                ),
        ),
        if (model.isCancellableOrder(order))
          Container(
            width: double.infinity,
            child: TextButton(
              child: Text(Strings.cancelledLabelButton,
                  style: AppTheme.lightText.subtitle2),
              style: TextButton.styleFrom(
                backgroundColor: OrderStatusExtension.getOrderStatusColor(
                    OrderStatus.CANCELLED),
              ),
              onPressed: () => model.showConfirmCancelledOrderDialog(
                  order.id!, OrderStatus.CANCELLED.status),
            ),
          ),
      ],
    );
  }

  Widget getButtonsOfAttendedStatus(AdminOrdersDetailViewModel model) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: (SizeConfig.heightMultiplier * 2),
          ),
          width: double.infinity,
          child: TextButton(
            child: Text(Strings.deliveredLabelButton,
                style: AppTheme.lightText.subtitle2),
            style: TextButton.styleFrom(
              backgroundColor: OrderStatusExtension.getOrderStatusColor(
                  OrderStatus.DELIVERED),
            ),
            onPressed: () => model.updateOrderStatus(
                order.id!, OrderStatus.DELIVERED.status),
          ),
        ),
        if (model.isCancellableOrder(order))
          Container(
            width: double.infinity,
            child: TextButton(
              child: Text(Strings.cancelledLabelButton,
                  style: AppTheme.lightText.subtitle2),
              style: TextButton.styleFrom(
                backgroundColor: OrderStatusExtension.getOrderStatusColor(
                    OrderStatus.CANCELLED),
              ),
              onPressed: () => model.showConfirmCancelledOrderDialog(
                  order.id!, OrderStatus.CANCELLED.status),
            ),
          ),
      ],
    );
  }

  Widget getButtonsOfSentStatus(AdminOrdersDetailViewModel model) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: (SizeConfig.heightMultiplier * 2),
          ),
          width: double.infinity,
          child: TextButton(
            child: Text(Strings.deliveredLabelButton,
                style: AppTheme.lightText.subtitle2),
            style: TextButton.styleFrom(
              backgroundColor: OrderStatusExtension.getOrderStatusColor(
                  OrderStatus.DELIVERED),
            ),
            onPressed: () => model.updateOrderStatus(
                order.id!, OrderStatus.DELIVERED.status),
          ),
        ),
      ],
    );
  }

  Widget getButtonsOfDeliveredStatus(AdminOrdersDetailViewModel model) {
    return Column(
      children: [
      ],
    );
  }

  Widget getButtonsOfCancelledStatus(AdminOrdersDetailViewModel model) {
    return Column(
      children: [
      ],
    );
  }
}
