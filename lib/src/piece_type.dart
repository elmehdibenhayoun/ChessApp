class PieceType {
  final int shift;
  final String name;
  const PieceType._internal(this.shift, this.name);

  static const PieceType PAWN = PieceType._internal(0, 'p');
  static const PieceType KNIGHT = PieceType._internal(1, 'n');
  static const PieceType BISHOP = PieceType._internal(2, 'b');
  static const PieceType ROOK = PieceType._internal(3, 'r');
  static const PieceType QUEEN = PieceType._internal(4, 'q');
  static const PieceType KING = PieceType._internal(5, 'k');

  @override
  int get hashCode => shift;
  @override
  String toString() => name;
  String toLowerCase() => name;
  String toUpperCase() => name.toUpperCase();
}