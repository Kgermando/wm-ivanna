import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_com_ivanna/src/controllers/departement_notify_controller.dart';
import 'package:wm_com_ivanna/src/global/store/auth/login_store.dart';
import 'package:wm_com_ivanna/src/models/users/user_model.dart'; 
import 'package:wm_com_ivanna/src/pages/archives/controller/archive_controller.dart';
import 'package:wm_com_ivanna/src/pages/archives/controller/archive_folder_controller.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/change_password_controller.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/forgot_controller.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/components/factures/pdf_a6/creance_cart_a6_pdf.dart';
import 'package:wm_com_ivanna/src/pages/commercial/components/factures/pdf_a6/facture_cart_a6_pdf.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/achats/achat_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/achats/ravitaillement_controller.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/cart/cart_controller.dart';
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
import 'package:wm_com_ivanna/src/pages/home/controller/home_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/factures/creance_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/factures/facture_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/prod_model_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/table_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/ventes_effectue_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/mailling/controller/mailling_controller.dart';
import 'package:wm_com_ivanna/src/pages/marketing/controller/agenda/agenda_controller.dart';
import 'package:wm_com_ivanna/src/pages/marketing/controller/annuaire/annuaire_controller.dart';
import 'package:wm_com_ivanna/src/pages/reservation/controller/paiement_reservation_controller.dart';
import 'package:wm_com_ivanna/src/pages/reservation/controller/reservation_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/factures/creance_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/factures/facture_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/prod_model_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/table_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/ventes_effectue_rest_controller.dart';
import 'package:wm_com_ivanna/src/pages/rh/controller/user_actif_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/factures/creance_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/factures/facture_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/prod_model_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/table_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/ventes_effectue_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/factures/creance_vip_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/factures/facture_vip_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/prod_model_vip_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/table_vip_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/ventes_effectue_vip_controller.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/vip_controller.dart'; 
import 'package:wm_com_ivanna/src/routes/routes.dart';
import 'package:wm_com_ivanna/src/utils/info_system.dart';

class LoginController extends GetxController {
  final AuthStore authStore = AuthStore();
  // final UserApi userApi = UserApi();

  GetStorage getStorge = GetStorage();

  final _loadingLogin = false.obs;
  bool get isLoadingLogin => _loadingLogin.value;

  final _loadingLogOut = false.obs;
  bool get loadingLogOut => _loadingLogOut.value;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController matriculeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    matriculeController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void clear() {
    matriculeController.clear();
    passwordController.clear();
  }

  String? validator(String value) {
    if (value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void login() async {
    String? idToken;
    idToken = getStorge.read(InfoSystem.keyIdToken);
    if (kDebugMode) {
      print("login IDUser $idToken");
    }
    
    final UsersController usersController = Get.put(UsersController());
    if(usersController.usersList.isEmpty) {
      final user = UserModel(
      id: 1,
      photo: "",
      nom: "admin",
      prenom: "admin",
      email: "admin@eventdrc.com",
      telephone: "0000000000",
      matricule: "admin",
      departement: "Commercial",
      servicesAffectation: "Support",
      fonctionOccupe: "Support",
      role: "1",
      isOnline: "true",
      createdAt: DateTime.parse("2023-01-05T11:30:06.571153Z"),
      passwordHash: "1234",
      succursale: "-",
      business: "ivanna",
      sync: '-',
      async: '-',
      );
      usersController.usersStore.insertData(user);
      if (kDebugMode) {
        print("login user $user");
      }
    } 
    final form = loginFormKey.currentState!;
    if (form.validate()) {
      try {
        _loadingLogin.value = true;
        await authStore
            .login(matriculeController.text, passwordController.text)
            .then((value) async {
          clear();
          _loadingLogin.value = false;
          if (value) {
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

            // Commercial
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
            Get.lazyPut(() => ReservationController);
            Get.lazyPut(() => PaiementReservationController);

            // Restauration
            Get.lazyPut(() => ProdModelRestaurantController());
            Get.lazyPut(() => RestaurantController());
            Get.lazyPut(() => TableRestaurantController());
            Get.lazyPut(() => CreanceRestaurantController());
            Get.lazyPut(() => FactureRestaurantController());
            Get.lazyPut(() => VenteEffectueRestController());

            // VIP
            Get.lazyPut(() => ProdModelVipController());
            Get.lazyPut(() => VipController());
            Get.lazyPut(() => TableVipController());
            Get.lazyPut(() => CreanceVipController());
            Get.lazyPut(() => FactureVipController());
            Get.lazyPut(() => VenteEffectueVipController());

            // Terrasse
            Get.lazyPut(() => ProdModelTerrasseController());
            Get.lazyPut(() => TerrasseController());
            Get.lazyPut(() => TableTerrasseController());
            Get.lazyPut(() => CreanceTerrasseController());
            Get.lazyPut(() => FactureTerrasseController());
            Get.lazyPut(() => VenteEffectueTerrasseController());

            // Livraison
            Get.lazyPut(() => ProdModelLivraisonController());
            Get.lazyPut(() => LivraisonController());
            Get.lazyPut(() => TableLivraisonController());
            Get.lazyPut(() => CreanceLivraisonController());
            Get.lazyPut(() => FactureLivraisonController());
            Get.lazyPut(() => VenteEffectueLivraisonController());
            

            // FInance
            Get.lazyPut(() => CaisseNameController());
            Get.lazyPut(() => CaisseController());

            // Marketing
            Get.lazyPut(() => AgendaController());
            Get.lazyPut(() => AnnuaireController());

            // Update Version
            // Get.lazyPut(() => UpdateController());

            GetStorage box = GetStorage();
            idToken = box.read(InfoSystem.keyIdToken);

            if (idToken != null) {
              await authStore.getUserId().then((userData) async {
                // box.write('userModel', json.encode(userData));
                // var departement = jsonDecode(userData.departement);
                if (userData.departement == "Commercial") {
                  Get.offAndToNamed(HomeRoutes.home);
                }
                _loadingLogin.value = false;
                Get.snackbar("Authentification réussie",
                    "Bienvenue ${userData.prenom} dans l'interface ${InfoSystem().name()}",
                    backgroundColor: Colors.green,
                    icon: const Icon(Icons.check),
                    snackPosition: SnackPosition.TOP);
              });
            }
          } else {
            _loadingLogin.value = false;
            Get.snackbar("Echec d'authentification",
                "Vérifier votre matricule et mot de passe",
                backgroundColor: Colors.red,
                icon: const Icon(Icons.close),
                snackPosition: SnackPosition.TOP);
          }
        });
      } catch (e) {
        _loadingLogin.value = false;
        Get.snackbar("Erreur lors de la connection", "$e",
            backgroundColor: Colors.red,
            icon: const Icon(Icons.close),
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  Future<void> logout() async {
    try {
      _loadingLogOut.value = true;
      await authStore.logout();
      Get.offAllNamed(UserRoutes.logout);
      Get.snackbar("Déconnexion réussie!", "",
          backgroundColor: Colors.green,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
      _loadingLogOut.value = false;
    } catch (e) {
      _loadingLogOut.value = false;
      Get.snackbar("Erreur lors de la connection", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.close),
          snackPosition: SnackPosition.TOP);
    }
  }
}
