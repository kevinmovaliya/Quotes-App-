import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterquote/pages/home_page.dart';
import 'package:random_color/random_color.dart';
import 'package:http/http.dart' as http;

import '../widgets/quote_widget.dart';

drawer({BuildContext context}) {
  PageController controller = PageController();
  RandomColor _randomColor = RandomColor();

  var apiURL = "https://type.fit/api/quotes";

  Future<List<dynamic>> getPost() async {
    final response = await http.get(Uri.parse('$apiURL'));
    return postFromJson(response.body);
  }

  List<dynamic> postFromJson(String str) {
    List<dynamic> jsonData = json.decode(str);
    jsonData.shuffle();
    return jsonData;
  }

  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            alignment: Alignment.center,
            child: Text(
              "Quotes history",
              textAlign: TextAlign.center,
              style: GoogleFonts.amarante(
                fontSize: 26,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            child: FutureBuilder<List<dynamic>>(
              future: getPost(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return ErrorWidget(snapshot.error);
                  }
                  return Stack(
                    children: [
                      PageView.builder(
                          controller: controller,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var model = snapshot.data[index];
                            return QuoteWidget(
                              quote: model["text"].toString(),
                              author: model["author"].toString(),
                              onPrClick: () {},
                              onNextClick: () {
                                controller.nextPage(
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.easeIn);
                              },
                              bgColor: _randomColor.randomColor(
                                colorHue: ColorHue.multiple(
                                  colorHues: [ColorHue.red, ColorHue.blue],
                                ),
                              ),
                            );
                          }),
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (kIsWeb)
                              InkWell(
                                onTap: () {
                                  controller.previousPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeOut);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1, color: Colors.white)),
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.navigate_before,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            if (kIsWeb)
                              InkWell(
                                onTap: () {
                                  controller.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1, color: Colors.white)),
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    ),
  );
}
