import 'dart:io';

import 'package:aimed_test/screens/home.dart';
import 'package:aimed_test/services/api_req.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aimed_test/services/display.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();

  var data;
  String? searchedName;
  int dataLength = 0;
  int selectedPage = 1;

  @override
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black87,
        height: screenHeight * 0.09,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        indicatorColor: const Color.fromARGB(255, 255, 175, 71),
        selectedIndex: selectedPage,
        onDestinationSelected: (int index) {
          setState(() {
            selectedPage = index;
            if (index == 0) {
              Navigator.pop(context);
            }
          });
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              icon: Icon(Icons.logout))
        ],
        title: Image.asset(
          "images/streamyappbar.png",
          width: 200,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          //CONTAINER

          child: Container(
              height: screenHeight,
              width: screenWidth,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.08,
                          width: screenWidth * 0.8,
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      searchController.clear();
                                      searchedName = "";
                                    });
                                  }),
                              hintText: 'Search by name',
                              hintStyle: TextStyle(color: Colors.black87),
                              filled: true,
                              fillColor: Colors.grey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onChanged: (valueField) {
                              setState(() {
                                searchedName = valueField;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              ApiReq()
                                  .searchValues(searchedName)
                                  .then((value) async {
                                data = await value;
                                dataLength = await value.length;
                              });
                              
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Display(
                    data: data,
                    dataLength: dataLength,
                  ))
                ],
              ))),
    );
  }
}
