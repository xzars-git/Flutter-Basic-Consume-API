import 'dart:convert';
import 'package:exam/assets/image.dart';
import 'package:exam/screen/detailProfile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class listProfile extends StatefulWidget {
  @override
  State<listProfile> createState() => _listProfileState();
}

class _listProfileState extends State<listProfile> {
  var apiUrl = "https://reqres.in/api/users?per_page=15";
  List? data;

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  @override
  void initState() {
    _getRefreshData();
    super.initState();
  }

  Future<void> _getRefreshData() async {
    this.getJsonData(context);
  }

  Future<String?> getJsonData(BuildContext context) async {
    var response = await http
        .get(Uri.parse(apiUrl), headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : BackButton(),
        title: _isSearching ? _buildSearchField() : Text("Daftar Profile"),
        actions: _buildActions(),
        flexibleSpace: Image(
          image: AssetImage(signUpImage),
          fit: BoxFit.cover,
        ),
      ),
      body: RefreshIndicator(
          onRefresh: _getRefreshData,
          child: Container(
            child: ListView.builder(
                itemCount: data == null ? 0 : data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () {
                              var data1 = data![index]['first_name'];
                              var data2 = data![index]['last_name'];
                              var data3 = data![index]['email'];
                              var data4 = data![index]['avatar'];
                              var data5 = data![index]['id'];
                              Get.to(() => detailProfile(
                                  value: [data1, data2, data3, data4, data5]));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage(data![index]['avatar']),
                                    ),
                                    title: Text(data![index]['first_name'] +
                                        " " +
                                        data![index]['last_name']),
                                    subtitle: Text(data![index]['email']),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Divider(
                                    height: 20,
                                    thickness: 1,
                                    endIndent: 25,
                                    indent: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ));
                }),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFfc938b),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white70),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
