
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:observable_ish/value/value.dart';
import 'package:polleria_chelis/models/configuration_parameters.dart';
import 'package:polleria_chelis/models/enum/shipping_methods.dart';
import 'package:polleria_chelis/models/order_item.dart';
import 'package:stacked/stacked.dart';

class DeliveryDataService with ReactiveServiceMixin {

  DeliveryDataService() {
    listenToReactiveValues([_counter]);
  }

  //NUMERO DE PRODUCTOS EN EL CARRITO DE COMPRAS
  RxValue<int> _counter = RxValue<int>(0);
  int get counter => _counter.value;
  void incrementCounter() {
    _counter.value++;
  }
  void decreaseCounter() {
    if(this._counter.value > 0)
      _counter.value--;
  }


  //DETALLE DE PRODUCTOS AGREGADOS EN EL CARRITO DE COMPRAS Y LA CANTIDAD DE LOS MISMOS
  var _summaryItems = new Map<String, OrderItem>();
  Map get summaryItems => _summaryItems;

  //SI SELECCIONA ENVIO A DOMICILIO SE GUARDA LA LATLNG
  LatLng _location = new LatLng(0, 0);
  get getLocation => this._location;
  void setLocation(LatLng newLocation) => this._location = newLocation;

  // METODO DE ENVIO ELEGIDO
  ShippingMethods _shippingSelected = ShippingMethods.DELIVERY;
  get getShippingSelected => _shippingSelected;
  void setShippingSelected(ShippingMethods selected) {
    this._shippingSelected = selected;
  }


  // PRECIOS SUBTOTAL Y TOTAL
  double getSubtotal(){
    double subtotal = 0;
    for (OrderItem summaryItem in this._summaryItems.values){
      subtotal = subtotal + (summaryItem.product.price * summaryItem.quantity);
    }
    return subtotal;
  }
  double getTotal(){
    return this.getSubtotal() + double.parse(ConfigurationParameters.getParameter(ConfigurationParameters.sendingPrice),);
  }

  // OBTENER PRODUCTOS SELECCIONADOS
  List<OrderItem> getProducts(){
    return this._summaryItems.values.toList();
  }

  void clearData(){
    this._summaryItems = new Map<String, OrderItem>();
    this._counter = RxValue<int>(0);
    this._location = new LatLng(0, 0);
  }
}