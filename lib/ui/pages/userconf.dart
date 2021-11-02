import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/pages/home.dart';
import 'package:flutter_application_1/ui/pages/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:permission_handler/permission_handler.dart';

class UserConfPage extends StatefulWidget {
  const UserConfPage(
      {Key? key, required this.name, required this.id, required this.licensep, required this.rpm})
      : super(key: key);
  final String name;
  final String id;
  final String licensep;
  final int rpm;
  @override
  _UserConfPage createState() => _UserConfPage();
}

class _UserConfPage extends State<UserConfPage> {
  final _formKey = GlobalKey<FormState>();
  String nameee = "";
  late TextEditingController nameTextController;
  late TextEditingController idTextController;
  late TextEditingController lisencepTextController;

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
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _showSecondPage(context);
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
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 60.0),
                  child: Column(
                    children: [
                      TextFormField(
                          // The validator receives the text that the user has entered.
                          decoration: InputDecoration(labelText: "NAME:"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            var licensePlate = value;
                            print(licensePlate);
                            return null;
                          },
                          controller: nameTextController),
                      TextFormField(
                          // The validator receives the text that the user has entered.
                          decoration: InputDecoration(labelText: "ID:"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            var licensePlate = value;
                            print(licensePlate);
                            return null;
                          },
                          controller: idTextController),
                      TextFormField(
                          // The validator receives the text that the user has entered.
                          decoration:
                              InputDecoration(labelText: "LICENSE PLATE:"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            var licensePlate = value;
                            print(licensePlate);
                            return null;
                          },
                          controller: lisencepTextController),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 160.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar || call a server or save the information in a database.

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Updated!')),
                  );
                  //nameee = nameTextController.text;
                  MyHomePage(
                    name: nameTextController.text,
                    id: idTextController.text,
                    licensep: lisencepTextController.text,
                    rpm: widget.rpm,
                  );
                  _showUserPage(context);
                }
              },
              child: const Text('SAVE'),
            ),
          ),
          Text(nameee, textScaleFactor: 2.0),
        ],
      )),
      backgroundColor: Colors.white,
    );
  }

  void _showHomePage(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return MyHomePage(
          name: widget.name, id: widget.id, licensep: widget.licensep, rpm: widget.rpm);
    });
    Navigator.of(context).push(route);
  }

  void _showSecondPage(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return UserPage(
          name: widget.name, id: widget.id, licensep: widget.licensep, rpm: widget.rpm);
    });
    Navigator.of(context).push(route);
  }

  void _showUserPage(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return UserPage(
        name: nameTextController.text,
        id: idTextController.text,
        licensep: lisencepTextController.text,
        rpm: widget.rpm,
      );
    });
    Navigator.of(context).push(route);
  }

  @override
  void initState() {
    super.initState();
    nameTextController = TextEditingController();
    idTextController = TextEditingController();
    lisencepTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameTextController.dispose();
    idTextController.dispose();
    lisencepTextController.dispose();
  }
}
