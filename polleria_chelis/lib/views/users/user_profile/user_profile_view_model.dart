
import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/app/setup/locator.dart';
import 'package:polleria_chelis/models/users.dart';
import 'package:polleria_chelis/services/authentication_data_service.dart';
import 'package:polleria_chelis/services/delivery_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserProfileViewModel extends BaseViewModel{

  String _genreSelected = "";
  get getGenreSelected => this._genreSelected;
  void setGenreSelected(String newValue){
    print("setGenreSelected: "+ newValue);
    this._genreSelected = newValue;
  }

  //------------------------- NAVIGATION SERVICE -------------------------

  Future navigateToSummaryView() async {
    null;
  }

  //------------------------- DELIVERY SERVICE -------------------------
  final DeliveryDataService _deliveryDataService = locator<DeliveryDataService>();

  get getDeliveryDataService => _deliveryDataService;

  int getProductNumberInCart() {
    return this._deliveryDataService.counter;
  }


  //------------------------- AUTHENTICATION SERVICE -------------------------
  final AuthenticationDataService _authenticationDataService = locator<AuthenticationDataService>();
  get getAuthenticationDataService => this._authenticationDataService;



  //------------------------- TEXT CONTROLLER -------------------------
  TextEditingController _phoneTextController = TextEditingController();
  get getPhoneTextController => this._phoneTextController;

  TextEditingController _nameTextController = TextEditingController();
  get getNameTextController => this._nameTextController;

  TextEditingController _lastNameTextController = TextEditingController();
  get getLastNameTextController => this._lastNameTextController;

  TextEditingController _emailTextController = TextEditingController();
  get getEmailTextController => this._emailTextController;

  TextEditingController _birthDateTextController = TextEditingController();
  get getBirthDateTextController => this._birthDateTextController;


  TextEditingController _dateCtl = TextEditingController();
  get getDateCtl => this._dateCtl;

  Future<void> loadData() async {
    setBusy(true);
    Users? results = await Users.getUserByPhoneNumber(this._authenticationDataService.phoneNumber);

    if(results != null){
      this._phoneTextController.text = this._authenticationDataService.phoneNumber;
      this._nameTextController.text = results.name;
      this._lastNameTextController.text = results.lastName;
      this._emailTextController.text = results.email;
      this._birthDateTextController.text = results.birthDate;
      this.setGenreSelected(results.gender);
    } else{
      this._phoneTextController.text = this._authenticationDataService.phoneNumber;
    }
    setBusy(false);
  }


  bool isEnableButton() {
    bool enable = false;
    if(this._phoneTextController.text.isNotEmpty && this._nameTextController.text.isNotEmpty && this._lastNameTextController.text.isNotEmpty && this._emailTextController.text.isNotEmpty){
      enable = true;
    }
    return enable;
  }


  Future<void> saveUser() async {
    bool existUser = await Users.existeUser(this._authenticationDataService.phoneNumber);

    if(existUser){
      print("saveUser: " + this.getGenreSelected);
      //si el usuario eciste lo actualiza
      Users userUpdate = Users(this._authenticationDataService.phoneNumber, this._emailTextController.text, this._nameTextController.text,
          this._lastNameTextController.text, this._birthDateTextController.text, this.getGenreSelected == "Genero" ? "" : this.getGenreSelected, "USER");
      await Users.updateUser(this._authenticationDataService.phoneNumber, userUpdate);
    } else {
      //si no existe el usuario lo crea
      Users user = new Users(this._authenticationDataService.phoneNumber, this._emailTextController.text, this._nameTextController.text, this._lastNameTextController.text, this._birthDateTextController.text, this.getGenreSelected == "Genero" ? "" : this.getGenreSelected, "USER");
      Users.saveUser(user);
    }
    this.showFinishSnackbar();
  }

  //------------------------- SNACKBAR -------------------------
  final SnackbarService _snackbarService = locator<SnackbarService>();
  void showFinishSnackbar(){
    _snackbarService.showSnackbar(
      message: '',
      title: Strings.snackbarSaveUserTitle,
      duration: Duration(seconds: 3),
    );
  }



}