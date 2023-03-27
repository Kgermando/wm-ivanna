import 'package:wm_com_ivanna/src/models/commercial/cart_model.dart';

class FactureCartModel {
  late int? id;
  late List<CartModel> cart;
  late String client; // Numero facture
  late String nomClient;
  late String telephone;
  late String succursale;
  late String signature; // Celui qui fait le document
  late DateTime created;
  late String business;
  late String sync; // new, update, sync
  late String async;

  FactureCartModel(
      {this.id,
      required this.cart,
      required this.client,
      required this.nomClient,
      required this.telephone,
      required this.succursale,
      required this.signature,
      required this.created,
      required this.business,
    required this.sync,
    required this.async,
  });

  factory FactureCartModel.fromSQL(List<dynamic> row) {
    return FactureCartModel(
        id: row[0],
        cart: row[1],
        client: row[2],
        nomClient: row[3],
        telephone: row[4],
        succursale: row[5],
        signature: row[6],
        created: row[7],
        business: row[8],
        sync: row[9],
        async: row[10]);
  }

  factory FactureCartModel.fromJson(Map<String, dynamic> json) {
    return FactureCartModel(
        id: json['id'],
        cart: json['cart']
            .map((mapping) => CartModel.fromJson(mapping))
            .toList()
            .cast<CartModel>(),
        client: json['client'],
        nomClient: json['nomClient'],
        telephone: json['telephone'],
        succursale: json['succursale'],
        signature: json['signature'],
        created: DateTime.parse(json['created']),
        business: json['business'],
      sync: json['sync'],
      async: json['async'],
    );
  }
 
  Map<String, dynamic> toJson({required int id}) {
    return {
      'id': id,
      'cart': cart.map((item) => item.toJson(id: id)).toList(growable: false),
      'client': client,
      'nomClient': nomClient,
      'telephone': telephone,
      'succursale': succursale,
      'signature': signature,
      'created': created.toIso8601String(),
      'business': business,
      'sync': sync,
      'async': async,
    };
  }

  
}
