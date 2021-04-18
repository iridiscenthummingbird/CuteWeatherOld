import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'provider/customProvider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:vector_math/vector_math.dart' as vector;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CustomProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CuteWeather',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class CitySearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    context.read<CustomProvider>().getCity(query);

    return Consumer<CustomProvider>(builder: (context, customProvider, _) {
      if (customProvider.city == null || query == '') {
        //return Center(child: CircularProgressIndicator());
        return Center();
      }
      return Padding(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
          child: ListTile(
            leading: Image(
              image:
                  AssetImage('assets/${customProvider.city.weather.icon}.png'),
              width: 40,
              height: 40,
            ),
            title:
                Text(customProvider.city.name, style: TextStyle(fontSize: 18)),
            subtitle: Text(
              "${customProvider.city.temp.round()}°",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              customProvider.setCity(customProvider.city);
              customProvider.getData();
              close(context, null);
            },
          ));
    });
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CustomProvider>().getData();
  }

  String uvi(int val) {
    if (val >= 0 && val <= 2) {
      return "Low";
    } else if (val >= 3 && val <= 5) {
      return "Moderate";
    } else if (val >= 6 && val <= 7) {
      return "High";
    } else if (val >= 8 && val <= 10) {
      return "Very high";
    } else if (val >= 11) {
      return "Extreme";
    }
    return "";
  }

  String windDeg(double deg) {
    if (deg >= 22.5 && deg < 67.5) {
      return "SW";
    } else if (deg >= 67.5 && deg < 112.5) {
      return "W";
    } else if (deg >= 112.5 && deg < 157.5) {
      return "NW";
    } else if (deg >= 157.5 && deg < 202.5) {
      return "N";
    } else if (deg >= 202.5 && deg < 247.5) {
      return "NE";
    } else if (deg >= 247.5 && deg < 292.5) {
      return "E";
    } else if (deg >= 292.5 && deg < 337.5) {
      return "SE";
    } else {
      return "S";
    }
  }

  int getBeaufort(double speed) {
    if (speed < 0.5) {
      return 0;
    } else if (speed >= 0.5 && speed < 1.5) {
      return 1;
    } else if (speed >= 1.5 && speed < 3.3) {
      return 2;
    } else if (speed >= 3.3 && speed < 5.5) {
      return 3;
    } else if (speed >= 5.5 && speed < 7.9) {
      return 4;
    } else if (speed >= 7.9 && speed < 10.7) {
      return 5;
    } else if (speed >= 10.7 && speed < 13.8) {
      return 6;
    } else if (speed >= 13.9 && speed < 17.1) {
      return 7;
    } else if (speed >= 17.2 && speed < 20.7) {
      return 8;
    } else if (speed >= 20.7 && speed < 24.4) {
      return 9;
    } else if (speed >= 24.4 && speed < 28.4) {
      return 10;
    } else if (speed >= 28.4 && speed < 32.6) {
      return 11;
    } else {
      return 12;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomProvider>(builder: (context, customProvider, _) {
      if (customProvider.location == null || customProvider.city == null) {
        return Center(child: CircularProgressIndicator());
      }

      List<Widget> hourList = [];
      List<Widget> dayList = [];
      for (int i = 0; i < 24; i++) {
        hourList.add(
          Padding(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                        DateFormat.Hm().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                customProvider.location.hourly[i].dt * 1000)),
                        style: TextStyle(fontSize: 16, color: Colors.black54))),
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Image(
                      image: AssetImage(
                          'assets/${customProvider.location.hourly[i].weather.icon}.png'),
                      width: 41,
                      height: 41,
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                        "${customProvider.location.hourly[i].temp.round()}°",
                        style: TextStyle(fontSize: 20))),
              ],
            ),
            padding: EdgeInsets.only(right: 10, left: i == 0 ? 10 : 0),
          ),
        );
      }
      int i = 0;
      for (var item in customProvider.location.daily) {
        dayList.add(Padding(
          padding: EdgeInsets.only(right: i < 7 ? 10 : 0),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(75, 214, 214, 214)),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                        DateFormat('EEE').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                item.dt * 1000)),
                        style: TextStyle(fontSize: 20))),
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                        DateFormat('MMM d').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                item.dt * 1000)),
                        style: TextStyle(fontSize: 12))),
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Image(
                      image: AssetImage('assets/${item.weather.icon}.png'),
                      width: 30,
                      height: 30,
                    )),
                Text("High: " + "${item.temp.max.round()}°C",
                    style: TextStyle(fontSize: 12)),
                Text("Low: " + "${item.temp.min.round()}°C",
                    style: TextStyle(fontSize: 12))
              ],
            ),
          ),
        ));
        i++;
      }

      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  onPressed: () {
                    showSearch(context: context, delegate: CitySearch());
                  })
            ],
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: Column(
              children: [
                Text(
                  customProvider.city.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  DateFormat('EEE h:mm').format(DateTime.now()),
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
          body: RefreshIndicator(
              onRefresh: customProvider.getData,
              color: Colors.black,
              child: ListView(
                children: [
                  Center(
                      child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(customProvider.location.current.weather.main,
                                style: TextStyle(fontSize: 20)),
                            Padding(
                              child: Image(
                                image: AssetImage(
                                    'assets/${customProvider.location.current.weather.icon}.png'),
                                width: 30,
                                height: 30,
                              ),
                              padding: EdgeInsets.only(left: 10),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                    "${customProvider.location.current.temp.round()}°",
                                    style: TextStyle(fontSize: 52)),
                                Text('C', style: TextStyle(fontSize: 24))
                              ],
                            ),
                            Tooltip(
                                message: "Pressure",
                                child: Row(
                                  children: [
                                    Text(
                                        customProvider.location.current.pressure
                                            .toString(),
                                        style: TextStyle(fontSize: 14)),
                                    Padding(
                                      child: Image(
                                        height: 14,
                                        width: 14,
                                        image:
                                            AssetImage('assets/barometer.png'),
                                      ),
                                      padding: EdgeInsets.only(left: 5),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "feels like ${customProvider.location.current.feels_like.round()}°C",
                                  style: TextStyle(fontSize: 14)),
                              Tooltip(
                                message: "Humidity",
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        customProvider.location.current.humidity
                                            .toString(),
                                        style: TextStyle(fontSize: 14)),
                                    Padding(
                                      child: Image(
                                        height: 14,
                                        width: 14,
                                        image:
                                            AssetImage('assets/humidity.png'),
                                      ),
                                      padding: EdgeInsets.only(left: 5),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 20, bottom: 10),
                            child: Align(
                              child: Text("Hourly forecast",
                                  style: TextStyle(fontSize: 20)),
                              alignment: Alignment.centerLeft,
                            )),
                        SizedBox(
                            height: 110,
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(75, 214, 214, 214)),
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: ListView(
                                      children: hourList,
                                      scrollDirection: Axis.horizontal,
                                    )))),
                        Container(
                            padding: EdgeInsets.only(top: 20, bottom: 10),
                            child: Align(
                              child: Text("Daily forecast",
                                  style: TextStyle(fontSize: 20)),
                              alignment: Alignment.centerLeft,
                            )),
                        SizedBox(
                          height: 130,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: dayList),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 20, bottom: 10),
                            child: Align(
                              child: Text("Wind and pressure",
                                  style: TextStyle(fontSize: 20)),
                              alignment: Alignment.centerLeft,
                            )),
                        SizedBox(
                            height: 110,
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(75, 214, 214, 214)),
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Transform.rotate(
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/down-arrow.png'),
                                                ),
                                                angle: vector.radians(
                                                    customProvider.location
                                                        .current.wind_deg)),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 7, bottom: 7),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  windDeg(customProvider
                                                      .location
                                                      .current
                                                      .wind_deg),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black54)),
                                              Text(
                                                  "${customProvider.location.current.wind_speed.toString()} m/s",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Text(
                                                  "${getBeaufort(customProvider.location.current.wind_speed).toString()} Beaufort${customProvider.location.current.wind_speed >= 1.5 ? "s" : ""}", //посчитать
                                                  style:
                                                      TextStyle(fontSize: 18))
                                            ],
                                          ),
                                        ),
                                        VerticalDivider(
                                          thickness: 1,
                                          color: Colors.black45,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 7, bottom: 7),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Pressure",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black54)),
                                              Image(
                                                height: 20,
                                                width: 20,
                                                image: AssetImage(
                                                    'assets/barometer.png'),
                                              ),
                                              Text(
                                                  "${customProvider.location.current.pressure.toString()} mbar",
                                                  style:
                                                      TextStyle(fontSize: 18))
                                            ],
                                          ),
                                        ),
                                      ],
                                    )))),
                        Container(
                            padding: EdgeInsets.only(top: 20, bottom: 10),
                            child: Align(
                              child: Text("Details",
                                  style: TextStyle(fontSize: 20)),
                              alignment: Alignment.centerLeft,
                            )),
                        SizedBox(
                            height: 255,
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(75, 214, 214, 214)),
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image(
                                              height: 64,
                                              width: 64,
                                              image: AssetImage(
                                                  'assets/${customProvider.location.current.weather.icon}.png'), //увеличить размер всех картинок
                                            )
                                          ],
                                        )),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            child: Image(
                                                              height: 16,
                                                              width: 16,
                                                              image: AssetImage(
                                                                  'assets/humidity.png'),
                                                            )),
                                                        Text(
                                                          "Humidity",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                        "${customProvider.location.current.humidity.toString()}%",
                                                        style: TextStyle(
                                                            fontSize: 16))
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: DottedLine(),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            child: Image(
                                                              height: 16,
                                                              width: 16,
                                                              image: AssetImage(
                                                                  'assets/sun.png'),
                                                            )),
                                                        Text(
                                                          "UV-index",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                        "${customProvider.location.current.uvi.toString()} (${uvi(customProvider.location.current.uvi.round())})",
                                                        style: TextStyle(
                                                            fontSize: 16))
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: DottedLine(),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            child: Image(
                                                              height: 16,
                                                              width: 16,
                                                              image: AssetImage(
                                                                  'assets/eye.png'),
                                                            )),
                                                        Text(
                                                          "Visibility",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                        "${customProvider.location.current.visibility / 1000} km",
                                                        style: TextStyle(
                                                            fontSize: 16))
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: DottedLine(),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            child: Image(
                                                              height: 16,
                                                              width: 16,
                                                              image: AssetImage(
                                                                  'assets/dew_point.png'),
                                                            )),
                                                        Text(
                                                          "Dew point",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                        "${customProvider.location.current.dew_point.round()}°",
                                                        style: TextStyle(
                                                            fontSize: 16))
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: DottedLine(),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            child: Image(
                                                              height: 16,
                                                              width: 16,
                                                              image: AssetImage(
                                                                  'assets/03d.png'),
                                                            )),
                                                        Text(
                                                          "Clouds",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                        "${customProvider.location.current.clouds}%",
                                                        style: TextStyle(
                                                            fontSize: 16))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          flex: 2,
                                        )
                                      ],
                                    )))),
                      ],
                    ),
                  )),
                ],
              )));
    });
  }
}
