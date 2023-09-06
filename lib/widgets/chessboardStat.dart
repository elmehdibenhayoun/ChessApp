import 'package:flutter/material.dart';
import 'package:flutter_chess_board/src/constants.dart';


class ChessboardState extends ChangeNotifier {
  bool _isBoardFlipped = false;

  bool get isBoardFlipped => _isBoardFlipped;
  BoardColor _currentBoardColor = BoardColor.orange;

  BoardColor get currentBoardColor => _currentBoardColor;

  void setBoardColor(BoardColor color) {
    _currentBoardColor = color;
    notifyListeners();
  }

  void toggleBoardOrientation() {
    _isBoardFlipped = !_isBoardFlipped;
    notifyListeners();
  }

 
   
}
