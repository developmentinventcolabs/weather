import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Providers/Auth Provider/selection_provider.dart';
import '../../Utils/app_colors.dart';
import '../Weather/weather_screen.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SelectionProvider>().getCountryListApi(
            context: context,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          body: Container(
            margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: AppColors.borderColor, width: 1),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    child: DropdownButton(
                      isExpanded: true,
                      icon: value.isLoading
                          ? const Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : const Icon(Icons.keyboard_arrow_down,
                              size: 35, color: AppColors.greyText),
                      underline: Container(),
                      hint: TextWidget(
                        text: value.selectedCountry ?? 'Select Country',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.greyText,
                      ),
                      onChanged: (newValue) async {
                        /*  await context.read<SelectionProvider>().getStateApi(
                              country: newValue!.name.toString(),
                              context: context,
                            );*/

                        value.onSelectCountry(
                            newValue!.name.toString(), context);
                      },
                      items: value.countryList.map((country) {
                        return DropdownMenuItem(
                          value: country,
                          child: TextWidget(
                            text: country.name ?? '',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.greyText,
                          ),
                        );
                      }).toList(),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.borderColor, width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        child: DropdownButton(
                          isExpanded: true,
                          icon: value.isStateLoading
                              ? const Center(
                                  child: CupertinoActivityIndicator(),
                                )
                              : const Icon(Icons.keyboard_arrow_down,
                                  size: 35, color: AppColors.greyText),
                          underline: Container(),
                          hint: TextWidget(
                            text: value.selectedState ?? 'Select State',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.greyText,
                          ),
                          onChanged: (newValue) async {
                            /*   await context.read<SelectionProvider>().getCityApi(
                                      country: value.selectedCountry ?? "",
                                      state: newValue!.name.toString(),
                                      context: context,
                                    );*/
                            value.onSelectSate(
                                newValue!.name.toString(), context);
                          },
                          items: value.statesList.map((country) {
                            return DropdownMenuItem(
                              value: country,
                              child: TextWidget(
                                text: country.name ?? '',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.greyText,
                              ),
                            );
                          }).toList(),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.borderColor, width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        child: DropdownButton(
                          isExpanded: true,
                          icon: value.isCityLoading
                              ? const Center(
                                  child: CupertinoActivityIndicator(),
                                )
                              : const Icon(Icons.keyboard_arrow_down,
                                  size: 35, color: AppColors.greyText),
                          underline: Container(),
                          hint: TextWidget(
                            text: value.selectedCity ?? 'Select City',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.greyText,
                          ),
                          onChanged: (newValue) async {
                            value.onSelectCity(newValue.toString());

                          },
                          items: value.cityList.map((country) {
                            return DropdownMenuItem(
                              value: country,
                              child: TextWidget(
                                text: country,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.greyText,
                              ),
                            );
                          }).toList(),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),

                ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WeatherScreen(),
                    ),
                  );
                }, child: const TextWidget(
                  text:  'Submit',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.white,
                ),),
              ],
            ),
          ),
        );
      },
    );
  }
}
