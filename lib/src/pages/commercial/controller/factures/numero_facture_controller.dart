import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/global/store/commercial/number_facture_store.dart'; 
import 'package:wm_com_ivanna/src/models/commercial/number_facture.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart';

class NumeroFactureController extends GetxController
    with StateMixin<List<NumberFactureModel>> {
  final NumberFactureStore numberFactureStore = NumberFactureStore();
  final ProfilController profilController = Get.find();

  var numberFactureList = <NumberFactureModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    await numberFactureStore.getAllData().then((response) {
      numberFactureList.clear();
      numberFactureList.addAll(response);
      numberFactureList.refresh();
      change(numberFactureList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await numberFactureStore.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await numberFactureStore.deleteData(id).then((value) {
        numberFactureList.clear();
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
