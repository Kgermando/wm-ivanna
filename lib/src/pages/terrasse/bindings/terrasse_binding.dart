import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/factures/creance_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/factures/facture_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/prod_model_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/table_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/ventes_effectue_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/terrasse_controller.dart'; 

class TerrasseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProdModelTerrasseController());
    Get.lazyPut(() => TerrasseController());
    Get.lazyPut(() => TableTerrasseController());
    Get.lazyPut(() => CreanceTerrasseController());
    Get.lazyPut(() => FactureTerrasseController());
    Get.lazyPut(() => VenteEffectueTerrasseController());
  }
}
