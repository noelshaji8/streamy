import 'dart:io';
import 'package:aimed_test/screens/search.dart';
import 'package:aimed_test/services/api_req.dart';
import 'package:aimed_test/services/display.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedPage = 0;
  var data;
  int dataLength = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      ApiReq().fetchValues().then((value) async {
        setState(() {
          data = value;
          dataLength = value.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
      body: SingleChildScrollView(
        //CONTAINER
        child: Container(
            height: screenHeight,
            width: screenWidth,
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: Display(data: data, dataLength: dataLength),
              
              
              // ListView.separated(
              //   padding: const EdgeInsets.all(0),
              //   itemCount: dataLength,
              //   itemBuilder: (BuildContext context, int value) {
              //     try {
              //       return Row(children: [
              //         Container(
              //           height: screenHeight * 0.2,
              //           width: screenWidth * 0.4,
              //           child: Column(
              //             children: [
              //               Image.network(
              //                 data[value]["show"]["image"]["original"],
              //                 height: screenHeight * 0.15,
              //               ),
              //               Text(data[value]["show"]["name"])
              //             ],
              //           ),
              //         ),
              //         Container(
              //             height: screenHeight * 0.2,
              //             width: screenWidth * 0.4,
              //             child: Text(data[value]["show"]["summary"]))
              //       ]);
              //     } catch (e) {
              //       return SizedBox(
              //         width: 0,
              //       );
              //     }
              //   },
              //   separatorBuilder: (BuildContext context, int value) =>
              //       const Divider(),
              // ),
            )),
      ),
    );
  }
}
