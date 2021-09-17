
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';
import 'package:polleria_chelis/models/products.dart';
import 'package:polleria_chelis/views/widgets/app_bar_widget.dart';
import 'package:polleria_chelis/views/widgets/loader_widget.dart';
import 'package:stacked/stacked.dart';

import 'admin_products_view_model.dart';

class AdminProductsView extends StatelessWidget {
  const AdminProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminProductsViewModel>.reactive(
      viewModelBuilder: () => AdminProductsViewModel(),
      onModelReady: (model) => {model.getProductsForAdmin()},
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme.primaryColor,
          appBar: CustomAppBar(model.getProductNumberInCart, model.navigateToSummaryView, false),
          body: this._body(model),
        ),
      ),
    );
  }

  Widget _body(AdminProductsViewModel model) {
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
      child: this._centerDetail(model),
    );
  }

  Widget _centerDetail(AdminProductsViewModel model){
    return ListView.builder(
      itemCount: model.getListProducts.length,
      itemBuilder: (context, index) {
        final Products item = model.getListProducts[index];
        TextEditingController _editingController = TextEditingController(text: item.price.toString());

        return Card(
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
                FutureBuilder(
                  future: model.getImage(item.photo),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        padding: EdgeInsets.only(
                          right: (SizeConfig.widthMultipier * 2),
                        ),
                        child: snapshot.data,
                        width: (15 * SizeConfig.widthMultipier),
                      );
                    } else {
                      return new LoaderView();
                    }
                  },
                ),
                Container(
                  child: Text(item.name, style: AppTheme.darkText.subtitle2),
                  width: (SizeConfig.widthMultipier * 35),
                ),
                Container(
                  width: (SizeConfig.widthMultipier * 11),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: AppTheme.darkText.subtitle2,
                    controller: _editingController,
                    cursorColor: AppTheme.primaryColor,
                    onSubmitted: (value){
                      model.chnageProductPriceValue(item, value);
                    },
                  ),
                ),
                Switch(
                  value: item.status,
                  onChanged: (value) {
                    model.changeProductStatusValue(item, value);
                  },
                  activeTrackColor: AppTheme.secondaryColor,
                  activeColor: AppTheme.secondaryVariantColor,
                  inactiveTrackColor: AppTheme.primaryColor,
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined , color: AppTheme.typographyColor,),
                  onPressed: () {
                    model.updateProduct(item.id!, item);
                  },
                ),
              ],
            ),
          ),

        );
      },
    );
  }


}