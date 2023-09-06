import 'package:flutter_chess_board/src/chess_move.dart';
import 'package:flutter_chess_board/src/color.dart';
import 'package:flutter_chess_board/src/color_map.dart';

class ChessGameState {
 
  final String fen;
  final Move move;
  final ColorMap<int> kings;
  final Color turn;
  final ColorMap<int> castling;
  final int? ep_square;
  final int half_moves;
  final int move_number;
  const ChessGameState(this.move, this.kings, this.turn, this.castling,
      this.ep_square, this.half_moves, this.move_number, this.fen );
}
