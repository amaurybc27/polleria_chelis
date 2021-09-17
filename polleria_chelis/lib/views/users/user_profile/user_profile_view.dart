
import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/views/users/user_profile/user_profile_view_model.dart';
import 'package:polleria_chelis/views/widgets/app_bar_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class UserProfileView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserProfileViewModel>.reactive(
      viewModelBuilder: () => UserProfileViewModel(),
      onModelReady: (model) => model.loadData(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme.primaryColor,
          appBar: CustomAppBar(
              model.getProductNumberInCart, model.navigateToSummaryView, false),
          body: this._body(context, model),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, UserProfileViewModel model) {
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
            right: (SizeConfig.widthMultipier * 4),
            top: (SizeConfig.widthMultipier * 4),
            bottom: (SizeConfig.widthMultipier * 2),
            left: (SizeConfig.widthMultipier * 4),
          ),
          child: Column(
            children: [
              this._centerDetail(model, context),
              this._bottonDetail(model),
            ],
          ),
        ),
      ),
    );
  }

  Widget _centerDetail(UserProfileViewModel model, BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          SizedBox(
            height: (SizeConfig.heightMultiplier * 2),
          ),
          CircleAvatar(
            radius: (SizeConfig.widthMultipier * 12),
            backgroundColor: AppTheme.secondaryColor,
            child: Text(
              "A",
              style: AppTheme.darkText.headline2,
            ),
          ),
          SizedBox(
            height: (SizeConfig.heightMultiplier * 2),
          ),
          TextFormField(
            controller: model.getNameTextController,
            cursorColor: AppTheme.primaryColor,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: Strings.profileName,
              labelStyle: TextStyle(color: AppTheme.primaryColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryColor),
              ),
            ),
          ),
          SizedBox(
            height: (SizeConfig.heightMultiplier * 2),
          ),
          TextFormField(
            controller: model.getLastNameTextController,
            cursorColor: AppTheme.primaryColor,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: Strings.profileLastName,
              labelStyle: TextStyle(color: AppTheme.primaryColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryColor),
              ),
            ),
          ),
          SizedBox(
            height: (SizeConfig.heightMultiplier * 2),
          ),
          TextFormField(
            controller: model.getEmailTextController,
            cursorColor: AppTheme.primaryColor,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: Strings.profileEmail,
              labelStyle: TextStyle(color: AppTheme.primaryColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryColor),
              ),
            ),
          ),
          SizedBox(
            height: (SizeConfig.heightMultiplier * 2),
          ),
          TextFormField(
            readOnly: true,
            controller: model.getPhoneTextController,
            cursorColor: AppTheme.primaryColor,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: Strings.profilePhoneNumber,
              labelStyle: TextStyle(color: AppTheme.primaryColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryColor),
              ),
            ),
          ),
          SizedBox(
            height: (SizeConfig.heightMultiplier * 2),
          ),
          TextFormField(
            controller: model.getBirthDateTextController,
            cursorColor: AppTheme.primaryColor,
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              labelText: Strings.profileBirthDay,
              labelStyle: TextStyle(color: AppTheme.primaryColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryColor),
              ),
            ),
            onTap: () async {
              DateTime date = DateTime(1900);
              FocusScope.of(context).requestFocus(new FocusNode());
              date = (await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100)))!;
              String formattedDate = DateFormat('dd-MM-yyyy').format(date);
              model.getBirthDateTextController.text = formattedDate;
            },
          ),
          SizedBox(
            height: (SizeConfig.heightMultiplier * 2),
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              hintText: Strings.profileGenre,
              hintStyle: TextStyle(color: AppTheme.primaryColor),
              enabledBorder: const OutlineInputBorder(
                borderSide:
                const BorderSide(color: AppTheme.primaryColor, width: 1.0),
              ),
              border: const OutlineInputBorder(),
            ),
            items: <String>['Genero','Hombre', 'Mujer'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            //value: model.getGenreSelected,
            onChanged: (newValue) {
              model.setGenreSelected(newValue!);
            },
            value: model.getGenreSelected != "" ? model.getGenreSelected : "Genero",
          ),
          SizedBox(
            height: (SizeConfig.heightMultiplier * 2),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              Strings.profileRequired,
              style: AppTheme.errorText.bodyText2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottonDetail(UserProfileViewModel model) {
    return Container(
      padding: EdgeInsets.only(
        top: (SizeConfig.heightMultiplier * 2),
      ),
      width: double.infinity,
      child: model.isEnableButton()
          ? TextButton(
        child: Text(Strings.profileSaveButton,
            style: AppTheme.darkText.subtitle2),
        style: TextButton.styleFrom(
          backgroundColor: AppTheme.secondaryColor,
        ),
        onPressed: () => model.saveUser(),
      )
          : TextButton(
        child: Text(Strings.profileSaveButton,
            style: AppTheme.darkText.subtitle2),
        style: TextButton.styleFrom(
          backgroundColor: AppTheme.disabledButtonColor,
        ),
        onPressed: null,
      ),
    );
  }
}
