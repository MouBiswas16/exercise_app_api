// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/exercise_model.dart';
import 'details_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ExerciseModel? exerciseModel;
  List<ExerciseModel> myFitnessList = [];

  var fitnessUrl =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2gsu4SRvRRFkHK8JPTWHZXmaNP0dtpOG6h7ep4zQp7WaamX5S1UaSrc3A;";

  fetchFitnessData() async {
    var response = await http.get(Uri.parse(fitnessUrl));
    var data = jsonDecode(response.body);
    // print("Our data is ${data}");

    for (var i in data["exercises"]) {
      exerciseModel = ExerciseModel(
        title: i["title"],
        seconds: i["seconds"],
        image: i["thumbnail"],
        gif: i["gif"],
      );
      myFitnessList.add(exerciseModel!);
    }

    setState(() {});
  }

  @override
  void initState() {
    fetchFitnessData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF759E9E),
        title: Text(
          "Exercise App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SizedBox(
          width: double.infinity,
          child: ListView.builder(
            itemCount: myFitnessList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                                exerciseModel: myFitnessList[index],
                              )));
                },
                child: Container(
                  height: 150,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "${myFitnessList[index].image}",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        bottom: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${myFitnessList[index].title}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Time needed : ${myFitnessList[index].seconds} seconds",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
