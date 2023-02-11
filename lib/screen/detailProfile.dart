import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../assets/image.dart';

class detailProfile extends StatefulWidget {
  List? value;

  detailProfile({Key? key, required this.value}) : super(key: key);

  @override
  State<detailProfile> createState() => _detailProfileState(value);
}

class _detailProfileState extends State<detailProfile> {
  List? value;
  _detailProfileState(this.value);
  bool isEdit = false;
  bool isEdited = false;
  List? data;

  static late var firstNameCon = TextEditingController();
  static late var lastNameCon = TextEditingController();
  static late var emailCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    if (isEdited == false) {
      firstNameCon.text = value![0];
      lastNameCon.text = value![1];
      emailCon.text = value![2];
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Detail Profile"),
        actions: _buildActions(),
        flexibleSpace: Image(
          image: AssetImage(signUpImage),
          fit: BoxFit.cover,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 105,
                backgroundImage: NetworkImage(value![3]),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2))
                    ]),
                child: TextField(
                  keyboardType: TextInputType.name,
                  enabled: isEdit ? true : false,
                  controller: firstNameCon,
                  decoration: InputDecoration(
                      hintText: "Your first name",
                      prefixIcon: Icon(
                        Icons.person_pin,
                        color: Colors.deepOrangeAccent,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2))
                    ]),
                child: TextField(
                  keyboardType: TextInputType.name,
                  enabled: isEdit ? true : false,
                  controller: lastNameCon,
                  decoration: InputDecoration(
                      hintText: "Your last name",
                      prefixIcon: Icon(
                        Icons.person_pin,
                        color: Colors.deepOrangeAccent,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2))
                    ]),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  enabled: isEdit ? true : false,
                  controller: emailCon,
                  decoration: InputDecoration(
                      hintText: "Your email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.deepOrangeAccent,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  if (isEdit) {
                    showAlertDialog(context);
                  }
                },
                child: Container(
                  width: w * 0.5,
                  height: h * 0.08,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          image: AssetImage(loginButton), fit: BoxFit.cover)),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActions() {
    if (isEdit) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              isEdit = false;
            });
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          setState(() {
            isEdit = true;
          });
        },
      ),
    ];
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirm"),
      onPressed: () {
        setState(() {
          isEdit = false;
          isEdited = true;
          updateProfile(value![4].toString(), firstNameCon.text,
              lastNameCon.text, emailCon.text);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Are you sure to save changes ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<String?> updateProfile(
      String id, String firstName, String lastName, String email) async {
    final response = await http.put(
      Uri.parse('https://reqres.in/api/users/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
      }),
    );
    print("responnya :" + response.statusCode.toString());

    if (response.statusCode.toString() == "200") {
      setState(() {
        var data = jsonDecode(response.body);
        print(data);
        firstNameCon.clear();
        lastNameCon.clear();
        emailCon.clear();
        print("hasil controller: " +
            firstNameCon.text +
            " | " +
            lastNameCon.text +
            " | " +
            emailCon.text);
        firstNameCon.text = data['first_name'];
        lastNameCon.text = data['last_name'];
        emailCon.text = data['email'];
        print("setelah controller: " +
            firstNameCon.text +
            " | " +
            lastNameCon.text +
            " | " +
            emailCon.text);
        Navigator.of(context, rootNavigator: true).pop();

        print("Response" + response.statusCode.toString() + data);
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update album.');
    }
  }

  showUpdateInformationDialog(
      BuildContext context, String apiResponse, List data) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text("Confirm"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Response API $apiResponse"),
      content: Text("$data"),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
