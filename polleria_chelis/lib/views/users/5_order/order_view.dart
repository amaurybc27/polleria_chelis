
import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/models/configuration_parameters.dart';
import 'package:polleria_chelis/views/widgets/app_bar_widget.dart';
import 'package:polleria_chelis/views/widgets/loader_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

import 'order_view_model.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderViewModel>.reactive(
      viewModelBuilder: () => OrderViewModel(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme.primaryColor,
          appBar: CustomAppBar(
              model.getProductNumberInCart, model.navigateToSummaryView, true),
          body: this._body(context, model),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, OrderViewModel model) {
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
            right: (SizeConfig.widthMultipier * 2),
            top: (SizeConfig.widthMultipier * 4),
            bottom: (SizeConfig.widthMultipier * 2),
            left: (SizeConfig.widthMultipier * 2),
          ),
          child: Column(
            children: [
              this._topDetail(),
              this._centerDetail(model),
              this._bottonDetail(model),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topDetail() {
    return Column(
      children: [
        Align(
          child: Text(
            Strings.summaryTitle,
            style: AppTheme.darkText.headline6,
          ),
          alignment: Alignment.centerLeft,
        ),
        Divider(
          color: AppTheme.primaryColor,
        ),
        Align(
          child: Text(
            Strings.summarySubtitle,
            style: AppTheme.darkText.subtitle2,
          ),
          alignment: Alignment.centerLeft,
        ),
        SizedBox(
          height: (SizeConfig.heightMultiplier * 2),
        ),
      ],
    );
  }

  Widget _centerDetail(OrderViewModel model) {
    return Expanded(
      child: model.summaryDataService.counter > 0
          ? SingleChildScrollView(
        child: Column(
          children: [
            for (var key in model.summaryDataService.summaryItems.keys)
              this._productCard(key, model),
            SizedBox(height: (SizeConfig.heightMultiplier * 4)),
            this._priceDetail(model),
          ],
        ),
      )
          : Align(
        alignment: Alignment.center,
        child: Text(
          Strings.summaryEmptyShoppingCart,
          style: AppTheme.errorText.headline6,
        ),
      ),
    );
  }

  Widget _productCard(String key, OrderViewModel model) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(
        (2 * SizeConfig.widthMultipier),
      ),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
          right: (SizeConfig.widthMultipier * 4),
          top: (SizeConfig.widthMultipier * 2),
          left: (SizeConfig.widthMultipier * 4),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                  future: model.getImage(
                      model.summaryDataService.summaryItems[key].product.photo),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        child: Hero(
                          tag: 'image_${key}',
                          child: snapshot.data,
                        ),
                        width: (22 * SizeConfig.widthMultipier),
                      );
                    } else {
                      return new LoaderView();
                    }
                  },
                ),
                Column(
                  children: [
                    Text(
                        model.summaryDataService.summaryItems[key].product.name,
                        style: AppTheme.darkText.subtitle1),
                    SizedBox(height: (SizeConfig.heightMultiplier * 2)),
                    Text(
                        NumberFormat.simpleCurrency().format(model
                            .summaryDataService
                            .summaryItems[key]
                            .product
                            .price),
                        style: AppTheme.darkText.subtitle1),
                    Row(
                      children: [
                        model.summaryDataService.summaryItems[key].quantity <= 0
                            ? IconButton(
                          onPressed: null,
                          icon: Icon(Icons.remove,
                              color: AppTheme.disabledButtonColor),
                        )
                            : IconButton(
                            onPressed: () => model.minusProduct(model
                                .summaryDataService
                                .summaryItems[key]
                                .product),
                            icon: Icon(Icons.remove)),
                        Text(
                            model.summaryDataService.summaryItems[key].quantity
                                .toString(),
                            style: AppTheme.darkText.subtitle1),
                        model.summaryDataService.summaryItems[key].quantity <= 0
                            ? IconButton(
                          onPressed: null,
                          icon: Icon(Icons.add,
                              color: AppTheme.disabledButtonColor),
                        )
                            : IconButton(
                            onPressed: () => model.addProduct(model
                                .summaryDataService
                                .summaryItems[key]
                                .product),
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () => model.removeItem(model
                          .summaryDataService.summaryItems[key].product.name),
                      icon: Icon(Icons.delete_forever_outlined,
                          color: AppTheme.errorColor),
                    ),
                    SizedBox(
                      height: (SizeConfig.heightMultiplier * 2),
                    ),
                    Text(
                        NumberFormat.simpleCurrency().format(model
                            .summaryDataService
                            .summaryItems[key]
                            .product
                            .price *
                            model
                                .summaryDataService.summaryItems[key].quantity),
                        style: AppTheme.darkText.subtitle2),
                    SizedBox(
                      height: (SizeConfig.heightMultiplier * 2),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceDetail(OrderViewModel model) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  model.getProductNumberInCart().toString() +
                      " " +
                      Strings.summaryItemDescription,
                  style: AppTheme.darkText.subtitle1),
            ],
          ),
          Divider(
            color: AppTheme.backgroundColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.SubTotal, style: AppTheme.darkText.subtitle2),
              Text(NumberFormat.simpleCurrency().format(model.summaryDataService.getSubtotal()),
                  style: AppTheme.darkText.subtitle2),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.Shipping, style: AppTheme.darkText.subtitle2),
              Text(
                  NumberFormat.simpleCurrency().format(
                    double.parse(
                      ConfigurationParameters.getParameter(
                          ConfigurationParameters.sendingPrice),
                    ),
                  ),
                  style: AppTheme.darkText.subtitle2),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.Total, style: AppTheme.darkText.subtitle1),
              Text(
                  NumberFormat.simpleCurrency().format(
                      model.summaryDataService.getTotal()
                  ),
                  style: AppTheme.darkText.subtitle1),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottonDetail(OrderViewModel model) {
    return Container(
      width: double.infinity,
      child: model.summaryDataService.counter > 0
          ? TextButton(
        child: Text(Strings.SmsPhoneCodeButton,
            style: AppTheme.darkText.subtitle2),
        style: TextButton.styleFrom(
          backgroundColor: AppTheme.secondaryColor,
        ),
        onPressed: () => model.navigateToShippingView(),
      )
          : TextButton(
        child: Text(Strings.SmsPhoneCodeButton,
            style: AppTheme.darkText.subtitle2),
        style: TextButton.styleFrom(
          backgroundColor: AppTheme.disabledButtonColor,
        ),
        onPressed: null,
      ),
    );
  }
}
