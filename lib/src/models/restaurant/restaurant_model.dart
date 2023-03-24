class RestaurantModel {
  late int? id;
  late String identifiant;
  late String table;
  late String qty;
  late String price;
  late String unite;  
  late String statutCommande; // Commande deja effectuee true / false
  late String succursale;
  late String signature; // Celui qui fait le document
  late DateTime created;
  late String business; 

  RestaurantModel(
      {this.id,
      required this.identifiant,
      required this.table,
      required this.qty,
      required this.price,
      required this.unite,
      required this.statutCommande,
      required this.succursale,
      required this.signature,
      required this.created,
      required this.business});

  factory RestaurantModel.fromSQL(List<dynamic> row) {
    return RestaurantModel(
        id: row[0],
        identifiant: row[1],
        table: row[2],
        qty: row[3],
        price: row[4],
        unite: row[5],
        statutCommande: row[6],
        succursale: row[7],
        signature: row[8],
        created: row[9],
        business: row[10]);
  }

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
        id: json['id'],
        identifiant: json['identifiant'],
        table: json['table'],
        qty: json['qty'],
        price: json['price'],
        unite: json['unite'],
        statutCommande: json['statutCommande'],
        succursale: json['succursale'],
        signature: json['signature'],
        created: DateTime.parse(json['created']),
      business: json['business'],
    );
  }

  Map<String, dynamic> toJson({required int id}) {
    return {
      'id': id,
      'identifiant': identifiant,
      'table': table,
      'qty': qty,
      'price': price,
      'unite': unite,
      'statutCommande': statutCommande,
      'succursale': succursale,
      'signature': signature,
      'created': created.toIso8601String(),
      'business': business,
    };
  } 
}
