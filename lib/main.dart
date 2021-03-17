import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> hourList = [];
    List<Widget> dayList = [];
    for (var i = 0; i < 24; i++) {
      hourList.add(
        Padding(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("5°", style: TextStyle(fontSize: 20))),
              Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Image(
                    image: AssetImage('assets/sun.png'),
                    width: 30,
                    height: 30,
                  )),
              Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(i < 10 ? '0$i:00' : '$i:00',
                      style: TextStyle(fontSize: 16))),
              Text('19/02', style: TextStyle(fontSize: 12))
            ],
          ),
          padding: EdgeInsets.only(right: 10, left: i == 0 ? 5 : 0),
        ),
      );
    }

    for (var i = 0; i < 8; i++) {
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
                  child: Text("Mon", style: TextStyle(fontSize: 20))),
              Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("Feb 19", style: TextStyle(fontSize: 12))),
              Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Image(
                    image: AssetImage('assets/sun.png'),
                    width: 30,
                    height: 30,
                  )),
              Text("High: +10°C", style: TextStyle(fontSize: 12)),
              Text("Low: +9°C", style: TextStyle(fontSize: 12))
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
                DateFormat.yMd().format(DateTime.now()),
                style: TextStyle(fontSize: 12),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Sun", style: TextStyle(fontSize: 20)),
                Padding(
                  child: Image(
                    image: AssetImage('assets/sun.png'),
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
                    Text("8°", style: TextStyle(fontSize: 52)),
                    Text('C', style: TextStyle(fontSize: 24))
                  ],
                ),
                Row(
                  children: [
                    Text("1005", style: TextStyle(fontSize: 14)),
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
                  Text("feels like 3°C", style: TextStyle(fontSize: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("87", style: TextStyle(fontSize: 14)),
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
                  child: Text("Daily forecast", style: TextStyle(fontSize: 20)),
                  alignment: Alignment.centerLeft,
                )),
            SizedBox(
              height: 130,
              child:
                  ListView(scrollDirection: Axis.horizontal, children: dayList),
            )
          ],
        ),
      )),
    );
  }
}
