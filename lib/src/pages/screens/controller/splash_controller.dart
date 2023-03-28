import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wm_com_ivanna/src/controllers/departement_notify_controller.dart';
import 'package:wm_com_ivanna/src/controllers/network_controller.dart';
import 'package:wm_com_ivanna/src/global/api/user/user_api.dart';
import 'package:wm_com_ivanna/src/models/users/user_model.dart';
import 'package:wm_com_ivanna/src/pages/archives/controller/archive_controller.dart';
import 'package:wm_com_ivanna/src/pages/archives/controller/archive_folder_controller.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/change_password_controller.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/forgot_controller.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/login_controller.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/components/factures/pdf_a6/creance_cart_a6_pdf.dart';
import 'package:wm_com_ivanna/src/pages/commercial/components/factures/pdf_a6/facture_cart_a6_pdf.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/achats/achat_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/achats/ravitaillement_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/cart/cart_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/dashboard/dashboard_com_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/factures/facture_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/factures/facture_creance_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/factures/numero_facture_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/gains/gain_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/history/history_ravitaillement_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/history/history_vente_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/produit_model/produit_model_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/vente_effectue/ventes_effectue_controller.dart';
import 'package:wm_com_ivanna/src/pages/finance/controller/caisses/caisse_controller.dart';
import 'package:wm_com_ivanna/src/pages/finance/controller/caisses/caisse_name_controller.dart';
import 'package:wm_com_ivanna/src/pages/finance/controller/caisses/chart_caisse_controller.dart';
import 'package:wm_com_ivanna/src/pages/finance/controller/dashboard/dashboard_finance_controller.dart';
import 'package:wm_com_ivanna/src/pages/home/controller/home_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/dashboard_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/factures/creance_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/factures/facture_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/prod_model_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/table_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/ventes_effectue_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/mailling/controller/mailling_controller.dart';
import 'package:wm_com_ivanna/src/pages/marketing/controller/agenda/agenda_controller.dart';
import 'package:wm_com_ivanna/src/pages/marketing/controller/annuaire/annuaire_controller.dart';
import 'package:wm_com_ivanna/src/pages/reservation/controller/dashboard_reservation_controller.dart';
import 'package:wm_com_ivanna/src/pages/reservation/controller/paiement_reservation_controller.dart';
import 'package:wm_com_ivanna/src/pages/reservation/controller/reservation_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/dashboard_rest_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/factures/creance_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/factures/facture_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/prod_model_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/table_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/ventes_effectue_rest_controller.dart';
import 'package:wm_com_ivanna/src/pages/rh/controller/dashboard_rh_controller.dart';
import 'package:wm_com_ivanna/src/pages/rh/controller/personnels_controller.dart';
import 'package:wm_com_ivanna/src/pages/rh/controller/user_actif_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/dashboard_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/factures/creance_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/factures/facture_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/prod_model_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/table_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/ventes_effectue_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/update/controller/update_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/dashboard_vip_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/factures/creance_vip_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/factures/facture_vip_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/prod_model_vip_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/table_vip_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/ventes_effectue_vip_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/vip_controller.dart';
import 'package:wm_com_ivanna/src/routes/routes.dart';
import 'package:wm_com_ivanna/src/utils/info_system.dart';

class SplashController extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  final UsersController usersController = Get.put(UsersController());
  final HomeController homeController = Get.put(HomeController());

  final getStorge = GetStorage();

  @override
  void onReady() {
    super.onReady();
    // getStorge.erase();

    String? idToken = getStorge.read(InfoSystem.keyIdToken);
    if (idToken != null) {
      if (!GetPlatform.isWeb) {
        Get.lazyPut(() => NetworkController());
      }
      Get.lazyPut(() => ProfilController());
      Get.lazyPut(() => HomeController(), fenix: true);
      Get.lazyPut(() => ChangePasswordController());
      Get.lazyPut(() => ForgotPasswordController());

      Get.lazyPut(() => DepartementNotifyCOntroller());

      // Mail
      Get.lazyPut(() => MaillingController());

      // Archive
      Get.lazyPut(() => ArchiveFolderController());
      Get.lazyPut(() => ArchiveController());

      // RH
      Get.put<DashobardRHController>(DashobardRHController());
      Get.put<PersonnelsController>(PersonnelsController());

      // Commercial
      Get.lazyPut(() => DashboardComController());
      Get.lazyPut(() => AchatController());
      Get.lazyPut(() => CartController());
      Get.lazyPut(() => FactureController());
      Get.lazyPut(() => FactureCreanceController());
      Get.lazyPut(() => GainCartController());
      Get.lazyPut(() => HistoryRavitaillementController());
      Get.lazyPut(() => NumeroFactureController());
      Get.lazyPut(() => ProduitModelController());
      Get.lazyPut(() => RavitaillementController());
      Get.lazyPut(() => VenteCartController());
      Get.lazyPut(() => VenteEffectueController());

      // PDF
      Get.lazyPut(() => FactureCartPDFA6());
      Get.lazyPut(() => CreanceCartPDFA6());

      // Reservation
      Get.lazyPut(() => DashboardReservationController());
      Get.lazyPut(() => ReservationController());
      Get.lazyPut(() => PaiementReservationController());

      // Restauration
      Get.lazyPut(() => DashboardRestController());
      Get.lazyPut(() => ProdModelRestaurantController());
      Get.lazyPut(() => RestaurantController());
      Get.lazyPut(() => TableRestaurantController());
      Get.lazyPut(() => CreanceRestaurantController());
      Get.lazyPut(() => FactureRestaurantController());
      Get.lazyPut(() => VenteEffectueRestController());

      // VIP
      Get.lazyPut(() => DashboardVipController());
      Get.lazyPut(() => ProdModelVipController());
      Get.lazyPut(() => VipController());
      Get.lazyPut(() => TableVipController());
      Get.lazyPut(() => CreanceVipController());
      Get.lazyPut(() => FactureVipController());
      Get.lazyPut(() => VenteEffectueVipController());

      // Terrasse
      Get.lazyPut(() => DashboardTerrasseController());
      Get.lazyPut(() => ProdModelTerrasseController());
      Get.lazyPut(() => TerrasseController());
      Get.lazyPut(() => TableTerrasseController());
      Get.lazyPut(() => CreanceTerrasseController());
      Get.lazyPut(() => FactureTerrasseController());
      Get.lazyPut(() => VenteEffectueTerrasseController());

      // Livraison
      Get.lazyPut(() => DashboardLivraisonController());
      Get.lazyPut(() => ProdModelLivraisonController());
      Get.lazyPut(() => LivraisonController());
      Get.lazyPut(() => TableLivraisonController());
      Get.lazyPut(() => CreanceLivraisonController());
      Get.lazyPut(() => FactureLivraisonController());
      Get.lazyPut(() => VenteEffectueLivraisonController());

      // FInance
      Get.lazyPut(() => DashboardFinanceController());
      Get.lazyPut(() => ChartCaisseController());
      Get.lazyPut(() => CaisseNameController());
      Get.lazyPut(() => CaisseController());

      // Marketing
      Get.lazyPut(() => AgendaController());
      Get.lazyPut(() => AnnuaireController());

      // Update Version
      if (GetPlatform.isWindows) {
        final NetworkController networkController =
            Get.put(NetworkController());
        if (networkController.connectionStatus == 1) {
          Get.lazyPut(() => UpdateController());
        }
      }

      isLoggIn();
    } else {
      Get.offAllNamed(UserRoutes.login);
    }
  }

  void isLoggIn() async {
    final UserApi userApi = UserApi();
    final UsersController usersController = Get.put(UsersController());
    if (usersController.usersList.isEmpty) {
      if (!GetPlatform.isWeb) {
        bool result = await InternetConnectionChecker().hasConnection;
        if (result == true) {
          var users = await userApi.getAllData();
          var userList =
              users.where((element) => element.async == 'async').toList();
          if (userList.isNotEmpty) {
            for (var element in userList) {
              for (var e in usersController.usersList) {
                if (element.matricule == e.matricule) {
                  break;
                }
                final user = UserModel(
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
                  sync: element.sync,
                  async: 'saved',
                );
                await usersController.usersStore.insertData(user).then((value) {
                  if (kDebugMode) {
                    print("A Sync done");
                  }
                });
              }
            }
          }
        }
      }
      if (GetPlatform.isWeb) {
        var users = await userApi.getAllData();
        var userList =
            users.where((element) => element.async == 'async').toList();
        if (userList.isNotEmpty) {
          for (var element in userList) {
            final user = UserModel(
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
              sync: element.sync,
              async: 'saved',
            );
            await usersController.usersStore.insertData(user);
          }
        }
      }
    }
    await loginController.authStore.getUserId().then((userData) async {
      if (userData.departement == "Commercial") {
        Get.offAndToNamed(HomeRoutes.home);
      }
    });
  }
}
