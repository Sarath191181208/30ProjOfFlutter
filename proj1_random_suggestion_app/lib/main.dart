import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/random_name_generator_cubit.dart';
import 'main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const List<String> namesList = [
    "Marianna Mcintosh",
    "Lamar Mora",
    "Dante Bowen",
    "Melissa Ingram",
    "Lena Richardson",
    "Mitchell Wilkinson",
    "Daniela Bray",
    "Andrew Robertson",
    "Kaylyn Mckenzie",
    "Beckham Small",
    "Vaughn Waller",
    "Ayanna Norman",
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Day 1 Random Name Suggestor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => RandomNameGeneratorCubit(namesList),
        child: const MainPage(),
      ),
    );
  }
}
