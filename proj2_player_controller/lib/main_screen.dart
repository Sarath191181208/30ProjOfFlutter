import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj2_player_controller/cubit/player_pos_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(
          flex: 3,
          child: GameScreen(),
        ),
        Expanded(child: ButtonTray()),
      ],
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: const Center(child: Player()),
    );
  }
}

class Player extends StatelessWidget {
  const Player({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerPosCubit, PlayerPosState>(
        builder: (context, snapshot) {
      return AnimatedContainer(
        alignment: Alignment(snapshot.x, snapshot.y),
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
        child: Container(
          color: Colors.blue,
          height: 30,
          width: 30,
        ),
      );
    });
  }
}

class ButtonTray extends StatelessWidget {
  static const step = 0.1;
  const ButtonTray({Key? key}) : super(key: key);

  PlayerPosCubit _getPlayer(BuildContext ctx) {
    return BlocProvider.of<PlayerPosCubit>(ctx);
  }

  void _movePlayerLeft(BuildContext ctx) {
    _getPlayer(ctx).moveLeft(step);
  }

  void _movePlayerRight(BuildContext ctx) {
    _getPlayer(ctx).moveRight(step);
  }

  void _movePlayerUp(BuildContext ctx) {
    _getPlayer(ctx).moveUp(step);
  }

  void _movePlayerDown(BuildContext ctx) {
    _getPlayer(ctx).moveDown(step);
  }

  @override
  Widget build(BuildContext context) {
    Widget _leftButton = DirectionButton(
      icon: Icons.keyboard_arrow_left,
      fn: () => _movePlayerLeft(context),
    );
    Widget _upButton = DirectionButton(
      icon: Icons.arrow_upward,
      fn: () => _movePlayerUp(context),
    );
    Widget _bottomButton = DirectionButton(
      icon: Icons.arrow_downward,
      fn: () => _movePlayerDown(context),
    );
    Widget _rightButton = DirectionButton(
      icon: Icons.keyboard_arrow_right,
      fn: () => _movePlayerRight(context),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _leftButton,
        Column(children: [
          _upButton,
          _bottomButton,
        ]),
        _rightButton,
      ],
    );
  }
}

class DirectionButton extends StatelessWidget {
  final IconData icon;
  final Function fn;
  const DirectionButton({Key? key, required this.icon, required this.fn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: IconButton(
            splashColor: Colors.pink, onPressed: () => fn(), icon: Icon(icon)));
  }
}
