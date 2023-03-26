import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wm_com_ivanna/src/global/api/rh/personnels_api.dart';

class DashobardRHController extends GetxController {
  final PersonnelsApi personnelsApi = PersonnelsApi();

  final _totalEnveloppeSalaire = 0.0.obs;
  double get totalEnveloppeSalaire => _totalEnveloppeSalaire.value;

  final _agentsCount = 0.obs;
  int get agentsCount => _agentsCount.value;

  final _agentActifCount = 0.obs;
  int get agentActifCount => _agentActifCount.value;

  final _agentInactifCount = 0.obs;
  int get agentInactifCount => _agentInactifCount.value;

  final _agentFemmeCount = 0.obs;
  int get agentFemmeCount => _agentFemmeCount.value;

  final _agentHommeCount = 0.obs;
  int get agentHommeCount => _agentHommeCount.value;

  final _agentNonPaye = 0.obs;
  int get agentNonPaye => _agentNonPaye.value;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    if (!GetPlatform.isWeb) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        var personnels = await personnelsApi.getAllData();
        _agentsCount.value = personnels.length;
        _agentActifCount.value = personnels
            .where((element) => element.statutAgent == 'Actif')
            .length;
        _agentInactifCount.value = personnels
            .where((element) => element.statutAgent == 'Inactif')
            .length;
        _agentFemmeCount.value =
            personnels.where((element) => element.sexe == 'Femme').length;
        _agentHommeCount.value =
            personnels.where((element) => element.sexe == 'Homme').length;
      }
    }
    if (GetPlatform.isWeb) {
       var personnels = await personnelsApi.getAllData();
      _agentsCount.value = personnels.length;
      _agentActifCount.value =
          personnels.where((element) => element.statutAgent == 'Actif').length;
      _agentInactifCount.value = personnels
          .where((element) => element.statutAgent == 'Inactif')
          .length;
      _agentFemmeCount.value =
          personnels.where((element) => element.sexe == 'Femme').length;
      _agentHommeCount.value =
          personnels.where((element) => element.sexe == 'Homme').length;
    }
    
    update();
  }
}
