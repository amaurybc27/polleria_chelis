import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/commons/app_theme.dart';
import '../../../app/commons/strings.dart';
import '../../../app/commons/size_config.dart';
import 'onboarding_viewmodel.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Center(
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return model.getBanners.length == 1 ? this.getContent(constraints, model) : this.getBanner(constraints, model);
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        3.9 * SizeConfig.widthMultipier,
                        0,
                        3.9 * SizeConfig.widthMultipier,
                        3.9 * SizeConfig.widthMultipier),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: TextButton(
                            child: Text(Strings.OnBoardingSmsButton,
                                style: AppTheme.darkText.subtitle2),
                            style: TextButton.styleFrom(
                              backgroundColor: AppTheme.secondaryColor,
                            ),
                            onPressed: () => model.navigateToSmsLogin(),
                          ),
                        ),
                        /*Container(
                          width: double.infinity,
                          child: TextButton(
                            child: Text(Strings.OnBoardingFacebookButton,
                                style: AppTheme.lightText.subtitle2),
                            style: TextButton.styleFrom(
                              backgroundColor: AppTheme.facebookColor,
                            ),
                            onPressed: () => model.navigateToFacebookLogin(),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
    );
  }



  Widget getBanner(BoxConstraints constraints, OnboardingViewModel model){
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        autoPlay: true,
        height: constraints.maxHeight,
      ),
      items: model.getBanners
          .map<Widget>(
            (banner) => Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      9.7 * SizeConfig.widthMultipier,
                      5 * SizeConfig.heightMultiplier,
                      9.7 * SizeConfig.widthMultipier,
                      3 * SizeConfig.heightMultiplier),
                  child: Image.asset(
                    banner['image'],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    width: constraints.maxWidth * 0.9,
                    child: Text(
                        banner['headline'],
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.headline4,
                        style: AppTheme.darkText.headline4
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.8,
                    child: Text(
                        banner['subtitle'],
                        textAlign: TextAlign.center,
                        //style: Theme.of(context).textTheme.subtitle1,
                        style: AppTheme.darkText.subtitle2
                    ),
                    margin: EdgeInsets.only(top: 8),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          .toList(),
    );
  }

  Widget getContent(BoxConstraints constraints, OnboardingViewModel model){
    return Column(
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  9.7 * SizeConfig.widthMultipier,
                  5 * SizeConfig.heightMultiplier,
                  9.7 * SizeConfig.widthMultipier,
                  3 * SizeConfig.heightMultiplier),
              child: Image.asset(
                model.getBanners[0]['image'],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              Container(
                width: constraints.maxWidth * 0.9,
                child: Text(
                    model.getBanners[0]['headline'],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    //style: Theme.of(context).textTheme.headline4,
                    style: AppTheme.darkText.headline4
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.8,
                child: Text(
                    model.getBanners[0]['subtitle'],
                    textAlign: TextAlign.center,
                    //style: Theme.of(context).textTheme.subtitle1,
                    style: AppTheme.darkText.subtitle2
                ),
                margin: EdgeInsets.only(top: 8),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
