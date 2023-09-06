import 'package:flutter/material.dart';
import 'package:flutter_chess_board/src/chess_board_controller.dart';
import '../widgets/appBar.dart';
import '../widgets/chessboard_widget.dart';

class ChessboardScreen extends StatelessWidget {
  const ChessboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChessBoardController controller = ChessBoardController();
    final String? fen = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My chess',
        controller: controller,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ChessboardWidget(
            initialFEN: fen,
            controller: controller,
          ),
        ),
      ),
    );
  }
}
