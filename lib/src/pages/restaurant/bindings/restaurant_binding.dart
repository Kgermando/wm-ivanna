import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/factures/creance_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/factures/facture_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/prod_model_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/table_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/ventes_effectue_rest_controller.dart'; 

class RestaurantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProdModelRestaurantController());
    Get.lazyPut(() => RestaurantController());
    Get.lazyPut(() => TableRestaurantController());
    Get.lazyPut(() => CreanceRestaurantController());
    Get.lazyPut(() => FactureRestaurantController());
    Get.lazyPut(() => VenteEffectueRestController());
  }
}
