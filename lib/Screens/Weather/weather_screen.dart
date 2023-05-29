import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Providers/Auth Provider/selection_provider.dart';
import '../../Utils/app_colors.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SelectionProvider>().getWeatherDataApi(
            context: context,
          );
    });
    super.initState();
  }


  String formatDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(dateTime);
    } on FormatException {
      return date;
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
            backgroundColor: Colors.blue,
            body: Container(
              margin: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: value.isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator( radius: 24,color: AppColors.white),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: value.weatherModel?.location?.name ?? '',
                          fontWeight: FontWeight.w500,
                          fontSize: 28,
                          color: AppColors.white,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextWidget(
                          text: formatDate( value.weatherModel?.location?.localtime ?? ''),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.black,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextWidget(
                          text: "Wind: " +
                              (value.weatherModel?.current?.windKph ?? 0)
                                  .toString()+" kph",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.white,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: (value.weatherModel?.current?.tempC ?? 0.0).toString() +
                                        " \u2103",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    color: AppColors.white,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  TextWidget(
                                    text: "Feels like:  " +
                                        (value.weatherModel?.current
                                                    ?.feelslikeC ??
                                                0)
                                            .toString() +
                                        "°",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Column(
                                children: [
                                  Image.network(
                                    "https:${value.weatherModel?.current?.condition?.icon ?? ''}",
                                    height: 70.0,
                                    width: 70.0,
                                    fit: BoxFit.fill,
                                  ),
                                  TextWidget(
                                    text: (value.weatherModel?.current
                                                ?.condition?.text ??
                                            '')
                                        .toString(),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.white,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
            ));
      },
    );
  }
}
