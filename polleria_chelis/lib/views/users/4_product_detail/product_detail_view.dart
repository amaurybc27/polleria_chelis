
import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/models/products.dart';
import 'package:polleria_chelis/views/users/4_product_detail/product_detail_view_model.dart';
import 'package:polleria_chelis/views/widgets/app_bar_widget.dart';
import 'package:intl/intl.dart';
import 'package:polleria_chelis/views/widgets/loader_widget.dart';
import 'package:stacked/stacked.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({required this.product});

  final Products product;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      viewModelBuilder: () => ProductDetailViewModel(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme.primaryColor,
          appBar: CustomAppBar(model.getProductNumberInCart, model.navigateToSummaryView, true),
          body: this._body(context, model, product),
        ),
      ),
    );
  }

  Widget _body(
      BuildContext context, ProductDetailViewModel model, Products product) {
    return Container(
      width: 100 * SizeConfig.widthMultipier,
      padding: EdgeInsets.only(
        right: (SizeConfig.widthMultipier * 10),
        left: (SizeConfig.widthMultipier * 10),
        top: (SizeConfig.heightMultiplier * 2),
        bottom: (SizeConfig.heightMultiplier * 2),
      ),
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
        child: Column(
          children: [
            FutureBuilder(
              future: model.getImage(product.photo),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    child: Hero(
                      tag: 'image_${product.name}',
                      child: snapshot.data,
                    ),
                    width: (70 * SizeConfig.widthMultipier),
                  );
                } else {
                  return new LoaderView();
                }
              },
            ),
            Container(
              width: 100 * SizeConfig.widthMultipier,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.name,
                  style: AppTheme.darkText.headline5,
                ),
              ),
            ),
            SizedBox(height: (SizeConfig.heightMultiplier * 1)),
            Container(
              width: 100 * SizeConfig.widthMultipier,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  NumberFormat.simpleCurrency().format(product.price),
                  style: AppTheme.darkText.headline6,
                ),
              ),
            ),
            SizedBox(height: (SizeConfig.heightMultiplier * 4)),
            Container(
              width: 100 * SizeConfig.widthMultipier,
              height: 26 * SizeConfig.heightMultiplier,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.detail == null ? Strings.WithoutDescription : product.detail.replaceAll("\\n", "\n"),
                    textAlign: TextAlign.justify,
                    style: AppTheme.darkText.bodyText1,
                  ),
                ),
              ),
            ),
            SizedBox(height: (SizeConfig.heightMultiplier * 2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      model.existInSummaryItems(product) ? IconButton(onPressed: null, icon: Icon(Icons.remove, color: AppTheme.disabledButtonColor),) : IconButton(onPressed: () => model.minusProductCounter(product), icon: Icon(Icons.remove)),
                      model.existInSummaryItems(product) ? Text(model.getSummaryItemsQuantity(product).toString(), style: AppTheme.darkText.subtitle1) : Text(model.productCounter.toString(), style: AppTheme.darkText.subtitle1),
                      model.existInSummaryItems(product) ? IconButton(onPressed: null, icon: Icon(Icons.add, color: AppTheme.disabledButtonColor),) : IconButton(onPressed: () => model.plusProductCounter(product), icon: Icon(Icons.add)),
                    ],
                  ),
                ),
                Container(
                  child: model.existInSummaryItems(product) ?  TextButton(
                    child: Text(Strings.DeleteButton,
                        style: AppTheme.darkText.subtitle2),
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.secondaryColor,
                    ),
                    onPressed: () => model.removeProduct(product),
                  ) : (model.productCounter > 0) ? TextButton(
                    child: Text(Strings.AddButton,
                        style: AppTheme.darkText.subtitle2),
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.secondaryColor,
                    ),
                    onPressed: () => model.addProduct(product),
                  ) : TextButton(
                    child: Text(Strings.AddButton,
                        style: AppTheme.darkText.subtitle2),
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.disabledButtonColor,
                    ),
                    onPressed: null,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


}
