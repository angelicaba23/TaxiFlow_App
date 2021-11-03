import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/pages/user.dart';
import 'package:geolocator/geolocator.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bluetooth_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key, required this.name, required this.id, required this.licensep, required this.rpm})
      : super(key: key);
  final String name;
  final String id;
  final String licensep;
  final int rpm;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isStopped = false;
  var locationMessage = "";
  var rpmMessage = "";
  var Message = '';
  var msg = {};
  var infoPhone = "";
  var timeStamp = "";
  var stop = false;
  var latitude;
  var longitude;
  var timestamp;
  var licensePlate;
  var rpm;

  String host1 = "taxiflow.ddns.net";
  String host2 = "taxiflow.bounceme.net";
  String host3 = "diericktaxiflow.hopto.org";
  String host4 = "dojuan.hopto.org";
  String host5 = "anelka137.ddns.net";
  String host6 = "angelica.hopto.org";

  bool isSwitched = false;
  @override
  void initState() {
    super.initState();
    initPlaformState();
  }

  Future<void> initPlaformState() async {
    await Permission.locationWhenInUse.request();
    while (await Permission.locationWhenInUse.isDenied) {
      Permission.locationWhenInUse.request();
    }
    findInfo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Taxiflow"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/taxi.png",
          ),
        ),
        //Icon(Icons.home),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              _showSecondPage(context);
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("WELCOME!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 40,
                      color: Color(0xffed5c52))),
              Image.asset(
                "assets/location.gif",
                height: 350,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue,
                        spreadRadius: 3),
                  ],
                ),
                child: Text(rpmMessage,
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 40,
                    color: Color.fromARGB(188,224,251,255)),
              ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(locationMessage),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: CustomSwitch(
                  value: isSwitched,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    print("VALUE : $value");
                    setState(() {
                      isSwitched = value;
                      sendLocation(value);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.bluetooth_connected),
        onPressed: () {_showBluetoothPage(context);},
      ),
    );
  }

  findInfo() async {
    //bool stop = true;
    licensePlate = widget.licensep;
    rpm = widget.rpm;
   Timer.periodic(Duration(seconds: 3), (timer) async {
         if (isStopped) {
           timer.cancel();
         }
        var position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
          latitude = position.latitude.toStringAsFixed(7);
          longitude = position.longitude.toStringAsFixed(7);
          timestamp = position.timestamp.toLocal();
          locationMessage = "Current position: $latitude , $longitude\n"
              "Current Timestamp: $timestamp\n";
          rpmMessage = "$rpm rpm";
          Message = "$latitude$longitude$timestamp$licensePlate$rpm";
          print(Message);
          print(Message);
          print(Message);
          print(Message);
          print(Message);
          print(Message);
        });
      });
    }


  void sendLocation(bool value) async {
    var timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (isSwitched == false) {
        timer.cancel();
      }else{
        if (isSwitched == true) {
          udpSocket(host1);
          udpSocket(host2);
          udpSocket(host3);
          udpSocket(host4);
          udpSocket(host5);
          udpSocket(host6);
        }
      }
    });
  }

  void udpSocket(host) async {
    InternetAddress.lookup(host).then((value) {
      value.forEach((element) async {
        var ip = (element.address);
        RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
            .then((RawDatagramSocket socket) {
          socket.send(Message.codeUnits, InternetAddress(ip), 9000);
          //socket.send(utf8.encode(Message),InternetAddress(ip),9000);
        });
      });
    });
  }

  void _showSecondPage(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return UserPage(
          name: widget.name, id: widget.id, licensep: widget.licensep, rpm: widget.rpm);
    });
    Navigator.of(context).push(route);
  }

  void _showBluetoothPage(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return BluetoothApp(name: widget.name, id: widget.id, licensep: widget.licensep, rpm: widget.rpm);
    });
    Navigator.of(context).push(route);
  }
}