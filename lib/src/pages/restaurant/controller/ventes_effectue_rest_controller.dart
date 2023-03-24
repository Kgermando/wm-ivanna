import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/global/store/restaurant/vente_effectue_restaurant_store.dart';
import 'package:wm_com_ivanna/src/models/restaurant/vente_restaurant_model.dart';

class VenteEffectueRestController extends GetxController
    with StateMixin<List<VenteRestaurantModel>> {
  final VenteEffectueRestStore venteEffectueRestStore =
      VenteEffectueRestStore();

  var venteEffectueList = <VenteRestaurantModel>[].obs;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  // @override
  // void refresh() {
  //   getList();
  //   super.refresh();
  // }

  void getList() async {
    await venteEffectueRestStore.getAllData().then((response) {
      venteEffectueList.clear();
      venteEffectueList.addAll(response); 
      change(venteEffectueList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await venteEffectueRestStore.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await venteEffectueRestStore.deleteData(id).then((value) {
        getList();
        Get.back();
        Get.snackbar("Supprimé avec succès!", "Cet élément a bien été supprimé",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
