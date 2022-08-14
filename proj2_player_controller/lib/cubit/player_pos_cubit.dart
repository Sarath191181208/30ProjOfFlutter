import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'player_pos_state.dart';

class PlayerPosCubit extends Cubit<PlayerPosState> {
  PlayerPosCubit() : super(PlayerPosInitial());

  double _constrain(double lowerLimit, double val, double upperLimit) {
    return (lowerLimit < val && val < upperLimit)
        ? val
        : (max(lowerLimit, min(val, upperLimit)));
  }

  PlayePosMoving _getPlayerNewPos(double dx, double dy) {
    var currX = state.x;
    var currY = state.y;
    return PlayePosMoving(
      x: _constrain(-1, currX + dx, 1),
      y: _constrain(-1, currY + dy, 1),
    );
  }

  void moveLeft(double step) {
    emit(_getPlayerNewPos(-step, 0.0));
  }

  void moveUp(double step) {
    emit(_getPlayerNewPos(0.0, -step));
  }

  void moveRight(double step) {
    emit(_getPlayerNewPos(step, 0.0));
  }

  void moveDown(double step) {
    emit(_getPlayerNewPos(0.0, step));
  }
}
