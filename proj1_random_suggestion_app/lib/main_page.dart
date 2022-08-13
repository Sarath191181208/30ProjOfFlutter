import 'package:day1_random_suggestion_app/components/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/random_name_generator_cubit.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(child: RandomSuggestionText()),
          SizedBox(height: 30.0),
          GenerateRandomSuggestionButton(),
        ],
      ),
    );
  }
}

class GenerateRandomSuggestionButton extends StatelessWidget {
  const GenerateRandomSuggestionButton({Key? key}) : super(key: key);

  generateRandomName(BuildContext ctx) {
    final randNameCubit = BlocProvider.of<RandomNameGeneratorCubit>(ctx);
    randNameCubit.generateRandomName();
  }

  @override
  Widget build(BuildContext context) {
    return (GradientButton(
      txt: "Get Random Name",
      fn: () => generateRandomName(context),
    ));
  }
}

class RandomSuggestionText extends StatelessWidget {
  const RandomSuggestionText({Key? key}) : super(key: key);

  Widget _getNameAsText(String name) {
    return Text(
      name,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (BlocBuilder<RandomNameGeneratorCubit, RandomNameGeneratorState>(
      builder: (context, state) {
        if (state is RandomNameGeneratorGenerated) {
          return _getNameAsText(state.name);
        }
        return _getNameAsText(" ");
      },
    ));
  }
}
