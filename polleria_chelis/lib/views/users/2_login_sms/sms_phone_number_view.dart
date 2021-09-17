import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:polleria_chelis/views/users/2_login_sms/sms_phone_number_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../app/commons/app_theme.dart';
import '../../../app/commons/images.dart';
import '../../../app/commons/size_config.dart';
import '../../../app/commons/strings.dart';

class SmsPhoneNumberView extends StatelessWidget {
const SmsPhoneNumberView({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return ViewModelBuilder<SmsPhoneNumberViewModel>.reactive(
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
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    color: Colors.black,
                    iconSize: 11.67 * SizeConfig.widthMultipier,
                    padding: EdgeInsets.zero,
                    onPressed: model.navigateToOnBoardingView,
                  ),
                ),
              ),
              Expanded(
                flex: model.keyboardState ? 3 : 5,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 9.7 * SizeConfig.widthMultipier),
                    child: Image.asset(
                      Images.SmsAuthenticationPhoneNumber,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
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
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 56,
                          /*child: CountryCodePicker(
                            onChanged: model.setPhoneNumberCountryCode,
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'MX',
                            countryFilter: ['MX'],
                            hideSearch: true,
                            showCountryOnly: true,
                            textStyle: TextStyle(color: Colors.grey[400]),
                            //Get the country information relevant to the initial selection
                            onInit: (code) =>
                                //print("on init ${code}"),
                                model.setPhoneNumberCountryCode(code!),
                          ),*/
                          child: OutlineButton(
                            borderSide:
                            BorderSide(color: AppTheme.secondaryColor),
                            padding: EdgeInsets.all(0),
                            onPressed: null,
                            child: CountryCodePicker(
                              onChanged: model.setPhoneNumberCountryCode,
                              initialSelection: 'MX',
                              favorite: ['+52', 'MX'],
                              hideSearch: true,
                              showCountryOnly: true,
                              textStyle: TextStyle(color: Colors.grey[400]),
                              onInit: (code) => model.setPhoneNumberCountryCode(code!),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Form(
                            child: TextFormField(
                              enabled: !model.isBusy,
                              autofocus: true,
                              cursorColor: AppTheme.primaryColor,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                model.phoneNumberInputFormatter,
                              ],
                              decoration: const InputDecoration(
                                labelText: Strings.SmsPhoneNumberInput,
                                labelStyle:
                                TextStyle(color: AppTheme.primaryColor),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.primaryColor),
                                ),
                              ),
                              onChanged: (val) =>
                                  model.setSendPhoneNumberButtonState(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: !model.isBusy
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: MaterialButton(
                          child: Text(Strings.SmsPhoneNumberButton,
                              style: AppTheme.darkText.subtitle2),
                          color: AppTheme.secondaryColor,
                          disabledColor: AppTheme.disabledButtonColor,
                          onPressed: model.sendPhoneNumberButtonState
                              ? () => model.sendSmscode(true)
                              : null,
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
    viewModelBuilder: () => SmsPhoneNumberViewModel(),
  );
}
}