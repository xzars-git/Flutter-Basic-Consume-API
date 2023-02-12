import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../assets/image.dart';

class createUser extends StatefulWidget {
  List? data;
  createUser({Key? key, required this.data}) : super(key: key);

  @override
  State<createUser> createState() => _createUserState(data);
}

class loadingDialogs {
  static Future<void> showLoadingDialogs(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              backgroundColor: Colors.black54,
              children: <Widget>[
                Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please Wait...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ]),
                )
              ],
            ),
          );
        });
  }
}

class _createUserState extends State<createUser> {
  List? data;

  _createUserState(this.data);

  var firstNameCon = TextEditingController();
  var lastNameCon = TextEditingController();
  var emailCon = TextEditingController();
  String postResponse = "";
  String firstNameText = "";
  String lastNameText = "";
  String emailText = "";

  Future<http.Response> createUser(
      String email, String firstName, String lastName) async {
    loadingDialogs.showLoadingDialogs(context, _keyLoader);
    var response = await http.post(
      Uri.parse('https://reqres.in/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'firstName': firstName,
        'lastName': lastName
      }),
    );
    setState(() {
      emailText = email;
      firstNameText = firstName;
      lastNameText = lastName;
      var responseBody = jsonDecode(response.body);
      postResponse = response.statusCode.toString();
      print("akudisni");
      print(responseBody);
    });

    Navigator.of(context).pop(context);
    return response;
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Create Profile"),
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
                  createUser(
                      emailCon.text, firstNameCon.text, lastNameCon.text);
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
              SizedBox(
                height: 30,
              ),
              Text(
                "First Name : " + firstNameText,
                style: TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Last Name : " + lastNameText,
                style: TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email : " + emailText,
                style: TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Status Code : " + postResponse,
                style: TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "The response code of 201 is hence a success status code that indicates that a new resource has been created.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
