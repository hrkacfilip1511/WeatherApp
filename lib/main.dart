import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vremenska aplikacija',
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var desc;
  var curr;
  var humidity;
  var windSpeed;
  var name;
  var visibility;
  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=Uzari%C4%87i&units=metric&appid=69dd300c4e194ed498d116f5aee6e7bc'));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.desc = results['weather'][0]['description'];
      this.curr = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.name = results['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    name != null ? name.toString() : "Loading",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0 C" : "Loading",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    curr != null ? curr.toString() : "Loading",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: [
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text("Temperatura"),
                  trailing: Text(
                      temp != null ? temp.toString() + "\u00B0 C" : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text("Vrijeme"),
                  trailing: Text(desc != null ? desc.toString() : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: Text("Vlažnost"),
                  trailing:
                      Text(humidity != null ? humidity.toString() : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text("Brzina vjetra"),
                  trailing: Text(
                      windSpeed != null ? windSpeed.toString() : "Loading"),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
