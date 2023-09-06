import 'package:flutter/material.dart';
import 'package:flutter_chess_board/src/chess.dart';
import 'package:flutter_chess_board/src/chess_board.dart';
import 'package:flutter_chess_board/src/chess_board_controller.dart';
import 'package:flutter_chess_board/src/constants.dart';
import 'package:flutter_chess_board/src/color.dart';
import 'package:flutter_chess_board/widgets/chessboardStat.dart';
import 'package:provider/provider.dart';

class ChessboardWidget extends StatefulWidget {
  final String? initialFEN;
  final ChessBoardController controller;
  const ChessboardWidget({Key? key, this.initialFEN, required this.controller})
      : super(key: key);

  @override
  ChessboardWidgetState createState() => ChessboardWidgetState();
}

class ChessboardWidgetState extends State<ChessboardWidget> {
  @override
  void initState() {
    super.initState();

    if (widget.initialFEN != null) {
      widget.controller.loadFen(widget.initialFEN!);
    }
  }

  bool isBoardFlipped = false;

  // Fonction pour aller en arrière dans l'historique

  void toggleBoardOrientation() {
    setState(() {
      isBoardFlipped = !isBoardFlipped;
    });
  }

  void undoMove() {
    widget.controller.undoMove();
  }

  void startNewGame() {
    setState(() {
      widget.controller.resetBoard;
    });
  }

  bool turn() {
    if (widget.controller.game.turn == Color.WHITE) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final chessboardState = Provider.of<ChessboardState>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ChessBoard(
                //size: MediaQuery.of(context).size.width,
                controller: widget.controller,
                boardColor: chessboardState.currentBoardColor,
                boardOrientation: chessboardState.isBoardFlipped
                    ? PlayerColor.black
                    : PlayerColor.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ValueListenableBuilder<Chess>(
                  valueListenable: widget.controller,
                  builder: (context, game, _) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Couleur de la bordure
                          width: 1.5, // Largeur de la bordure
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor:
                            turn() == true ? Colors.white : Colors.black,
                        radius: 7,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<Chess>(
                  valueListenable: widget.controller,
                  builder: (context, game, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              widget.controller.goToPreviousMove();
                            }),
                        IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              widget.controller.goToNextMove();
                            }),
                        IconButton(
                            icon: const Icon(Icons.restart_alt_rounded),
                            onPressed: () {
                              widget.controller.resetBoard();
                            }),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          // Expanded(
          //   child: ValueListenableBuilder<Chess>(
          //     valueListenable: controller,
          //     builder: (context, game, _) {
          //       // Arrière-plan blanc par défaut
          //       return Column(
          //         children: [
          //           Text(
          //             controller.getSan().fold(
          //                   '',
          //                   (previousValue, element) =>
          //                       previousValue + element! + '',
          //                 ),
          //           ),
          //         ],
          //       );
          //     },
          //   ),
          // )
          Expanded(
            child: ValueListenableBuilder<Chess>(
              valueListenable: widget.controller,
              builder: (context, game, _) {
                final List<String?> sanMoves = widget.controller.getSan();
                return ListView.builder(
                  itemCount: sanMoves.length,
                  itemBuilder: (context, index) {
                    final String? move = sanMoves[index];
                    return TextButton(
                      onPressed: () {
                        widget.controller.goToMovee(index);
                      },
                      child: Text('$move'),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
