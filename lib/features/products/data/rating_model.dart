class RatingModel {
  final dynamic rate;
  final int count;
  const RatingModel({
    required this.count,
    required this.rate,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      count: json['count'],
      rate: json['rate'],
    );
  }
}
