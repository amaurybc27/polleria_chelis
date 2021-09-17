
import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';
import 'package:polleria_chelis/views/users/3_products/products_view_model.dart';
import 'package:polleria_chelis/views/users/4_product_detail/product_detail_view.dart';
import 'package:polleria_chelis/views/widgets/app_bar_widget.dart';
import 'package:polleria_chelis/views/widgets/loader_widget.dart';
import 'package:polleria_chelis/views/widgets/menu_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsViewModel>.reactive(
      viewModelBuilder: () => ProductsViewModel(),
      onModelReady: (model) => {model.fetchCategories(), model.fetchProducts()},
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme.primaryColor,
          drawer: MenuWidget.getMenu(context, model, model.getAuthenticationDataService.isAdmin),
          appBar: CustomAppBar(model.getProductNumberInCart, model.navigateToSummaryView, true),
          body: _body(context, model),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, ProductsViewModel model) {
    return Container(
      width: 100 * SizeConfig.widthMultipier,
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: model.categories != null
          ? ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: ListView.builder(
          itemCount: model.categories.length,
          itemBuilder: (context, indexCategori) => Container(
            padding: EdgeInsets.only(
              right: (SizeConfig.widthMultipier * 2),
              top: (SizeConfig.widthMultipier * 4),
              bottom: (SizeConfig.widthMultipier * 2),
              left: (SizeConfig.widthMultipier * 2),
            ),
            child: Column(
              children: <Widget>[
                //Categori tittle
                Container(
                  padding:
                  EdgeInsets.all((2 * SizeConfig.widthMultipier)),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    model.categories[indexCategori].name,
                    style: AppTheme.darkText.subtitle1,
                  ),
                ),
                //Products
                model.mapProducts[model.categories[indexCategori].name] !=
                    null
                    ? Container(
                  height: (30 * SizeConfig.heightMultiplier),
                  width: (100 * SizeConfig.widthMultipier),
                  child: this._productList(model, indexCategori),
                )
                    : Text(
                  "Productos no disponibles",
                  style: AppTheme.errorText.bodyText2,
                ),
              ],
            ),
          ),
        ),
      )
          : Text(
        "Categorias no disponibles",
        style: AppTheme.errorText.bodyText2,
      ),
    );
  }

  Widget _productList(ProductsViewModel model, int indexCategori) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: model.mapProducts[model.categories[indexCategori].name].length,
      itemBuilder: (BuildContext context, int indexProduct) => GestureDetector(
        onTap: () {
          /*model.navigateToProductDetail(model
              .mapProducts[model.categories[indexCategori].name][indexProduct]);*/
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, __) {
                return FadeTransition(
                  opacity: animation,
                  child: ProductDetailView(
                    product:
                    model.mapProducts[model.categories[indexCategori].name]
                    [indexProduct],
                  ),
                );
              },
            ),
          );
        },
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all((2 * SizeConfig.widthMultipier)),
          elevation: 5,
          child: Container(
            width: (44 * SizeConfig.widthMultipier),
            padding: EdgeInsets.all((2 * SizeConfig.widthMultipier)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder(
                  future: model.getImage(model
                      .mapProducts[model.categories[indexCategori].name]
                  [indexProduct]
                      .photo),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        child: Hero(
                          tag:
                          'image_${model.mapProducts[model.categories[indexCategori].name][indexProduct].name}',
                          child: snapshot.data,
                        ),
                        width: (35 * SizeConfig.widthMultipier),
                      );
                    } else {
                      return new LoaderView();
                    }
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    model
                        .mapProducts[model.categories[indexCategori].name]
                    [indexProduct]
                        .name,
                    style: AppTheme.darkText.headline6,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    NumberFormat.simpleCurrency().format(model
                        .mapProducts[model.categories[indexCategori].name]
                    [indexProduct]
                        .price),
                    style: AppTheme.darkText.bodyText2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
