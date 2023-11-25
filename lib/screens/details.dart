import 'dart:io';
import 'package:aimed_test/screens/search.dart';
import 'package:aimed_test/services/api_req.dart';
import 'package:aimed_test/services/display.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Details extends StatefulWidget {
  final data;
  final value;
  const Details({super.key, required this.data, required this.value});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selectedPage = 0;
  var dat;
  int dataLength = 0;

  @override
  void initState() {
    super.initState();

    ApiReq().fetchValues().then((val) async {
      setState(() {
        dat = val;
        dataLength = val.length;
      });
    });
  }

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
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Search()),
              );
            }
          });
        },
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_sharp,
              color: Colors.grey[700],
            )),
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
              icon: Icon(Icons.logout, color: Colors.grey[700]))
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
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: Column(
                children: [
                  Container(
                    height: screenHeight * 0.4,
                    child: Image.network(
                      widget.data[widget.value]["show"]["image"]["original"],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  Text(widget.data[widget.value]["show"]["name"]),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  Container(
                      height: screenHeight * 0.3,
                      width: screenWidth * 0.8,
                      child:
                          Text(widget.data[widget.value]["show"]["summary"])),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.data[widget.value]["show"]["language"]),
                            SizedBox(
                              width: screenWidth * 0.25,
                            ),
                            Text(widget.data[widget.value]["show"]["type"])
                          ]),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
