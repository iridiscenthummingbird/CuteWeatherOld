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
                // Text(
                //     DateFormat('d MMM').format(
                //         DateTime.fromMillisecondsSinceEpoch(
                //             customProvider.location.hourly[i].dt * 1000)),
                //     style: TextStyle(fontSize: 12))
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
                onPressed: () {})
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                "Zaporizhzhia",
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
        body: Center(
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
                      Text("${customProvider.location.current.temp.round()}°",
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
                              image: AssetImage('assets/barometer.png'),
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
                              image: AssetImage('assets/humidity.png'),
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
                    child:
                        Text("Hourly forecast", style: TextStyle(fontSize: 20)),
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
