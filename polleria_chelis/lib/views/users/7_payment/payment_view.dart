
import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/models/enum/payment_methods.dart';
import 'package:polleria_chelis/views/users/7_payment/payment_view_model.dart';
import 'package:polleria_chelis/views/widgets/app_bar_widget.dart';
import 'package:stacked/stacked.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentViewModel>.reactive(
      viewModelBuilder: () => PaymentViewModel(),
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

  Widget _body(BuildContext context, PaymentViewModel model) {
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
              this._bottonDetail(model)
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
            Strings.paymentMethodTitle,
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

  Widget _centerDetail(PaymentViewModel model, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: (SizeConfig.heightMultiplier * 4),
          ),
          Column(
            children: <Widget>[
              RadioListTile<PaymentMethods>(
                title: Text(Strings.paymentMethodCash,
                    style: AppTheme.darkText.bodyText1),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Strings.paymentMethodCashQuestion,
                        style: AppTheme.darkText.bodyText2),
                    DropdownButton<String>(
                      value: model.getDenominationSelected,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: model.getCharacter != PaymentMethods.TPV ? AppTheme.typographyColor : AppTheme.disabledButtonTextColor),
                      underline: Container(
                        height: 1,
                        color: AppTheme.primaryColor,
                      ),
                      onChanged: (String? newValue) {
                        model.getCharacter != PaymentMethods.TPV ? model.setDenominationSelected(newValue!) : null;
                      },
                      items: model.getDenominations().map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                value: PaymentMethods.CASH,
                groupValue: model.getCharacter,
                onChanged: (PaymentMethods? value) {
                  model.setCharacter(value!);
                },
              ),

              RadioListTile<PaymentMethods>(
                title: Text(
                  Strings.paymentMethodTerminal,
                  style: AppTheme.darkText.bodyText1,
                ),
                value: PaymentMethods.TPV,
                groupValue: model.getCharacter,
                onChanged: (PaymentMethods? value) {
                  model.setCharacter(value!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottonDetail(PaymentViewModel model) {
    return Container(
      padding: EdgeInsets.only(
        top: (SizeConfig.heightMultiplier * 2),
      ),
      width: double.infinity,
      child: model.isEnableButton()
          ? TextButton(
        child: Text(Strings.finishLableButton,
            style: AppTheme.darkText.subtitle2),
        style: TextButton.styleFrom(
          backgroundColor: AppTheme.secondaryColor,
        ),
        onPressed: () => model.showConfirmDialog(),
      )
          : TextButton(
        child: Text(Strings.finishLableButton,
            style: AppTheme.darkText.subtitle2),
        style: TextButton.styleFrom(
          backgroundColor: AppTheme.disabledButtonColor,
        ),
        onPressed: null,
      ),
    );
  }
}
