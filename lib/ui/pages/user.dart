import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/pages/home.dart';
import 'package:flutter_application_1/ui/pages/userconf.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:permission_handler/permission_handler.dart';

class UserPage extends StatefulWidget {
  const UserPage(
      {Key? key, required this.name, required this.id, required this.licensep})
      : super(key: key);
  final String name;
  final String id;
  final String licensep;
  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              _showHomePage(context);
            },
            child: Text("Taxiflow")),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              _showHomePage(context);
            },
            child: Image.asset(
              "assets/taxi.png",
            ),
          ),
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showUserConfPage(context);
            },
          )
        ],
        //Icon(Icons.home),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://www.movilidadbogota.gov.co/web/sites/default/files/Noticias/26-08-2020/jose_castaneda.jpg")))),
          Text(widget.name, textScaleFactor: 2.0),
          Text("ID: " + widget.id, textScaleFactor: 1.5),
          Text("PLACA: " + widget.licensep, textScaleFactor: 1.5),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.network(
                "https://http2.mlstatic.com/D_NQ_NP_764427-MCO43645490226_102020-O.jpg"),
          ),
        ],
      )),
      backgroundColor: Colors.white,
    );
  }

  void _showHomePage(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return MyHomePage(
          name: widget.name, id: widget.id, licensep: widget.licensep);
    });
    Navigator.of(context).push(route);
  }

  void _showUserConfPage(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return UserConfPage(
          name: widget.name, id: widget.id, licensep: widget.licensep);
    });
    Navigator.of(context).push(route);
  }
}
