// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'random_name_generator_cubit.dart';

@immutable
abstract class RandomNameGeneratorState {}

class RandomNameGeneratorInitial extends RandomNameGeneratorState {}

class RandomNameGeneratorGenerated extends RandomNameGeneratorState {
  final String name;

  RandomNameGeneratorGenerated(this.name);
}
