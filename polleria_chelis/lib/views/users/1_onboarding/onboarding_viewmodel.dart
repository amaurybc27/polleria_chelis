import 'package:polleria_chelis/app/setup/app_setup.router.dart';
import 'package:polleria_chelis/app/setup/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/commons/strings.dart';
import '../../../app/commons/images.dart';

class OnboardingViewModel extends BaseViewModel {
  final _banners = [
    {
      'image': Images.OnBoardingImage1,
      'headline': Strings.OnBoardingHeadline1,
      'subtitle': Strings.OnBoardingSubtitle1,
    },
    /*{
      'image': Images.OnBoardingImage2,
      'headline': Strings.OnBoardingHeadline2,
      'subtitle': Strings.OnBoardingSubtitle2,
    },
    {
      'image': Images.OnBoardingImage3,
      'headline': Strings.OnBoardingHeadline3,
      'subtitle': Strings.OnBoardingSubtitle3,
    },*/
  ];

  final NavigationService _navigationService = locator<NavigationService>();

  get getBanners => _banners;

  Future navigateToSmsLogin() async {
    await _navigationService.navigateTo(Routes.smsPhoneNumberView);
  }

  /*Future navigateToFacebookLogin() async {
    await _navigationService.navigateTo(Routes.smsPhoneNumberView);
  }*/
}
