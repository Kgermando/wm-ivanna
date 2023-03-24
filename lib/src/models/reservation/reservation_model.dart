class ReservationModel {
  late int? id;
  late String client;
  late String telephone;
  late String email;
  late String adresse;
  late String nbrePersonne;
  late String dureeEvent; // Le temps que va durée cette manifestation
  late DateTime createdDay; // Date du SfCalendar
  late String background; // Effectuer, Interrompu, Non Effectuer
  late String eventName; // type de manifestation
  late String montant;
  late String succursale;
  late String signature; // Celui qui fait le document
  late DateTime created;
  late String business;

  ReservationModel(
      {this.id,
      required this.client,
      required this.telephone,
      required this.email,
      required this.adresse,
      required this.nbrePersonne,
      required this.dureeEvent,
      required this.createdDay,
      required this.background,
      required this.eventName,
      required this.montant,
      required this.succursale,
      required this.signature,
      required this.created,
      required this.business});

  factory ReservationModel.fromSQL(List<dynamic> row) {
    return ReservationModel(
        id: row[0],
        client: row[1],
        telephone: row[2],
        email: row[3],
        adresse: row[4],
        nbrePersonne: row[5],
        dureeEvent: row[6],
        createdDay: row[7],
        background: row[8],
        eventName: row[9],
        montant: row[10],
        succursale: row[11],
        signature: row[12],
        created: row[13],
        business: row[14]);
  }

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
        id: json["id"],
        client: json["client"],
        telephone: json["telephone"],
        email: json["email"],
        adresse: json["adresse"],
        nbrePersonne: json["nbrePersonne"],
        dureeEvent: json["dureeEvent"],
        createdDay: DateTime.parse(json['createdDay']),
        background: json["background"],
        eventName: json["eventName"],
        montant: json['montant'],
        succursale: json['succursale'], 
        signature: json['signature'], 
        created: DateTime.parse(json['created']),
        business: json['business']);
  }

  Map<String, dynamic> toJson({required int id}) {
    return {
      'id': id,
      'client': client,
      'telephone': telephone,
      'email': email,
      'adresse': adresse,
      'nbrePersonne': nbrePersonne,
      'dureeEvent': dureeEvent,
      'createdDay': createdDay.toIso8601String(),
      'background': background,
      'eventName': eventName,
      'montant': montant,
      'succursale': succursale,
      'signature': signature,
      'created': created.toIso8601String(), 
      'business': business
    };
  }
}
