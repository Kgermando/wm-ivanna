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
import 'package:wm_com_ivanna/src/global/api/livraison/table_livraison_api.dart';
import 'package:wm_com_ivanna/src/global/api/livraison/vente_effectuee_livraison_api.dart';
import 'package:wm_com_ivanna/src/global/api/reservation/paiement_reservation_api.dart';
import 'package:wm_com_ivanna/src/global/api/reservation/reservation_api.dart';
import 'package:wm_com_ivanna/src/global/api/restaurant/creance_rest_api.dart';
import 'package:wm_com_ivanna/src/global/api/restaurant/facture_rest_api.dart';
import 'package:wm_com_ivanna/src/global/api/restaurant/restaurant_api.dart';
import 'package:wm_com_ivanna/src/global/api/restaurant/table_restaurant_api.dart';
import 'package:wm_com_ivanna/src/global/api/restaurant/vente_effectuee_rest_api.dart';
import 'package:wm_com_ivanna/src/global/api/rh/personnels_api.dart';
import 'package:wm_com_ivanna/src/global/api/terrasse/creance_terrasse_api.dart';
import 'package:wm_com_ivanna/src/global/api/terrasse/facture_terrasse_api.dart';
import 'package:wm_com_ivanna/src/global/api/terrasse/table_terrasse_api.dart';
import 'package:wm_com_ivanna/src/global/api/terrasse/terrasse_api.dart';
import 'package:wm_com_ivanna/src/global/api/terrasse/vente_effectuee_terrasse_api.dart';
import 'package:wm_com_ivanna/src/global/api/user/user_api.dart';
import 'package:wm_com_ivanna/src/global/api/vip/creance_vip_api.dart';
import 'package:wm_com_ivanna/src/global/api/vip/facture_vip_api.dart';
import 'package:wm_com_ivanna/src/global/api/vip/table_vip_api.dart';
import 'package:wm_com_ivanna/src/global/api/vip/vente_effectuee_vip_api.dart';
import 'package:wm_com_ivanna/src/global/api/vip/vip_api.dart';
import 'package:wm_com_ivanna/src/global/store/commercial/cart_store.dart';
import 'package:wm_com_ivanna/src/global/store/marketing/agenda_store.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_com_ivanna/src/utils/info_system.dart';

class DepartementNotifyCOntroller extends GetxController {
  Timer? timerCommercial;
  final getStorge = GetStorage();
  final ProfilController profilController = Get.put(ProfilController());
  final NetworkController networkController = Get.put(NetworkController());

  // Header
  CartStore cartStore = CartStore();
  // MailsNotifyApi mailsNotifyApi = MailsNotifyApi();
  AgendaStore agendaStore = AgendaStore();

  final UserApi userApi = UserApi();

  final AchatApi achatApi = AchatApi();
  final CartApi cartApi = CartApi();
  final CreanceFactureApi creanceFactureApi = CreanceFactureApi();
  final FactureApi factureApi = FactureApi();
  final GainApi gainApi = GainApi();
  final HistoryRavitaillementApi historyRavitaillementApi = HistoryRavitaillementApi();
  final NumberFactureApi numberFactureApi = NumberFactureApi();
  final ProduitModelApi produitModelApi = ProduitModelApi();
  final SuccursaleApi succursaleApi = SuccursaleApi();
  final VenteCartApi venteCartApi = VenteCartApi();
  final VenteGainApi venteGainApi = VenteGainApi();
  
  final CreanceLivraisonApi creanceLivraisonApi = CreanceLivraisonApi();
  final FactureLivraisonApi factureLivraisonApi = FactureLivraisonApi();
  final LivraisonApi livraisonApi = LivraisonApi();
  final TableLivraisonApi tableLivraisonApi = TableLivraisonApi();
  final VenteEffectueLivraisonApi venteEffectueLivraisonApi = VenteEffectueLivraisonApi();
  final CreanceRestApi creanceRestApi = CreanceRestApi();
  final FactureRestApi factureRestApi = FactureRestApi();
  final RestaurantApi restaurantApi = RestaurantApi();
  final TableRestApi tableRestApi = TableRestApi();
  final VenteEffectueRestApi venteEffectueRestApi = VenteEffectueRestApi();
  final CreanceTerrassApi creanceTerrassApi = CreanceTerrassApi();
  final FactureTerrasseApi factureTerrasseApi = FactureTerrasseApi();
  final TableTerrasseApi tableTerrasseApi = TableTerrasseApi();
  final TerrasseApi terrasseApi = TerrasseApi();
  final VenteEffectueTerrasseApi venteEffectueTerrasseApi = VenteEffectueTerrasseApi();
  final CreanceVipApi creanceVipApi = CreanceVipApi();
  final FactureVipApi factureVipApi = FactureVipApi();
  final TableVipApi tableVipApi = TableVipApi();
  final VenteEffectueVipApi venteEffectueVipApi = VenteEffectueVipApi();
  final VipApi vipApi = VipApi();

  final CaisseNameApi caisseNameApi = CaisseNameApi();
  final CaisseApi caisseApi = CaisseApi();
  final ReservationApi reservationApi = ReservationApi();
  final PaiementReservationApi paiementReservationApi = PaiementReservationApi();
  final PersonnelsApi personnelsApi = PersonnelsApi(); 

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
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        print('Online');
        String? idToken = getStorge.read(InfoSystem.keyIdToken);
        if (idToken != null) {
          // Commercial


          // Restaurant


          // Livraison


          // Vip


          // Terrasse
          


          // Annuaire
          


          // Caisses
          


          // RH & Users

        }
      } else {
        print('No internet :( Reason:');
        // print(InternetConnectionChecker().lastTryResults);
      }
    }
    
  }
}
