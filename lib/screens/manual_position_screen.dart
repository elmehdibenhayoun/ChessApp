import 'package:flutter/material.dart';
import 'package:flutter_chess_board/src/chess_board_controller.dart';

import '../widgets/appBar.dart';
import '../widgets/manual_position_widget.dart';

class ManualPosition extends StatelessWidget {
  final bool? isValidPosition;
  const ManualPosition({super.key, this.isValidPosition});

  @override
  Widget build(BuildContext context) {
    ChessBoardController controller = ChessBoardController();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Position',
        controller: controller,
      ),
      body: const SizedBox(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Center(
            child: ManualPositionScreen(title: "Manual position"),
          ),
        ),
      ),
    );
  }
}
