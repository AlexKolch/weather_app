import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

Widget getWeatherIcon(int code) {
  switch (code) {
    case >=200 && < 300 : 
    return Image.asset('assets/1.png');
    case >=300 && < 400 : 
    return Image.asset('assets/2.png');
    case >=500 && < 600 : 
    return Image.asset('assets/3.png');
    case >=600 && < 700 : 
    return Image.asset('assets/4.png');
    case >=700 && < 800 : 
    return Image.asset('assets/5.png');
       case == 800 : 
       return Image.asset('assets/6.png');
        case > 800 && <= 804 : 
    return Image.asset('assets/7.png');
    default: 
    return Image.asset('assets/7.png');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height:
              MediaQuery.of(context).size.height, // во весь экран
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(10, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-10, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: BoxDecoration(color: Color(0xFFFFAB40)),
                ),
              ),
              BackdropFilter(
                //РАЗМЫТИЕ ФОНА
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherBlocState>(
                builder: (context, state) {
                  if(state is WeatherBlocSuccess) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          '📍 ${state.weather.areaName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 8),
                        const Text(
                          'Weather today',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        getWeatherIcon(state.weather.weatherConditionCode!), //WEATHER ICON
                         Center(
                          child: Text(
                            '${state.weather.temperature!.celsius!.round()}°C', 
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 55,
                              fontWeight: FontWeight.w600,
                            ),
                          ), //ДАННЫЕ О ТЕМПЕРАТУРЕ
                        ),
                        Center(
                          child: Text(
                            state.weather.weatherMain!.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ), //Краткое описание погоды
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                            DateFormat("EEEE dd •").add_jm().format(state.weather.date!),  // 'Friday, 15 9:06AM'
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ), //ДАННЫЕ О ДАТЕ
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TimeRow(
                              image: 'assets/11.png',
                              title: 'Sunrise',
                              subTitle: DateFormat().add_jm().format(state.weather.sunrise!)
                            ),
                            TimeRow(
                              image: 'assets/12.png',
                              title: 'Sunset',
                              subTitle: DateFormat().add_jm().format(state.weather.sunset!)
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Divider(color: Color(0xFF37474F)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TimeRow(
                              image: 'assets/13.png',
                              title: 'Temp Max',
                              subTitle: '${state.weather.tempMax?.celsius?.round()} °C',
                            ),
                            TimeRow(
                              image: 'assets/14.png',
                              title: 'Temp Min',
                              subTitle: '${state.weather.tempMin?.celsius?.round()} °C',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                  } else {
                    return Container();
                  }
                },
              ), //На весь экран
            ],
          ),
        ),
      ),
    );
  }
}

class TimeRow extends StatelessWidget {
  TimeRow({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image;
  String title;
  String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, scale: 8),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(width: 3),
            Text(
              subTitle,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
