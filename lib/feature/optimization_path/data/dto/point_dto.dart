class PointDto {
  final int x;
  final int y;

  const PointDto(
    this.x,
    this.y,
  );

  factory PointDto.fromJson(Map<String, dynamic> json) {
    return PointDto(
      json['x'],
      json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }
}
