// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'random_name_generator_state.dart';

class RandomNameGeneratorCubit extends Cubit<RandomNameGeneratorState> {
  List<String> namesList;
  RandomNameGeneratorCubit(
    this.namesList,
  ) : super(RandomNameGeneratorInitial());

  generateRandomName() {
    var randName = _getRandomElement(namesList);
    emit(RandomNameGeneratorGenerated(randName));
  }

  T _getRandomElement<T>(List<T> lst) {
    var rand = Random();
    int idx = rand.nextInt(lst.length);
    return lst[idx];
  }
}
