import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_com_ivanna/src/controllers/network_controller.dart';
import 'package:wm_com_ivanna/src/global/api/commerciale/achat_api.dart';
import 'package:wm_com_ivanna/src/global/api/commerciale/cart_api.dart';
import 'package:wm_com_ivanna/src/global/api/commerciale/creance_facture_api.dart';
import 'package:wm_com_ivanna/src/global/api/commerciale/facture_api.dart';
import 'package:wm_com_ivanna/src/global/api/commerciale/gain_api.dart';
import 'package:wm_com_ivanna/src/global/api/commerciale/history_rabitaillement_api.dart';
import 'package:wm_com_ivanna/src/global/api/commerciale/number_facture_api.dart';
import 'package:wm_com_ivanna/src/global/api/commerciale/produit_model_api.dart';
import 'package:wm_com_ivanna/src/global/api/commerciale/succursale_api.dart';
import 'package:wm_com_ivanna/src/global/api/commerciale/vente_cart_api.dart';
import 'package:wm_com_ivanna/src/global/api/commerciale/vente_gain_api.dart';
import 'package:wm_com_ivanna/src/global/api/finance/caisse_api.dart';
import 'package:wm_com_ivanna/src/global/api/finance/caisse_name_api.dart';
import 'package:wm_com_ivanna/src/global/api/livraison/creance_livraison_api.dart';
import 'package:wm_com_ivanna/src/global/api/livraison/facture_livraison_api.dart';
import 'package:wm_com_ivanna/src/global/api/livraison/livraison_api.dart';
import 'package:wm_com_ivanna/src/global/api/livraison/prod_model_livraison_api.dart';
import 'package:wm_com_ivanna/src/global/api/livraison/table_livraison_api.dart';
import 'package:wm_com_ivanna/src/global/api/livraison/vente_effectuee_livraison_api.dart';
import 'package:wm_com_ivanna/src/global/api/marketing/agenda_api.dart';
import 'package:wm_com_ivanna/src/global/api/marketing/annuaire_api.dart';
import 'package:wm_com_ivanna/src/global/api/reservation/paiement_reservation_api.dart';
import 'package:wm_com_ivanna/src/global/api/reservation/reservation_api.dart';
import 'package:wm_com_ivanna/src/global/api/restaurant/creance_rest_api.dart';
import 'package:wm_com_ivanna/src/global/api/restaurant/facture_rest_api.dart';
import 'package:wm_com_ivanna/src/global/api/restaurant/prod_model_rest_api.dart';
import 'package:wm_com_ivanna/src/global/api/restaurant/restaurant_api.dart';
import 'package:wm_com_ivanna/src/global/api/restaurant/table_restaurant_api.dart';
import 'package:wm_com_ivanna/src/global/api/restaurant/vente_effectuee_rest_api.dart';
import 'package:wm_com_ivanna/src/global/api/rh/personnels_api.dart';
import 'package:wm_com_ivanna/src/global/api/terrasse/creance_terrasse_api.dart';
import 'package:wm_com_ivanna/src/global/api/terrasse/facture_terrasse_api.dart';
import 'package:wm_com_ivanna/src/global/api/terrasse/prod_model_terrasse_api.dart';
import 'package:wm_com_ivanna/src/global/api/terrasse/table_terrasse_api.dart';
import 'package:wm_com_ivanna/src/global/api/terrasse/terrasse_api.dart';
import 'package:wm_com_ivanna/src/global/api/terrasse/vente_effectuee_terrasse_api.dart';
import 'package:wm_com_ivanna/src/global/api/user/user_api.dart';
import 'package:wm_com_ivanna/src/global/api/vip/creance_vip_api.dart';
import 'package:wm_com_ivanna/src/global/api/vip/facture_vip_api.dart';
import 'package:wm_com_ivanna/src/global/api/vip/prod_model_vip_api.dart';
import 'package:wm_com_ivanna/src/global/api/vip/table_vip_api.dart';
import 'package:wm_com_ivanna/src/global/api/vip/vente_effectuee_vip_api.dart';
import 'package:wm_com_ivanna/src/global/api/vip/vip_api.dart';
import 'package:wm_com_ivanna/src/global/store/commercial/cart_store.dart';
import 'package:wm_com_ivanna/src/global/store/finance/caisse_name_store.dart';
import 'package:wm_com_ivanna/src/global/store/finance/caisse_store.dart';
import 'package:wm_com_ivanna/src/global/store/livraison/creance_livraison_store.dart';
import 'package:wm_com_ivanna/src/global/store/livraison/facture_livraison_store.dart';
import 'package:wm_com_ivanna/src/global/store/livraison/prod_model_livraison_store.dart';
import 'package:wm_com_ivanna/src/global/store/livraison/vente_effectue_livraison_store.dart';
import 'package:wm_com_ivanna/src/global/store/marketing/agenda_store.dart';
import 'package:wm_com_ivanna/src/global/store/marketing/annuaire_store.dart';
import 'package:wm_com_ivanna/src/global/store/restaurant/creance_restaurant_store.dart';
import 'package:wm_com_ivanna/src/global/store/restaurant/facture_restaurant_store.dart';
import 'package:wm_com_ivanna/src/global/store/restaurant/prod_model_rest_store.dart';
import 'package:wm_com_ivanna/src/global/store/restaurant/vente_effectue_restaurant_store.dart';
import 'package:wm_com_ivanna/src/global/store/rh/personnel_store.dart';
import 'package:wm_com_ivanna/src/global/store/rh/users_store.dart';
import 'package:wm_com_ivanna/src/global/store/terrasse/creance_terrasse_store.dart';
import 'package:wm_com_ivanna/src/global/store/terrasse/facture_terrasse_store.dart';
import 'package:wm_com_ivanna/src/global/store/terrasse/prod_model_terrasse_store.dart';
import 'package:wm_com_ivanna/src/global/store/terrasse/terrasse_store.dart';
import 'package:wm_com_ivanna/src/global/store/terrasse/vente_effectue_terrasse_store.dart';
import 'package:wm_com_ivanna/src/global/store/vip/creance_vip_store.dart';
import 'package:wm_com_ivanna/src/global/store/vip/facture_vip_store.dart';
import 'package:wm_com_ivanna/src/global/store/vip/prod_model_vip_store.dart';
import 'package:wm_com_ivanna/src/global/store/vip/vente_effectue_vip_store.dart';
import 'package:wm_com_ivanna/src/models/commercial/prod_model.dart';
import 'package:wm_com_ivanna/src/models/finance/caisse_model.dart';
import 'package:wm_com_ivanna/src/models/finance/caisse_name_model.dart';
import 'package:wm_com_ivanna/src/models/marketing/agenda_model.dart';
import 'package:wm_com_ivanna/src/models/marketing/annuaire_model.dart';
import 'package:wm_com_ivanna/src/models/restaurant/creance_restaurant_model.dart';
import 'package:wm_com_ivanna/src/models/restaurant/facture_restaurant_model.dart';
import 'package:wm_com_ivanna/src/models/restaurant/vente_restaurant_model.dart';
import 'package:wm_com_ivanna/src/models/rh/agent_model.dart';
import 'package:wm_com_ivanna/src/models/users/user_model.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_com_ivanna/src/utils/info_system.dart';

class DepartementNotifyCOntroller extends GetxController {
  Timer? timerCommercial;
  final getStorge = GetStorage();
  final ProfilController profilController = Get.put(ProfilController());
  final NetworkController networkController = Get.put(NetworkController());

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // Header
  CartStore cartStore = CartStore();
  // MailsNotifyApi mailsNotifyApi = MailsNotifyApi();
  AgendaStore agendaStore = AgendaStore();
  AgendaApi agendaApi = AgendaApi();
  AnnuaireApi annuaireApi = AnnuaireApi();
  AnnuaireStore annuaireStore = AnnuaireStore();

  final PersonnelsApi personnelsApi = PersonnelsApi();
  final PersonnelStore personnelsStore = PersonnelStore();
  final UserApi userApi = UserApi();
  final UsersStore userStore = UsersStore();

  final AchatApi achatApi = AchatApi();
  final CartApi cartApi = CartApi();
  final CreanceFactureApi creanceFactureApi = CreanceFactureApi();
  final FactureApi factureApi = FactureApi();
  final GainApi gainApi = GainApi();
  final HistoryRavitaillementApi historyRavitaillementApi =
      HistoryRavitaillementApi();
  final NumberFactureApi numberFactureApi = NumberFactureApi();
  final ProduitModelApi produitModelApi = ProduitModelApi();
  final SuccursaleApi succursaleApi = SuccursaleApi();
  final VenteCartApi venteCartApi = VenteCartApi();
  final VenteGainApi venteGainApi = VenteGainApi();

  final ProduitModelLivraisonApi produitModelLivraisonApi =
      ProduitModelLivraisonApi();
  final ProdModelLivraisonStore prodModelLivraisonStore =
      ProdModelLivraisonStore();
  final CreanceLivraisonApi creanceLivraisonApi = CreanceLivraisonApi();
  final CreanceLivraisonStore creanceLivraisonStore = CreanceLivraisonStore();
  final FactureLivraisonApi factureLivraisonApi = FactureLivraisonApi();
  final FactureLivraisonStore factureLivraisonStore = FactureLivraisonStore();
  // final LivraisonApi livraisonApi = LivraisonApi();
  // final TableLivraisonApi tableLivraisonApi = TableLivraisonApi();
  final VenteEffectueLivraisonApi venteEffectueLivraisonApi =
      VenteEffectueLivraisonApi();
  final VenteEffectueLivraisonStore venteEffectueLivraisonStore =
      VenteEffectueLivraisonStore();

  final ProduitModelRestApi produitModelRestApi = ProduitModelRestApi();
  final ProdModelRestStore prodModelRestStore = ProdModelRestStore();
  final CreanceRestApi creanceRestApi = CreanceRestApi();
  final CreanceRestaurantStore creanceRestStore = CreanceRestaurantStore();
  final FactureRestApi factureRestApi = FactureRestApi();
  final FactureRestaurantStore factureRestStore = FactureRestaurantStore();
  // final RestaurantApi restaurantApi = RestaurantApi();
  // final TableRestApi tableRestApi = TableRestApi();
  final VenteEffectueRestApi venteEffectueRestApi = VenteEffectueRestApi();
  final VenteEffectueRestStore venteEffectueRestStore =
      VenteEffectueRestStore();

  final ProduitModelTerrasseApi produitModelTerrasseApi =
      ProduitModelTerrasseApi();
  final ProdModelTerrasseStore prodModelTerrasseStore =
      ProdModelTerrasseStore();
  final CreanceTerrassApi creanceTerrasseApi = CreanceTerrassApi();
  final CreanceTerrasseStore creanceTerrasseStore = CreanceTerrasseStore();
  final FactureTerrasseApi factureTerrasseApi = FactureTerrasseApi();
  final FactureTerrasseStore factureTerrasseStore = FactureTerrasseStore();
  // final TableTerrasseApi tableTerrasseApi = TableTerrasseApi();
  // final TerrasseApi terrasseApi = TerrasseApi();
  final VenteEffectueTerrasseApi venteEffectueTerrasseApi =
      VenteEffectueTerrasseApi();
  final VenteEffectueTerrasseStore venteEffectueTerrasseStore =
      VenteEffectueTerrasseStore();

  final ProduitModelVipApi produitModelVipApi = ProduitModelVipApi();
  final ProdModelVipStore prodModelVipStore = ProdModelVipStore();
  final CreanceVipApi creanceVipApi = CreanceVipApi();
  final CreanceVipStore creanceVipStore = CreanceVipStore();
  final FactureVipApi factureVipApi = FactureVipApi();
  final FactureVipStore factureVipStore = FactureVipStore();
  // final TableVipApi tableVipApi = TableVipApi();
  final VenteEffectueVipApi venteEffectueVipApi = VenteEffectueVipApi();
  final VenteEffectueVipStore venteEffectueVipStore = VenteEffectueVipStore();
  // final VipApi vipApi = VipApi();

  final CaisseNameApi caisseNameApi = CaisseNameApi();
  final CaisseNameStore caisseNameStore = CaisseNameStore();
  final CaisseApi caisseApi = CaisseApi();
  final CaisseStore caisseStore = CaisseStore();
  final ReservationApi reservationApi = ReservationApi();
  final PaiementReservationApi paiementReservationApi =
      PaiementReservationApi();

  // Header
  final _cartItemCount = 0.obs;
  int get cartItemCount => _cartItemCount.value;

  final _mailsItemCount = 0.obs;
  int get mailsItemCount => _mailsItemCount.value;

  final _agendaItemCount = 0.obs;
  int get agendaItemCount => _agendaItemCount.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    getDataNotify();
  }

  @override
  void dispose() {
    timerCommercial!.cancel();
    super.dispose();
  }

  void getDataNotify() async {
    String? idToken = getStorge.read(InfoSystem.keyIdToken);
    if (idToken != null) {
      timerCommercial = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (kDebugMode) {
          print("notify Commercial");
        }
        getCountMail();
        getCountAgenda();
        getCountCart();
      });
      // getCountMail();
      // getCountAgenda();
      // getCountCart();
    }
  }

  // Header
  void getCountCart() async {
    int count = await cartStore.getCount(profilController.user.matricule);
    _cartItemCount.value = count;
    update();
  }

  void getCountMail() async {
    // NotifyModel notifySum =
    //     await mailsNotifyApi.getCount(profilController.user.matricule);
    // _mailsItemCount.value = notifySum.count;
    update();
  }

  void getCountAgenda() async {
    int count = await agendaStore.getCount(profilController.user.matricule);
    _agendaItemCount.value = count;
    update();
  }

  void syncData() async {
    if (!GetPlatform.isWeb) {
      _isLoading.value = true;
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        print("hasConnection $result");
        String? idToken = getStorge.read(InfoSystem.keyIdToken);
        if (idToken != null) {
          print("idToken $idToken");

          // Commercial

          // Restaurant
          var prodModelRestLocalList = await prodModelRestStore.getAllData();
          var prodModelRest = prodModelRestLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (prodModelRest.isNotEmpty) {
            for (var element in prodModelRest) {
              final prodModel = ProductModel(
                id: element.id,
                service: element.service,
                identifiant: element.identifiant,
                unite: element.unite,
                price: element.price,
                idProduct: element.idProduct,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: 'async',
              );
              await produitModelRestApi.insertData(prodModel)
                  .then((value) async {
                await prodModelRestStore.updateData(prodModel);
              });
            } 
          }

          var creanceRestLocalList = await creanceRestStore.getAllData();
          var creanceRest = creanceRestLocalList
              .where((element) => element.sync == "new")
              .toList();
          // var creanceRestUpdateList = creanceRestLocalList
          //     .where((element) => element.sync == "update")
          //     .toList();
          if (creanceRest.isNotEmpty) {
            for (var element in creanceRest) {
              final creance = CreanceRestaurantModel(
                id: element.id,
                cart: element.cart,
                client: element.client,
                nomClient: element.nomClient,
                telephone: element.telephone,
                addresse: element.addresse,
                delaiPaiement: element.delaiPaiement,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: "async",
              );
              await creanceRestApi.insertData(creance).then((value) async {
                await creanceRestStore.updateData(creance);
              });
            }
          }
          var factureRestLocalList = await factureRestStore.getAllData();
          var factureRest = factureRestLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (factureRest.isNotEmpty) {
            for (var element in factureRest) {
              final facture = FactureRestaurantModel(
                id: element.id,
                cart: element.cart,
                client: element.client,
                nomClient: element.nomClient,
                telephone: element.telephone,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: 'async',
              );
              await factureRestApi.insertData(facture).then((value) async {
                await factureRestStore.updateData(facture);
              });
            }
          }
          var venteEffectueRestLocalList =
              await venteEffectueRestStore.getAllData();
          var venteEffectueRest = venteEffectueRestLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (venteEffectueRest.isNotEmpty) {
            for (var element in venteEffectueRest) {
              final vente = VenteRestaurantModel(
                id: element.id,
                identifiant: element.identifiant,
                table: element.table,
                priceTotalCart: element.priceTotalCart,
                qty: element.qty,
                price: element.price,
                unite: element.unite,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: 'async',
              );
              await venteEffectueRestApi.insertData(vente).then((value) async {
                await venteEffectueRestStore.updateData(vente);
              });
            }
          }
          // Livraison
          var prodModelLivraisonLocalList = await prodModelLivraisonStore.getAllData();
          var prodModelLivraison = prodModelLivraisonLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (prodModelLivraison.isNotEmpty) {
            for (var element in prodModelLivraison) {
              final prodModel = ProductModel(
                id: element.id,
                service: element.service,
                identifiant: element.identifiant,
                unite: element.unite,
                price: element.price,
                idProduct: element.idProduct,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: 'async',
              );
              await produitModelLivraisonApi
                  .insertData(prodModel)
                  .then((value) async {
                await prodModelLivraisonStore.updateData(prodModel);
              });
            }
          }
          var creanceLivraisonLocalList =
              await creanceLivraisonStore.getAllData();
          var creanceLivraison = creanceLivraisonLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (creanceLivraison.isNotEmpty) {
            for (var element in creanceLivraison) {
              final creance = CreanceRestaurantModel(
                id: element.id,
                cart: element.cart,
                client: element.client,
                nomClient: element.nomClient,
                telephone: element.telephone,
                addresse: element.addresse,
                delaiPaiement: element.delaiPaiement,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: "async",
              );
              await creanceLivraisonApi.insertData(creance).then((value) async {
                await creanceLivraisonStore.updateData(creance);
              });
            }
          }
          var factureLivraisonLocalList =
              await factureLivraisonStore.getAllData();
          var factureLivraison = factureLivraisonLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (factureLivraison.isNotEmpty) {
            for (var element in factureLivraison) {
              final facture = FactureRestaurantModel(
                id: element.id,
                cart: element.cart,
                client: element.client,
                nomClient: element.nomClient,
                telephone: element.telephone,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: 'async',
              );
              await factureLivraisonApi.insertData(facture).then((value) async {
                await factureLivraisonStore.updateData(facture);
              });
            }
          }
          var venteEffectueLivraisonLocalList =
              await venteEffectueLivraisonStore.getAllData();
          var venteEffectueLivraison = venteEffectueLivraisonLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (venteEffectueLivraison.isNotEmpty) {
            for (var element in venteEffectueLivraison) {
              final vente = VenteRestaurantModel(
                id: element.id,
                identifiant: element.identifiant,
                table: element.table,
                priceTotalCart: element.priceTotalCart,
                qty: element.qty,
                price: element.price,
                unite: element.unite,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: 'async',
              );
              await venteEffectueLivraisonApi
                  .insertData(vente)
                  .then((value) async {
                await venteEffectueLivraisonStore.updateData(vente);
              });
            }
          }

          // Terrasse
          var prodModelTerrasseLocalList =
              await prodModelTerrasseStore.getAllData();
          var prodModelTerrasse = prodModelTerrasseLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (prodModelTerrasse.isNotEmpty) {
            for (var element in prodModelTerrasse) {
              final prodModel = ProductModel(
                id: element.id,
                service: element.service,
                identifiant: element.identifiant,
                unite: element.unite,
                price: element.price,
                idProduct: element.idProduct,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: 'async',
              );
              await produitModelTerrasseApi.insertData(prodModel)
                  .then((value) async {
                await prodModelTerrasseStore.updateData(prodModel);
              });
            }
          }
          var creanceTerrasseLocalList =
              await creanceTerrasseStore.getAllData();
          var creanceTerrasse = creanceTerrasseLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (creanceTerrasse.isNotEmpty) {
            for (var element in creanceTerrasse) {
              final creance = CreanceRestaurantModel(
                id: element.id,
                cart: element.cart,
                client: element.client,
                nomClient: element.nomClient,
                telephone: element.telephone,
                addresse: element.addresse,
                delaiPaiement: element.delaiPaiement,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: "async",
              );
              await creanceTerrasseApi.insertData(creance).then((value) async {
                await creanceTerrasseStore.updateData(creance);
              });
            }
          }
          var factureTerrasseLocalList =
              await factureTerrasseStore.getAllData();
          var factureTerrasse = factureTerrasseLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (factureTerrasse.isNotEmpty) {
            for (var element in factureTerrasse) {
              final facture = FactureRestaurantModel(
                id: element.id,
                cart: element.cart,
                client: element.client,
                nomClient: element.nomClient,
                telephone: element.telephone,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: 'async',
              );
              await factureTerrasseApi.insertData(facture).then((value) async {
                await factureTerrasseStore.updateData(facture);
              });
            }
          }
          var venteEffectueTerrasseLocalList =
              await venteEffectueTerrasseStore.getAllData();
          var venteEffectueTerrasse = venteEffectueTerrasseLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (venteEffectueTerrasse.isNotEmpty) {
            for (var element in venteEffectueTerrasse) {
              final vente = VenteRestaurantModel(
                id: element.id,
                identifiant: element.identifiant,
                table: element.table,
                priceTotalCart: element.priceTotalCart,
                qty: element.qty,
                price: element.price,
                unite: element.unite,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: 'async',
              );
              await venteEffectueTerrasseApi
                  .insertData(vente)
                  .then((value) async {
                await venteEffectueTerrasseStore.updateData(vente);
              });
            }
          }

          // Vip
          var prodModelVipLocalList =
              await prodModelVipStore.getAllData();
          var prodModelVip = prodModelVipLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (prodModelVip.isNotEmpty) {
            for (var element in prodModelVip) {
              final prodModel = ProductModel(
                id: element.id,
                service: element.service,
                identifiant: element.identifiant,
                unite: element.unite,
                price: element.price,
                idProduct: element.idProduct,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: 'async',
              );
              await produitModelVipApi
                  .insertData(prodModel)
                  .then((value) async {
                await prodModelVipStore.updateData(prodModel);
              });
            }
          }
          var creanceVipLocalList = await creanceVipStore.getAllData();
          var creanceVip = creanceVipLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (creanceVip.isNotEmpty) {
            for (var element in creanceVip) {
              final creance = CreanceRestaurantModel(
                id: element.id,
                cart: element.cart,
                client: element.client,
                nomClient: element.nomClient,
                telephone: element.telephone,
                addresse: element.addresse,
                delaiPaiement: element.delaiPaiement,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: "async",
              );
              await creanceVipApi.insertData(creance).then((value) async {
                await creanceVipStore.updateData(creance);
              });
            }
          }
          var factureVipLocalList = await factureVipStore.getAllData();
          var factureVip = factureVipLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (factureVip.isNotEmpty) {
            for (var element in factureVip) {
              final facture = FactureRestaurantModel(
                id: element.id,
                cart: element.cart,
                client: element.client,
                nomClient: element.nomClient,
                telephone: element.telephone,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: 'async',
              );
              await factureVipApi.insertData(facture).then((value) async {
                await factureVipStore.updateData(facture);
              });
            }
          }
          var venteEffectueVipLocalList =
              await venteEffectueVipStore.getAllData();
          var venteEffectueVip = venteEffectueVipLocalList
              .where((element) => element.sync == "new")
              .toList();
          if (venteEffectueVip.isNotEmpty) {
            for (var element in venteEffectueVip) {
              final vente = VenteRestaurantModel(
                id: element.id,
                identifiant: element.identifiant,
                table: element.table,
                priceTotalCart: element.priceTotalCart,
                qty: element.qty,
                price: element.price,
                unite: element.unite,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: 'async',
              );
              await venteEffectueVipApi.insertData(vente).then((value) async {
                await venteEffectueVipStore.updateData(vente);
              });
            }
          }

          // Agenda
          var agendaLocalList = await agendaStore.getAllData();
          var agendaList = agendaLocalList
              .where((element) => element.sync == "new")
              .toList();
          var agendaUpdateList = agendaLocalList
              .where((element) => element.sync == "update")
              .toList();
          if (agendaList.isNotEmpty) {
            for (var element in agendaList) {
              final agenda = AgendaModel(
                id: element.id,
                title: element.title,
                description: element.description,
                dateRappel: element.dateRappel,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: "async", // donc deja en local
              );
              await agendaApi.insertData(agenda).then((value) async {
                await agendaStore.updateData(agenda);
              });
            }
          }
          if (agendaUpdateList.isNotEmpty) {
            for (var element in agendaUpdateList) {
              final agenda = AgendaModel(
                id: element.id,
                title: element.title,
                description: element.description,
                dateRappel: element.dateRappel,
                signature: element.signature,
                created: element.created,
                business: element.business,
                sync: 'sync',
                async: "async",
              );
              await agendaApi.updateData(agenda).then((value) async {
                await agendaStore.updateData(agenda);
              });
            }
          }

          // Annuaire
          var annuaireLocalList = await annuaireStore.getAllData();
          var annuaireList = annuaireLocalList
              .where((element) => element.sync == "new")
              .toList();
          var annuaireUpdateList = annuaireLocalList
              .where((element) => element.sync == "update")
              .toList();
          if (annuaireList.isNotEmpty) {
            for (var element in annuaireList) {
              final annuaire = AnnuaireModel(
                id: element.id,
                categorie: element.categorie,
                nomPostnomPrenom: element.nomPostnomPrenom,
                email: element.email,
                mobile1: element.mobile1,
                mobile2: element.mobile2,
                secteurActivite: element.secteurActivite,
                nomEntreprise: element.nomEntreprise,
                grade: element.grade,
                adresseEntreprise: element.adresseEntreprise,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                updateCreated: element.updateCreated,
                sync: 'sync',
                async: "async",
              );
              await annuaireApi.insertData(annuaire).then((value) async {
                await annuaireApi.updateData(annuaire);
              });
            }
          }
          if (annuaireUpdateList.isNotEmpty) {
            for (var element in annuaireUpdateList) {
              final annuaire = AnnuaireModel(
                id: element.id,
                categorie: element.categorie,
                nomPostnomPrenom: element.nomPostnomPrenom,
                email: element.email,
                mobile1: element.mobile1,
                mobile2: element.mobile2,
                secteurActivite: element.secteurActivite,
                nomEntreprise: element.nomEntreprise,
                grade: element.grade,
                adresseEntreprise: element.adresseEntreprise,
                succursale: element.succursale,
                signature: element.signature,
                created: element.created,
                business: element.business,
                updateCreated: element.updateCreated,
                sync: 'sync',
                async: "async",
              );
              await annuaireApi.updateData(annuaire).then((value) async {
                await annuaireApi.updateData(annuaire);
              });
            }
          }
          // RH & Users
          var userLocalList = await userStore.getAllData();
          var userList =
              userLocalList.where((element) => element.sync == "new").toList();
          var userUpdateList = userLocalList
              .where((element) => element.sync == "update")
              .toList();
          if (userList.isNotEmpty) {
            for (var element in userList) {
              final user = UserModel(
                id: element.id,
                photo: element.photo,
                nom: element.nom,
                prenom: element.prenom,
                email: element.email,
                telephone: element.telephone,
                matricule: element.matricule,
                departement: element.departement,
                servicesAffectation: element.servicesAffectation,
                fonctionOccupe: element.fonctionOccupe,
                role: element.role,
                isOnline: element.isOnline,
                createdAt: element.createdAt,
                passwordHash: element.passwordHash,
                succursale: element.succursale,
                business: element.business,
                sync: 'sync',
                async: "async",
              );
              await userApi.insertData(user).then((value) async {
                await userStore.updateData(user);
              });
            }
          }
          if (userUpdateList.isNotEmpty) {
            for (var element in userUpdateList) {
              final user = UserModel(
                id: element.id,
                photo: element.photo,
                nom: element.nom,
                prenom: element.prenom,
                email: element.email,
                telephone: element.telephone,
                matricule: element.matricule,
                departement: element.departement,
                servicesAffectation: element.servicesAffectation,
                fonctionOccupe: element.fonctionOccupe,
                role: element.role,
                isOnline: element.isOnline,
                createdAt: element.createdAt,
                passwordHash: element.passwordHash,
                succursale: element.succursale,
                business: element.business,
                sync: 'sync',
                async: "async",
              );
              await userApi.updateData(user).then((value) async {
                await userStore.updateData(user);
              });
            }
          }

          var personnelLocalList = await personnelsStore.getAllData();
          var personnelList = personnelLocalList
              .where((element) => element.sync == "new")
              .toList();
          var personnelUpdateList = personnelLocalList
              .where((element) => element.sync == "update")
              .toList();
          if (personnelList.isNotEmpty) {
            for (var element in personnelList) {
              final personnel = AgentModel(
                id: element.id,
                nom: element.nom,
                postNom: element.postNom,
                prenom: element.prenom,
                email: element.email,
                telephone: element.telephone,
                adresse: element.adresse,
                sexe: element.sexe,
                role: element.role,
                matricule: element.matricule,
                dateNaissance: element.dateNaissance,
                lieuNaissance: element.lieuNaissance,
                nationalite: element.nationalite,
                typeContrat: element.typeContrat,
                departement: element.departement,
                servicesAffectation: element.servicesAffectation,
                dateDebutContrat: element.dateDebutContrat,
                dateFinContrat: element.dateFinContrat,
                fonctionOccupe: element.fonctionOccupe,
                statutAgent: element.statutAgent,
                createdAt: element.createdAt,
                photo: element.photo,
                salaire: element.salaire,
                signature: element.signature,
                created: element.created,
                isDelete: element.isDelete,
                business: element.business,
                sync: 'sync',
                async: "async",
              );
              await personnelsApi.insertData(personnel).then((value) async {
                await personnelsStore.updateData(personnel);
              });
            }
          }
          if (personnelUpdateList.isNotEmpty) {
            for (var element in personnelUpdateList) {
              final personnel = AgentModel(
                id: element.id,
                nom: element.nom,
                postNom: element.postNom,
                prenom: element.prenom,
                email: element.email,
                telephone: element.telephone,
                adresse: element.adresse,
                sexe: element.sexe,
                role: element.role,
                matricule: element.matricule,
                dateNaissance: element.dateNaissance,
                lieuNaissance: element.lieuNaissance,
                nationalite: element.nationalite,
                typeContrat: element.typeContrat,
                departement: element.departement,
                servicesAffectation: element.servicesAffectation,
                dateDebutContrat: element.dateDebutContrat,
                dateFinContrat: element.dateFinContrat,
                fonctionOccupe: element.fonctionOccupe,
                statutAgent: element.statutAgent,
                createdAt: element.createdAt,
                photo: element.photo,
                salaire: element.salaire,
                signature: element.signature,
                created: element.created,
                isDelete: element.isDelete,
                business: element.business,
                sync: 'sync',
                async: "async",
              );
              await personnelsApi.updateData(personnel).then((value) async {
                await personnelsStore.updateData(personnel);
              });
            }
          }

          // Caisses
          var caisseNameLocalList = await caisseNameStore.getAllData();
          var caisseNameList = caisseNameLocalList
              .where((element) => element.sync == "new")
              .toList();
          var caisseNameUpdateList = caisseNameLocalList
              .where((element) => element.sync == "update")
              .toList();
          if (caisseNameList.isNotEmpty) {
            for (var element in caisseNameList) {
              final caisseName = CaisseNameModel(
                nomComplet: element.nomComplet,
                rccm: element.rccm,
                idNat: element.idNat,
                addresse: element.addresse,
                created: element.created,
                business: element.business,
                sync: "sync",
                async: "async",
              );
              await caisseNameApi.insertData(caisseName).then((value) async {
                await caisseNameStore.updateData(caisseName);
              });
            }
          }
          if (caisseNameUpdateList.isNotEmpty) {
            for (var element in caisseNameUpdateList) {
              final caisseName = CaisseNameModel(
                id: element.id,
                nomComplet: element.nomComplet,
                rccm: element.rccm,
                idNat: element.idNat,
                addresse: element.addresse,
                created: element.created,
                business: element.business,
                sync: "sync",
                async: "async",
              );
              await caisseNameApi.updateData(caisseName).then((value) async {
                await caisseNameStore.updateData(caisseName);
              });
            }
          }

          var caisseLocalList = await caisseStore.getAllData();
          var caisseList = caisseLocalList
              .where((element) => element.sync == "new")
              .toList();
          var caisseUpdateList = caisseLocalList
              .where((element) => element.sync == "update")
              .toList();
          if (caisseList.isNotEmpty) {
            for (var element in caisseList) {
              final caisse = CaisseModel(
                id: element.id,
                nomComplet: element.nomComplet,
                pieceJustificative: element.pieceJustificative,
                libelle: element.libelle,
                montantEncaissement: element.montantEncaissement,
                departement: element.departement,
                typeOperation: element.typeOperation,
                numeroOperation: element.numeroOperation,
                signature: element.signature,
                reference: element.reference,
                caisseName: element.caisseName,
                created: element.created,
                montantDecaissement: element.montantDecaissement,
                business: element.business,
                sync: 'sync',
                async: "async",
              );
              await caisseApi.insertData(caisse).then((value) async {
                await caisseStore.updateData(caisse);
              });
            }
          }
          if (caisseUpdateList.isNotEmpty) {
            // var cloudList = await caisseApi.getAllData();
            for (var element in caisseUpdateList) {
              // cloudList.forEach((e) {});
              final caisse = CaisseModel(
                id: element.id,
                nomComplet: element.nomComplet,
                pieceJustificative: element.pieceJustificative,
                libelle: element.libelle,
                montantEncaissement: element.montantEncaissement,
                departement: element.departement,
                typeOperation: element.typeOperation,
                numeroOperation: element.numeroOperation,
                signature: element.signature,
                reference: element.reference,
                caisseName: element.caisseName,
                created: element.created,
                montantDecaissement: element.montantDecaissement,
                business: element.business,
                sync: 'sync',
                async: "async",
              );
              await caisseApi.updateData(caisse).then((value) async {
                await caisseStore.updateData(caisse);
              });
            }
          }

          _isLoading.value = false;
        }
      } else {
        print('No internet :( Reason:');
        // print(InternetConnectionChecker().lastTryResults);
      }
    }
  }
}
