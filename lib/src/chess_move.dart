import 'package:flutter_chess_board/src/chess.dart';
import 'package:flutter_chess_board/src/color.dart';
import 'package:flutter_chess_board/src/piece_type.dart';

class  Move {
  final Color color;
  final int from;
  final int to;
  final int flags;
  final PieceType piece;
  final PieceType? captured;
  final PieceType? promotion;
  final Chess? copy;
  const Move(this.color, this.from, this.to, this.flags, this.piece,
      this.captured, this.promotion, this.copy);

  String get fromAlgebraic {
    return Chess.algebraic(from);
  }

  String get toAlgebraic {
    return Chess.algebraic(to);
  }
}
