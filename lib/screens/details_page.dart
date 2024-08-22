// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../model/exercise_model.dart';

class DetailsPage extends StatefulWidget {
  ExerciseModel? exerciseModel;
  DetailsPage({super.key, this.exerciseModel});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Image.network(
              "${widget.exerciseModel!.image}",
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
