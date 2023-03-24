import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/pages/finance/controller/caisses/caisse_controller.dart';
import 'package:wm_com_ivanna/src/pages/finance/controller/caisses/caisse_name_controller.dart';

class CaisseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CaisseNameController());
    Get.lazyPut(() => CaisseController());
  }
}
