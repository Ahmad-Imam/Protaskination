
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:protaskination/screens/city_screen.dart';
import 'package:protaskination/services/weather.dart';
import 'package:protaskination/utilities/constants.dart';

var temperature = 0;

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final dynamic locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = new WeatherModel();
  List<int> dayTemp = [0, 0, 0, 0, 0];
  List<String> dayIcon = ['0', '0', '0', '0', '0'];
  List<String> weatherDescription = ['0', '0', '0', '0', '0'];

  var number = 0;

  String weatherIcon;
  String cityName;
  String message;

  var dayiconToday;
  var dayDescriptionToday;

  var weatherDescriptionToday;

  final _currentDate = DateTime.now();
  final _dayFormatter = DateFormat('d');
  final _monthFormatter = DateFormat('MMM');

  @override
  void initState() {
    updateUI(widget.locationWeather);
    super.initState();
  }

  void updateUI(weatherData) async {
    //print('haha${weatherData['name']}');
    var forecastmodel =
        await weatherModel.getForecastWeather(weatherData['name']);

    print('fore $forecastmodel');
    print(forecastmodel['list'][0]['main']['temp']);
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        message = 'Unable to get weather data';
        cityName = '';
        dayiconToday = '';
      }

      dayTemp.clear();
      dayIcon.clear();
      weatherDescription.clear();
      // print('DAYTEMP: $dayTemp, number $number');
      for (var i = 0; i < 5; i++) {
        dayTemp.add(forecastmodel['list'][number]['main']['temp'].toInt());
        dayIcon.add(forecastmodel['list'][number]['weather'][0]['icon']);
        weatherDescription
            .add(forecastmodel['list'][number]['weather'][0]['main']);
        number = number + 8;
      }
      // print('DAYTEMP AFTER: $dayTemp');

      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      message = weatherModel.getMessage(temperature);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      cityName = weatherData['name'];
      //print('$temperature $condition $cityName');
      dayiconToday = weatherData['weather'][0]['icon'];
      weatherDescriptionToday = weatherData['weather'][0]['main'];
      dayDescriptionToday = weatherData['weather'][0]['description'];

      //print('$daytemp1 $daytemp2  $daytemp3 $daytemp4 $daytemp5 ');
      // print('lol $dayicon1');
    });
  }

  Future getData(forecastmodel) async {}

  // void updateList(dynamic weatherData) {
  //   setState(() {
  //     if (weatherData == Null) {
  //       temperature = 0;
  //       weatherIcon = 'Error';
  //       message = 'Unable to get weather data';
  //       cityName = '';
  //       return;
  //     }
  //     var temp = weatherData['main']['temp'];
  //     temperature = temp.toInt();
  //     message = weatherModel.getMessage(temperature);
  //     var condition = weatherData['weather'][0]['id'];
  //     weatherIcon = weatherModel.getWeatherIcon(condition);
  //
  //     cityName = weatherData['name'];
  //     print('$temperature $condition $cityName');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: temperature >= 25
                ? [Color(0xffeb3349), Color(0xfff45c43)]
                : temperature < 25 && temperature > 20
                    ? [Color(0xff36d1dc), Color(0xff5b86e5)]
                    : [Color(0xff141e30), Color(0xff243b55)],
          ),
        ),
        //constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              dayTemp.clear();
                              dayIcon.clear();
                              weatherDescription.clear();
                              number = 0;
                            });
                            var weatherData =
                                await weatherModel.getLocationWeather();
                            updateUI(weatherData);
                          },
                          icon: Icon(
                            Icons.near_me,
                            size: 50.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            var typedName = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CityScreen();
                                },
                              ),
                            );
                            print(typedName);
                            if (typedName != null) {
                              dayTemp.clear();
                              dayIcon.clear();
                              weatherDescription.clear();
                              number = 0;
                              var weatherData =
                                  await weatherModel.getCityWeather(typedName);
                              updateUI(weatherData);
                            }
                          },
                          icon: Icon(
                            Icons.location_city,
                            size: 50.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                        Column(
                          children: [
                            Image.network(
                                'https://openweathermap.org/img/wn/${dayiconToday}.png'),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: Text(
                                '$weatherDescriptionToday',
                                style: TextStyle(
                                  fontFamily: 'Spartan MB',
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              " ${_dayFormatter.format(_currentDate.add(Duration(days: 0)))} ",
                              style: kMessageTextStyle,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                _monthFormatter.format(
                                  _currentDate.add(Duration(days: 0)),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Spartan MB',
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 15),
                    child: Text(
                      "It's $dayDescriptionToday in $cityName $message",
                      //textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Spartan MB',
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Column(
                    children: List<ForecastCard>.generate(
                      5,
                      (index) {
                        return ForecastCard(
                          dayIcon: dayIcon[index],
                          dayTemp: dayTemp[index],
                          dayNumber: index + 1,
                          weatherDescription: weatherDescription[index],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
/*                  ForecastCard(
                    dayIcon: dayIcon[1],
                    dayTemp: dayTemp[1],
                    dayNumber: 1,
                  ),
                  ForecastCard(
                    dayIcon: dayIcon[2],
                    dayTemp: dayTemp[2],
                    dayNumber: 1,
                  ),
                  Card(
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "$daytemp2°",
                          //textAlign: TextAlign.right,
                          style: kMessageTextStyle,
                        ),
                        Image.network(
                            'http://openweathermap.org/img/wn/${dayicon2}@2x.png'),
                        Text(
                          " ${_dayFormatter.format(_currentDate.add(Duration(days: 2)))} ",
                          style: kMessageTextStyle,
                        ),
                        Text(
                          _monthFormatter.format(
                            _currentDate.add(Duration(days: 2)),
                          ),
                          style: kMessageTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "$daytemp3°",
                          //textAlign: TextAlign.right,
                          style: kMessageTextStyle,
                        ),
                        Image.network(
                            'http://openweathermap.org/img/wn/${dayicon3}@2x.png'),
                        Text(
                          " ${_dayFormatter.format(_currentDate.add(Duration(days: 3)))} ",
                          style: kMessageTextStyle,
                        ),
                        Text(
                          _monthFormatter.format(
                            _currentDate.add(Duration(days: 3)),
                          ),
                          style: kMessageTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "$daytemp4°",
                          //textAlign: TextAlign.right,
                          style: kMessageTextStyle,
                        ),
                        Image.network(
                            'http://openweathermap.org/img/wn/${dayicon4}@2x.png'),
                        Text(
                          " ${_dayFormatter.format(_currentDate.add(Duration(days: 4)))} ",
                          style: kMessageTextStyle,
                        ),
                        Text(
                          _monthFormatter.format(
                            _currentDate.add(Duration(days: 4)),
                          ),
                          style: kMessageTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "$daytemp5°",
                          //textAlign: TextAlign.right,
                          style: kMessageTextStyle,
                        ),
                        Image.network(
                            'http://openweathermap.org/img/wn/${dayicon5}@2x.png'),
                        Text(
                          " ${_dayFormatter.format(_currentDate.add(Duration(days: 5)))} ",
                          style: kMessageTextStyle,
                        ),
                        Text(
                          _monthFormatter.format(
                            _currentDate.add(Duration(days: 5)),
                          ),
                          style: kMessageTextStyle,
                        ),
                      ],
                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForecastCard extends StatelessWidget {
  ForecastCard(
      {this.dayIcon, this.dayTemp, this.dayNumber, this.weatherDescription});

  var _currentDate = DateTime.now();
  var _dayFormatter = DateFormat('d');
  var _monthFormatter = DateFormat('MMM');
  final String dayIcon;
  final int dayNumber;
  final int dayTemp;
  final String weatherDescription;

  @override
  Widget build(BuildContext context) {
    //print("haha $temperature");
    return Card(
      color: temperature >= 25
          ? Color(0xffe5c400)
          : temperature < 25 && temperature > 20
              ? Color(0xff9d45d6)
              : Color(0xff4a4575),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "$dayTemp°",
            //textAlign: TextAlign.right,
            style: kMessageTextStyle,
          ),
          Column(
            children: [
              Image.network('https://openweathermap.org/img/wn/${dayIcon}.png'),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Text(
                  '$weatherDescription',
                  style: TextStyle(
                    fontFamily: 'Spartan MB',
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                " ${_dayFormatter.format(_currentDate.add(Duration(days: dayNumber)))} ",
                style: kMessageTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  _monthFormatter.format(
                    _currentDate.add(Duration(days: dayNumber)),
                  ),
                  style: TextStyle(
                    fontFamily: 'Spartan MB',
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
