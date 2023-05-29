import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Models/city_list_model.dart';
import '../../Models/country_list_model.dart';
import '../../Models/state_list_model.dart';
import '../../Models/weather_model.dart';
import '../../Remote/api_config.dart';
import '../../Remote/remote_service.dart';
import '../../Utils/helper_methods.dart';

class SelectionProvider with ChangeNotifier {
  bool isLoading = false;
  bool isStateLoading = false;
  bool isCityLoading = false;
  String? selectedCountry;
  WeatherModel? weatherModel;

  String? selectedState;

  String? selectedCity;

  bool isSelectedLanguageListEmpty = false;
  List<CountryList> countryList = [];
  List<StatesList> statesList = [];
  List<String> cityList = [];

  onSelectCountry(String country, BuildContext context) async {
    selectedCountry = country.toString();
    selectedState = null;
    statesList.clear();
    cityList.clear();
    selectedCity = null;
    notifyListeners();

    await getStateApi(
      country: country.toString(),
      context: context,
    );
  }

  onSelectSate(String state, BuildContext context) async {
    selectedState = state.toString();
    selectedCity = null;
    cityList.clear();
    notifyListeners();

    await getCityApi(
      country: selectedCountry ?? "",
      state: state.toString(),
      context: context,
    );
  }

  onSelectCity(String city) async {
    selectedCity = city;

    notifyListeners();
  }

  Future<StateListModel?> getStateApi(
      {required String country, required BuildContext context}) async {
    isStateLoading = true;
    final data = await RemoteService().callGetApi(
      url: '$states/q?country=$country',
      isUseBaseUrl: true,
    );
    if (data != null) {
      final stateListModel = StateListModel.fromJson(jsonDecode(data.body));
      statesList = stateListModel.data!.statesList!;
      if (statesList.isEmpty) {
        showSnackBar(
            context: context,
            message: 'state not found, please select another country',
            isSuccess: false);
      }
      isStateLoading = false;
      notifyListeners();
      return stateListModel;
    }
    isStateLoading = false;
    notifyListeners();
    return null;
  }

  Future<CityListModel?> getCityApi(
      {required String country,
      required String state,
      required BuildContext context}) async {
    isCityLoading = true;
    notifyListeners();
    final data = await RemoteService().callGetApi(
        url: '$cities/q?country=$country&state=$state', isUseBaseUrl: true);
    if (data != null) {
      final cityListModel = CityListModel.fromJson(jsonDecode(data.body));
      cityList = cityListModel.cityList!;
      if (cityList.isEmpty) {
        showSnackBar(
            context: context,
            message: 'city not found, please select another state',
            isSuccess: false);
      }
      isCityLoading = false;
      notifyListeners();
      return cityListModel;
    }
    isCityLoading = false;
    notifyListeners();
    return null;
  }

  Future<List<CountryList>?> getCountryListApi(
      {required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    final data = await RemoteService().callGetApi(
      url: capital,
    );
    if (data != null) {
      final countryListModel = CountryListModel.fromJson(jsonDecode(data.body));
      if (context.mounted) {
        if (countryListModel.error == true) {
          showSnackBar(
              isSuccess: false,
              message: "Something went wrong...",
              context: context);
        }
      }
      countryList = countryListModel.countryList!;
      isLoading = false;
      notifyListeners();
      return countryListModel.countryList;
    }
    isLoading = false;
    notifyListeners();
    return null;
  }

  Future<WeatherModel?> getWeatherDataApi(
      {required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    final data = await RemoteService().callGetApi(
      isUseBaseUrl: false,
      url: "$weatherapi$selectedCity&aqi=no",
    );
    if (data != null) {
      final countryListModel = WeatherModel.fromJson(jsonDecode(data.body));
      weatherModel = countryListModel;
      isLoading = false;
      notifyListeners();
      return countryListModel;
    }
    isLoading = false;
    notifyListeners();
    return null;
  }
}
