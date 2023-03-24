import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/global/store/restaurant/facture_restaurant_store.dart';
import 'package:wm_com_ivanna/src/models/restaurant/facture_restaurant_model.dart'; 
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart';

class FactureRestaurantController extends GetxController
    with StateMixin<List<FactureRestaurantModel>> {
  final FactureRestaurantStore factureRestaurantStore = FactureRestaurantStore();
  final ProfilController profilController = Get.find();

  var factureList = <FactureRestaurantModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    getList();
  }
 

  void getList() async {
    await factureRestaurantStore.getAllData().then((response) {
      factureList.clear();
      factureList.addAll(response);
      factureList.refresh();
      change(factureList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await factureRestaurantStore.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await factureRestaurantStore.deleteData(id).then((value) {
        factureList.clear();
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
