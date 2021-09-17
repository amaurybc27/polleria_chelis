
import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/views/users/3_products/products_view_model.dart';

class MenuWidget{

  static Widget getMenu(BuildContext context, ProductsViewModel model, bool isUserAdmin) {
    return Drawer(
      child: Container(
        color: AppTheme.primaryColor,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(Strings.profileMenu, style: AppTheme.lightText.headline6,),
              leading: Icon(Icons.person_outline, color: AppTheme.typographySecondaryColor,),
              onTap: () {
                model.navigateToProfileView();
              },
            ),
            if(!isUserAdmin)
            ListTile(
              title: Text(Strings.ordersMenu, style: AppTheme.lightText.headline6,),
              leading: Icon(Icons.format_list_numbered_outlined, color: AppTheme.typographySecondaryColor,),
              onTap: () {
                model.navigateToOrdersView();
              },
            ),
            if(isUserAdmin)
              ListTile(
                title: Text(Strings.adminOrdesMenu, style: AppTheme.lightText.headline6,),
                leading: Icon(Icons.list_outlined , color: AppTheme.typographySecondaryColor,),
                onTap: () {
                  model.navigateToAdminOrders();
                },
              ),
            if(isUserAdmin)
              ListTile(
                title: Text(Strings.adminProductsMenu, style: AppTheme.lightText.headline6,),
                leading: Icon(Icons.format_list_numbered_outlined , color: AppTheme.typographySecondaryColor,),
                onTap: () {
                  model.navigateToAdminProducts();
                },
              ),
            Divider(color: AppTheme.typographySecondaryColor,),
            ListTile(
              title: Text(Strings.exitMenu, style: AppTheme.lightText.headline6,),
              leading: Icon(Icons.exit_to_app, color: AppTheme.typographySecondaryColor,),
              onTap: () {
                model.singout();
              },
            ),
          ],
        ),
      ),
    );
  }
}