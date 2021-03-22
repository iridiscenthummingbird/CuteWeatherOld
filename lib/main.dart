import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'provider/customProvider.dart';

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

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CustomProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomProvider>(builder: (context, customProvider, _) {
      if (customProvider.location == null) {
        return Center(child: CircularProgressIndicator());
      }

      List<Widget> hourList = [];
      List<Widget> dayList = [];
      int i = 0;
      for (int i = 0; i < 24; i++) {
        hourList.add(
          Padding(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                        "${customProvider.location.hourly[i].temp.round()}°",
                        style: TextStyle(fontSize: 20))),
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Image(
                      image: AssetImage(
                          'assets/${customProvider.location.hourly[i].weather.icon}.png'),
                      width: 30,
                      height: 30,
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                        DateFormat.Hm().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                customProvider.location.hourly[i].dt * 1000)),
                        style: TextStyle(fontSize: 16))),
                Text(
                    DateFormat('d MMM').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            customProvider.location.hourly[i].dt * 1000)),
                    style: TextStyle(fontSize: 12))
              ],
            ),
            padding: EdgeInsets.only(right: 10, left: i == 0 ? 5 : 0),
          ),
        );
      }

      for (var item in customProvider.location.daily) {
        dayList.add(Padding(
          padding: EdgeInsets.only(right: 10),
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
      }

      return Scaffold(
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Zaporizhzhia",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(
                      customProvider.location.current.dt * 1000)),
                  style: TextStyle(fontSize: 12),
                ),
              ),
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
                      Text("${customProvider.location.current.temp.round()}°",
                          style: TextStyle(fontSize: 52)),
                      Text('C', style: TextStyle(fontSize: 24))
                    ],
                  ),
                  Row(
                    children: [
                      Text(customProvider.location.current.pressure.toString(),
                          style: TextStyle(fontSize: 14)),
                      Padding(
                        child: Image(
                          height: 14,
                          width: 14,
                          image: AssetImage('assets/barometer.png'),
                        ),
                        padding: EdgeInsets.only(left: 5),
                      )
                    ],
                  )
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            customProvider.location.current.humidity.toString(),
                            style: TextStyle(fontSize: 14)),
                        Padding(
                          child: Image(
                            height: 14,
                            width: 14,
                            image: AssetImage('assets/humidity.png'),
                          ),
                          padding: EdgeInsets.only(left: 5),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Align(
                    child:
                        Text("Hourly forecast", style: TextStyle(fontSize: 20)),
                    alignment: Alignment.centerLeft,
                  )),
              SizedBox(
                  height: 115,
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
                    child:
                        Text("Daily forecast", style: TextStyle(fontSize: 20)),
                    alignment: Alignment.centerLeft,
                  )),
              SizedBox(
                height: 130,
                child: ListView(
                    scrollDirection: Axis.horizontal, children: dayList),
              )
            ],
          ),
        )),
      );
    });
  }
}
