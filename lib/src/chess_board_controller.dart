import 'package:flutter/material.dart';
import 'package:flutter_chess_board/src/chess.dart';
import 'package:flutter_chess_board/src/chess_move.dart';
import 'package:flutter_chess_board/src/piece_type.dart';
import 'package:flutter_chess_board/src/color.dart';
import 'package:flutter_chess_board/src/state.dart';

import 'constants.dart';

class ChessBoardController extends ValueNotifier<Chess> {
  late Chess game;
  List<ChessGameState> gameHistory = [];
  BoardColor selectedBoardColor = BoardColor.orange;
  int currentIndex = 0;
  List<Move> moveHistory = []; // Votre historique des mouvements

  factory ChessBoardController() => ChessBoardController._(Chess());

  factory ChessBoardController.fromGame(Chess game) =>
      ChessBoardController._(game);

  factory ChessBoardController.fromFEN(String fen) =>
      ChessBoardController._(Chess.fromFEN(fen));

  ChessBoardController._(this.game) : super(game);
  void setBoardColor(BoardColor color) {
    selectedBoardColor = color;
    notifyListeners();
  }

  void makeMove({required String from, required String to}) {
    game.move({"from": from, "to": to});
    print({"from": from, "to": to});
    //moveHistory.add(game.history[currentIndex].move);
    currentIndex++;
    final move = game.history.last.move;
    moveHistory.add(move);
    print(currentIndex);
    print(moveHistory.length - 1);

    notifyListeners();
  }

  void goToPreviousMove() {
    if (currentIndex > 0) {
      currentIndex--;
      final Move move = moveHistory[currentIndex];
      print(move.toAlgebraic);
      print(move.fromAlgebraic);
      print(currentIndex);
      print(moveHistory.length - 1);

      game.undo_move();

      notifyListeners();
    }
  }

  void goToNextMove() {
    if (currentIndex < moveHistory.length) {
      final Move move = moveHistory[currentIndex];
      print(move.toAlgebraic);
      print(move.fromAlgebraic);
      print(currentIndex);
      print(moveHistory.length - 1);

      game.move({"from": move.fromAlgebraic, "to": move.toAlgebraic});
      currentIndex++;

      notifyListeners();
    }
  }

  void makeMoveWithPromotion(
      {required String from,
      required String to,
      required String pieceToPromoteTo}) {
    game.move({"from": from, "to": to, "promotion": pieceToPromoteTo});
    notifyListeners();
  }

  /// Makes move on the board
  void makeMoveWithNormalNotation(String move) {
    game.move(move);
    notifyListeners();
  }

  void undoMove() {
    game.undo_move();
    notifyListeners();
  }

  void resetBoard() {
    game.reset();
    currentIndex = 0;
    moveHistory = [];
    notifyListeners();
  }

  /// Clears board
  void clearBoard() {
    game.clear();
    notifyListeners();
  }

  /// Puts piece on a square
  void putPiece(BoardPieceType piece, String square, PlayerColor color) {
    game.put(_getPiece(piece, color), square);
    notifyListeners();
  }

  /// Loads a PGN
  void loadPGN(String pgn) {
    game.load_pgn(pgn);
    notifyListeners();
  }

  /// Loads a PGN
  void loadFen(String fen) {
    game.load(fen);
    notifyListeners();
  }

  bool isInCheck() {
    return game.in_check;
  }

  bool isCheckMate() {
    return game.in_checkmate;
  }

  bool isDraw() {
    return game.in_draw;
  }

  bool isStaleMate() {
    return game.in_stalemate;
  }

  bool isThreefoldRepetition() {
    return game.in_threefold_repetition;
  }

  bool isInsufficientMaterial() {
    return game.insufficient_material;
  }

  bool isGameOver() {
    return game.game_over;
  }

  String getAscii() {
    return game.ascii;
  }

  String getFen() {
    return game.fen;
  }

  List<String?> getSan() {
    return game.san_moves();
  }

  String moveSan(Move move) {
    return game.move_to_san(move);
  }

  List<Piece?> getBoard() {
    return game.board;
  }

  List<Move> getPossibleMoves() {
    return game.moves({'asObjects': true}) as List<Move>;
  }

  int getMoveCount() {
    return game.move_number;
  }

  int getHalfMoveCount() {
    return game.half_moves;
  }

  /// Gets respective piece
  Piece _getPiece(BoardPieceType piece, PlayerColor color) {
    var convertedColor = color == PlayerColor.white ? Color.WHITE : Color.BLACK;

    switch (piece) {
      case BoardPieceType.Bishop:
        return Piece(PieceType.BISHOP, convertedColor);
      case BoardPieceType.Queen:
        return Piece(PieceType.QUEEN, convertedColor);
      case BoardPieceType.King:
        return Piece(PieceType.KING, convertedColor);
      case BoardPieceType.Knight:
        return Piece(PieceType.KNIGHT, convertedColor);
      case BoardPieceType.Pawn:
        return Piece(PieceType.PAWN, convertedColor);
      case BoardPieceType.Rook:
        return Piece(PieceType.ROOK, convertedColor);
    }
  }

  void goToMovee(int index) {
    if (index >= 0 && index < moveHistory.length) {
      //game.reset();
      //currentIndex = index;
      for (int i = 0; i <= index; i++) {
        game.move(moveHistory[i]);
      }
      notifyListeners();
    }
  }

  String move_to_san(Move move) {
    return game.move_to_san(move);
  }
}
