import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/factures/creance_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/factures/facture_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/prod_model_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/table_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/ventes_effectue_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/livraison_controller.dart'; 

class LivraisonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProdModelLivraisonController());
    Get.lazyPut(() => LivraisonController());
    Get.lazyPut(() => TableLivraisonController());
    Get.lazyPut(() => CreanceLivraisonController());
    Get.lazyPut(() => FactureLivraisonController());
    Get.lazyPut(() => VenteEffectueLivraisonController());
  }
}
