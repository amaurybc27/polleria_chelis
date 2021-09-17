
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/models/enum/shipping_methods.dart';
import 'package:polleria_chelis/models/stores.dart';
import 'package:polleria_chelis/views/users/6_order_shipping/shipping_order_view_model.dart';
import 'package:polleria_chelis/views/widgets/app_bar_widget.dart';
import 'package:stacked/stacked.dart';

class ShippingOrderView extends StatelessWidget {
  const ShippingOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShippingOrderViewModel>.reactive(
      viewModelBuilder: () => ShippingOrderViewModel(),
      onModelReady: (model) => model.fetchStores(),
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

  Widget _body(BuildContext context, ShippingOrderViewModel model) {
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
              this._centerDetail(model, context),
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
            Strings.shippingTitle,
            style: AppTheme.darkText.headline6,
          ),
          alignment: Alignment.centerLeft,
        ),
        Divider(
          color: AppTheme.primaryColor,
        ),
        SizedBox(
          height: (SizeConfig.heightMultiplier * 1),
        ),
      ],
    );
  }

  Widget _centerDetail(ShippingOrderViewModel model, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              this._cardShipping(ShippingMethods.DELIVERY, model),
              this._cardShipping(ShippingMethods.IN_STORE, model),
            ],
          ),
          SizedBox(
            height: (SizeConfig.heightMultiplier * 2),
          ),
          model.getShippingSelected == ShippingMethods.DELIVERY
              ? this._mapContainer(model)
              : this._storeContainer(context, model),
        ],
      ),
    );
  }

  Widget _cardShipping(ShippingMethods shippingMethods, ShippingOrderViewModel model) {
    return GestureDetector(
      onTap: () => model.setShippingSelected(shippingMethods),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all((2 * SizeConfig.widthMultipier)),
        elevation: model.getShippingSelected == shippingMethods ? 5 : 1,
        child: Container(
          width: SizeConfig.widthMultipier * 35,
          height: SizeConfig.heightMultiplier * 10,
          padding: EdgeInsets.all(
            SizeConfig.widthMultipier * 4,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                shippingMethods == ShippingMethods.IN_STORE
                    ? Icon(Icons.storefront)
                    : Icon(Icons.delivery_dining_outlined),
                SizedBox(
                  height: (SizeConfig.heightMultiplier * 1),
                ),
                Text(
                  shippingMethods == ShippingMethods.IN_STORE
                      ? Strings.shippingInStore
                      : Strings.shippingHomeDelivery,
                  style: AppTheme.darkText.subtitle2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mapContainer(ShippingOrderViewModel model) {
    return Expanded(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                Strings.deliveryLocationTitle,
                style: AppTheme.darkText.bodyText1,
              ),
              SizedBox(
                height: (SizeConfig.heightMultiplier * 2),
              ),
              Container(
                width: SizeConfig.widthMultipier * 80,
                height: SizeConfig.heightMultiplier * 40,
                child: GoogleMap(
                  onMapCreated: model.onMapCreated,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  onLongPress: (latlang) {
                    model.addMarkerLongPressed(
                        latlang);
                  },
                  markers: Set<Marker>.of(model.getMarkers.values),
                  initialCameraPosition: CameraPosition(
                    target: model.getCenterLocation,
                    zoom: 11.0,
                  ),
                ),
              ),
              SizedBox(
                height: (SizeConfig.heightMultiplier * 2),
              ),
              Form(
                child: TextFormField(
                  enabled: false,
                  cursorColor: AppTheme.primaryColor,
                  controller: model.getAddressTextController,
                  decoration: const InputDecoration(
                    labelText: Strings.addressInputText,
                    labelStyle: TextStyle(color: AppTheme.primaryColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _storeContainer(BuildContext context, ShippingOrderViewModel model) {
    return Expanded(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                child: Text(
                  Strings.storeSubTitle,
                  style: AppTheme.darkText.bodyText1,
                ),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(
                height: (SizeConfig.heightMultiplier * 2),
              ),
              Container(
                color: AppTheme.primaryOpacitiColor,
                child: Column(
                  children: model.getStoresList.map((Stores e) {
                    return ListTile(
                      title: Text(
                        e.name,
                        style: AppTheme.darkText.bodyText2,
                      ),
                      subtitle: Text(e.address),
                      leading: Radio(
                        value: e.id,
                        groupValue: model.getIdStore,
                        activeColor: AppTheme.secondaryColor,
                        onChanged: (Object? value) {
                          model.setIdStore(value.toString());
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: (SizeConfig.heightMultiplier * 2),
              ),
              Align(
                child: Text(
                  Strings.scheduleSubTitle,
                  style: AppTheme.darkText.bodyText1,
                ),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(
                height: (SizeConfig.heightMultiplier * 2),
              ),
              if (model.getStoreSchedule.length > 0)
                Container(
                  child: Column(
                    children: model.getStoreSchedule.map((e) {
                      return ListTile(
                        title: Text(
                          e.toString(),
                          style: AppTheme.darkText.bodyText2,
                        ),
                        leading: Radio(
                          value: e.toString(),
                          groupValue: model.getScheduleSelected,
                          activeColor: AppTheme.secondaryColor,
                          onChanged: (Object? value) {
                            model.setScheduleSelected(value.toString());
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottonDetail(ShippingOrderViewModel model) {
    return Container(
      padding: EdgeInsets.only(
        top: (SizeConfig.heightMultiplier * 2),
      ),
      width: double.infinity,
      child: model.isEnableButton()
          ? TextButton(
        child: Text(model.getShippingSelected == ShippingMethods.IN_STORE ? Strings.finishLableButton : Strings.SmsPhoneCodeButton,
            style: AppTheme.darkText.subtitle2),
        style: TextButton.styleFrom(
          backgroundColor: AppTheme.secondaryColor,
        ),
        onPressed: () => model.getShippingSelected == ShippingMethods.IN_STORE ? model.showConfirmDialog() : model.navigateToPaymentMethodView(),
      )
          : TextButton(
        child: Text(model.getShippingSelected == ShippingMethods.IN_STORE ? Strings.finishLableButton : Strings.SmsPhoneCodeButton,
            style: AppTheme.darkText.subtitle2),
        style: TextButton.styleFrom(
          backgroundColor: AppTheme.disabledButtonColor,
        ),
        onPressed: null,
      ),
    );
  }
}
