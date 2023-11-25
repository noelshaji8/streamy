import 'package:aimed_test/screens/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final data;
  final dataLength;

  const Display({super.key, required this.data, required this.dataLength});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemCount: dataLength,
      itemBuilder: (BuildContext context, int value) {
        try {
          return GestureDetector(
            child: Row(children: [
              Container(
                height: screenHeight * 0.2,
                width: screenWidth * 0.4,
                child: Column(
                  children: [
                    Image.network(
                      data[value]["show"]["image"]["original"],
                      height: screenHeight * 0.12,
                    ),
                    Text(data[value]["show"]["name"])
                  ],
                ),
              ),
              Container(
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.4,
                  child: Text(data[value]["show"]["summary"]))
            ]),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Details(
                            data: data,
                            value: value,
                          )));
            },
          );
        } catch (e) {
          return SizedBox(
            width: 0,
          );
        }
      },
      separatorBuilder: (BuildContext context, int value) => const Divider(),
    );
  }
}
