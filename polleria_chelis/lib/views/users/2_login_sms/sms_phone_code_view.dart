
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/views/users/2_login_sms/sms_phone_code_view_model.dart';
import 'package:stacked/stacked.dart';

class SmsPhoneCodeView extends StatelessWidget {
  const SmsPhoneCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SmsPhoneCodeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: false,
          left: false,
          right: false,
          child: Container(
            padding: EdgeInsets.all(
                AppTheme.horizontalMargin * SizeConfig.widthMultipier),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_left),
                      color: Colors.black,
                      iconSize: 11.67 * SizeConfig.widthMultipier,
                      padding: EdgeInsets.zero,
                      onPressed: () => model.navigateToSmsPhoneNumberView(),
                    ),
                  ),
                ),
                Expanded(
                  flex: model.keyboardState ? 1 : 3,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      Strings.SmsPhoneNumberHeadline,
                      textAlign: TextAlign.center,
                      style: model.keyboardState
                          ? AppTheme.darkText.headline5
                          : AppTheme.darkText.headline5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      Strings.SmsCodeSubtitle,
                      textAlign: TextAlign.center,
                      style: AppTheme.darkText.subtitle1,
                    ),
                  ),
                ),
                Expanded(
                  flex: model.keyboardState ? 1 : 3,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      model.formattedPhoneNumber,
                      textAlign: TextAlign.center,
                      style: AppTheme.darkText.headline6,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: TextFormField(
                      enabled: !model.isBusy,
                      inputFormatters: [
                        model.phoneCodeInputFormatter,
                      ],
                      autofocus: true,
                      cursorColor: AppTheme.primaryColor,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: Strings.SmsCodeInputText,
                        labelStyle: TextStyle(color: AppTheme.primaryColor),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppTheme.primaryColor),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Strings.SmsCodeInputText;
                        }
                        return null;
                      },
                      onChanged: (val) => model.setSendSmsCodeButtonState(),
                    ),
                  ),
                ),
                Expanded(
                  flex: model.keyboardState ? 1 : 2,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 3.9),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Text(
                            Strings.SmsCodeQuestion,
                            textAlign: TextAlign.left,
                            style: AppTheme.darkText.bodyText2,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 1 * SizeConfig.heightMultiplier),
                          alignment: Alignment.centerLeft,
                          child: model.smsResendCounter != 0
                              ? Text(
                            Strings.SmsCodeResendTime +
                                ' ${model.smsResendCounter} ' +
                                Strings.SmsCodeResendTimeSeconds,
                            textAlign: TextAlign.left,
                            style: AppTheme.darkText.bodyText2
                            !.merge(TextStyle(
                                color: AppTheme.errorColor)),
                          )
                              : Builder(
                            builder: (ctx) => InkWell(
                              child: Text(
                                Strings.SmsCodeResend,
                                style: AppTheme.darkText.subtitle1
                                !.merge(
                                  TextStyle(
                                      color: AppTheme.successColor),
                                ),
                              ),
                              onTap: () {
                                model.resendSmscode();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: model.keyboardState ? 1 : 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: !model.isBusy
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: model.sendSmsCodeButtonState
                                ? () => model.smsCodeValidation()
                                : null,
                            child: Text(Strings.SmsPhoneCodeButton,
                                style: AppTheme.darkText.subtitle2),
                            color: AppTheme.secondaryColor,
                            disabledColor: AppTheme.disabledButtonColor,
                            disabledTextColor:
                            AppTheme.disabledButtonTextColor,
                          ),
                        ),
                      ],
                    )
                        : CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.secondaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SmsPhoneCodeViewModel(),
    );
  }
}
