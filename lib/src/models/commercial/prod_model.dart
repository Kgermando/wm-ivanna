class ProductModel {
  late int? id;
  late String service;
  late String identifiant;
  late String unite; // Unité
  late String price;
  late String idProduct;
  late String signature; // celui qui fait le document
  late DateTime created;
  late String business;

  ProductModel({
    this.id,
    required this.service,
    required this.identifiant,
    required this.unite,
    required this.price, 
    required this.idProduct,
    required this.signature,
    required this.created,
    required this.business,
  });

  factory ProductModel.fromSQL(List<dynamic> row) {
    return ProductModel(
        id: row[0],
        service: row[1],
        identifiant: row[2],
        unite: row[3],
        price: row[4],
        idProduct: row[5],
        signature: row[6],
        created: row[7],
        business: row[8]
      );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      service: json['service'],
      identifiant: json['identifiant'],
      unite: json['unite'],
      price: json['price'], 
      idProduct: json['idProduct'],
      signature: json['signature'],
      created: DateTime.parse(json['created']),
      business: json['business'],
    );
  }

  Map<String, dynamic> toJson({required int id}) {
    return {
      'id': id,
      'service': service,
      'identifiant': identifiant,
      'unite': unite,
      'price': price, 
      'idProduct': idProduct,
      'signature': signature,
      'created': created.toIso8601String(),
      'business': business
    };
  }
}
