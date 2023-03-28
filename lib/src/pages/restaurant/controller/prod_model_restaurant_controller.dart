import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wm_com_ivanna/src/global/api/restaurant/prod_model_rest_api.dart';
import 'package:wm_com_ivanna/src/global/store/restaurant/prod_model_rest_store.dart';
import 'package:wm_com_ivanna/src/models/commercial/prod_model.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_com_ivanna/src/utils/info_system.dart';

class ProdModelRestaurantController extends GetxController
    with StateMixin<List<ProductModel>> {
  final ProdModelRestStore produitModelStore = ProdModelRestStore();
  final ProduitModelRestApi produitModelRestApi = ProduitModelRestApi();
  final ProfilController profilController = Get.find();

  var produitModelList = <ProductModel>[].obs;

  var venteFilterQtyList = <ProductModel>[].obs;

  final Rx<List<ProductModel>> _venteList = Rx<List<ProductModel>>([]);
  List<ProductModel> get venteList => _venteList.value; // For filter

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController identifiantController = TextEditingController();
  TextEditingController uniteController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  TextEditingController filterController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
    onSearchText('');
  }

  // @override
  // void refresh() {
  //   getList();
  //   super.refresh();
  // }

  @override
  void dispose() {
    filterController.dispose();
    identifiantController.dispose();
    uniteController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void clear() {
    identifiantController.clear();
    uniteController.clear();
    priceController.clear();
  }

  void getList() async {
    await produitModelStore.getAllData().then((response) {
      produitModelList.clear();
      venteFilterQtyList.clear();
      produitModelList.addAll(response);
      venteFilterQtyList.addAll(response);
      change(produitModelList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void onSearchText(String text) async {
    List<ProductModel> results = [];
    if (text.isEmpty) {
      results = venteFilterQtyList;
    } else {
      results = venteFilterQtyList
          .where((element) => element.identifiant
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    }
    _venteList.value = results;
  }

  detailView(int id) async {
    _isLoading.value = true;
    final data = await produitModelStore.getOneData(id);
    _isLoading.value = false;
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await produitModelStore.deleteData(id).then((value) {
        clear();
        produitModelList.clear();
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

  void submit() async {
    try {
      _isLoading.value = true;
      final idProductform =
          "${identifiantController.text.trim()}-${uniteController.text.trim()}";
      final dataItem = ProductModel(
          service: 'Restaurant',
          identifiant: (identifiantController.text == "")
              ? '-'
              : identifiantController.text.trim(),
          unite:
              (uniteController.text == "") ? '-' : uniteController.text.trim(),
          price:
              (priceController.text == "") ? '0' : priceController.text.trim(),
          idProduct: idProductform.replaceAll(' ', '').toUpperCase(),
          signature: profilController.user.matricule,
          created: DateTime.now(),
          business: InfoSystem().business(),
          sync: "new",
          async: "new");
      await produitModelStore.insertData(dataItem).then((value) {
        clear();
        produitModelList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été sauvegadé",
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

  void submitUpdate(ProductModel data) async {
    try {
      _isLoading.value = true;
      final idProductform =
          "${identifiantController.text.trim()}-${uniteController.text.trim()}";
      final dataItem = ProductModel(
          id: data.id,
          service: data.service,
          identifiant: (identifiantController.text == "")
              ? data.identifiant
              : identifiantController.text.trim(),
          unite: (uniteController.text == "")
              ? data.unite
              : uniteController.text.trim(),
          price: (priceController.text == "")
              ? data.price
              : priceController.text.trim(),
          idProduct: idProductform.replaceAll(' ', '').toUpperCase(),
          signature: profilController.user.matricule,
          created: data.created,
          business: data.business,
          sync: "update",
          async: "new");
      await produitModelStore.updateData(dataItem).then((value) {
        clear();
        produitModelList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été sauvegadé",
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

  Future<void> syncData() async {
    if (!GetPlatform.isWeb) {
      _isLoading.value = true;
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        var prodModelList = await produitModelRestApi.getAllData();
        var dataList =
            prodModelList.where((element) => element.async == "async").toList();
        if (dataList.isNotEmpty) {
          for (var element in dataList) {
            final prodModel = ProductModel(
              id: element.id,
              service: element.service,
              identifiant: element.identifiant,
              unite: element.unite,
              price: element.price,
              idProduct: element.idProduct,
              signature: element.signature,
              created: element.created,
              business: element.business,
              sync: element.sync,
              async: 'saved',
            );
            await produitModelStore.insertData(prodModel).then((value) async {
              await produitModelRestApi.updateData(prodModel);
            });
          }
        }
      }
    }
  }
}
