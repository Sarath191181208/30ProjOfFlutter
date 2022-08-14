// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'player_pos_cubit.dart';

@immutable
abstract class PlayerPosState {
  final double x = 0;
  final double y = 0;
}

class PlayerPosInitial extends PlayerPosState {}

class PlayePosMoving extends PlayerPosState {
  @override
  final double x;
  @override
  final double y;

  PlayePosMoving({
    required this.x,
    required this.y,
  });
}
