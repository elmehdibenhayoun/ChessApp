import 'package:flutter/material.dart';
import 'package:editable_chess_board/editable_chess_board.dart';
import 'package:chess/chess.dart' as chess;

class ManualPositionScreen extends StatefulWidget {
  const ManualPositionScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ManualPositionScreen> createState() => _ManualPositionScreenState();
}

class _ManualPositionScreenState extends State<ManualPositionScreen> {
  final _controller = PositionController('8/8/8/8/8/8/8/8 w - - 0 1');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  final isEmptyBoard =
                      _controller.currentPosition.split(' ')[0] ==
                          "8/8/8/8/8/8/8/8";
                  final isValidPosition = !isEmptyBoard &&
                      chess.Chess.validate_fen(
                              _controller.currentPosition)['valid'] ==
                          true;
                  final message =
                      isValidPosition ? "Valid position" : "Illegal position !";
                  final snackBar = SnackBar(
                    content: Text(message),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  if (isValidPosition) {
                    Navigator.pushNamed(
                      context,
                      '/chessboard',
                      arguments: _controller.currentPosition,
                    );
                  }
                },
                child: const Text('Ok'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/manual_position');
                },
                child: const Text('Nouveau'),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 700.0,
                    child: EditableChessBoard(
                      boardSize: 350.0,
                      controller: _controller,
                      labels: Labels(
                        playerTurnLabel: 'Player turn :',
                        whitePlayerLabel: 'White',
                        blackPlayerLabel: 'Black',
                        availableCastlesLabel: 'Available castles :',
                        whiteOOLabel: 'White O-O',
                        whiteOOOLabel: 'White O-O-O',
                        blackOOLabel: 'Black O-O',
                        blackOOOLabel: 'Black O-O-O',
                        enPassantLabel: 'En passant square :',
                        drawHalfMovesCountLabel: 'Draw half moves count : ',
                        moveNumberLabel: 'Move number : ',
                        submitFieldLabel: 'Validate field',
                        currentPositionLabel: 'Current position: ',
                        copyFenLabel: 'Copy position',
                        pasteFenLabel: 'Paste position',
                        resetPosition: 'Reset position',
                        standardPosition: 'Standard position',
                        erasePosition: 'Erase position',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
