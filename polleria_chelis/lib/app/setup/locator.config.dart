// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i5;

import '../../services/authentication_data_service.dart' as _i3;
import '../../services/delivery_data_service.dart' as _i4;
import '../../services/image_service.dart' as _i6;
import 'third_party_services_module.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<_i3.AuthenticationDataService>(
      () => thirdPartyServicesModule.authenticationDataService);
  gh.lazySingleton<_i4.DeliveryDataService>(
      () => thirdPartyServicesModule.summaryDataService);
  gh.lazySingleton<_i5.DialogService>(
      () => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<_i6.ImageService>(
      () => thirdPartyServicesModule.imageService);
  gh.lazySingleton<_i5.NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<_i5.SnackbarService>(
      () => thirdPartyServicesModule.snackBarService);
  return get;
}

class _$ThirdPartyServicesModule extends _i7.ThirdPartyServicesModule {
  @override
  _i3.AuthenticationDataService get authenticationDataService =>
      _i3.AuthenticationDataService();
  @override
  _i4.DeliveryDataService get summaryDataService => _i4.DeliveryDataService();
  @override
  _i5.DialogService get dialogService => _i5.DialogService();
  @override
  _i6.ImageService get imageService => _i6.ImageService();
  @override
  _i5.NavigationService get navigationService => _i5.NavigationService();
  @override
  _i5.SnackbarService get snackBarService => _i5.SnackbarService();
}
