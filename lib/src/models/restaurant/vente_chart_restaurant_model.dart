class VenteChartRestaurantModel {
  final String idProductCart;
  final int count;

  VenteChartRestaurantModel({required this.idProductCart, required this.count});

  factory VenteChartRestaurantModel.fromSQL(List<dynamic> row) {
    return VenteChartRestaurantModel(idProductCart: row[0], count: row[1]);
  }

  factory VenteChartRestaurantModel.fromJson(Map<String, dynamic> json) {
    return VenteChartRestaurantModel(
        idProductCart: json['idProductCart'], count: json['count']);
  }

  Map<String, dynamic> toJson() {
    return {'idProductCart': idProductCart, 'count': count};
  }
}
