// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/screens/manual_position_screen.dart';
import 'package:flutter_chess_board/src/chess_board_controller.dart';
import 'package:flutter_chess_board/src/constants.dart';
import 'package:flutter_chess_board/widgets/chessboardStat.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ChessBoardController controller;

  const CustomAppBar({super.key, required this.controller});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final chessboardState = Provider.of<ChessboardState>(context);
    Color mapBoardColorToColor(BoardColor boardColor) {
      switch (boardColor) {
        case BoardColor.brown:
          return Colors.brown;
        case BoardColor.darkBrown:
          return Colors
              .brown.shade900; 
        case BoardColor.green:
          return const Color.fromARGB(255, 76, 160, 175);
        case BoardColor.orange:
          return Colors.orange;
        default:
          return Colors.orange; 
      }
    }

    return AppBar(
      backgroundColor: mapBoardColorToColor(chessboardState.currentBoardColor),
      title: const Text('Chessboard Screen'),
      actions: [
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'Nouvelle partie',
                child: Text('Nouvelle partie'),
              ),
              const PopupMenuItem<String>(
                value: 'Inverser le plateau',
                child: Text('Inverser le plateau'),
              ),
              const PopupMenuItem<String>(
                value: 'Mettre Position',
                child: Text('Mettre Position'),
              ),
            ];
          },
          onSelected: (String value) {
            if (value == 'Mettre Position') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManualPosition()),
              );
            } else if (value == 'Nouvelle partie') {
              controller.resetBoard();
            } else if (value == 'Inverser le plateau') {
              chessboardState.toggleBoardOrientation();
            }
          },
        ),
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'Brown',
                child: Text('Brown'),
              ),
              const PopupMenuItem<String>(
                value: 'darkBrown',
                child: Text('darkBrown'),
              ),
              const PopupMenuItem<String>(
                value: 'green',
                child: Text('green'),
              ),
              const PopupMenuItem<String>(
                value: 'orange',
                child: Text('orange'),
              ),
            ];
          },
          onSelected: (String value) {
            if (value == 'Brown') {
              chessboardState.setBoardColor(BoardColor.brown);
            } else if (value == 'darkBrown') {
              chessboardState.setBoardColor(BoardColor.darkBrown);
            } else if (value == 'green') {
              chessboardState.setBoardColor(BoardColor.green);
            } else if (value == 'orange') {
              chessboardState.setBoardColor(BoardColor.orange);
            }
          },
        ),
      ],
    );
  }
}
