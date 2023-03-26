import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/global/api/reservation/paiement_reservation_api.dart';
import 'package:wm_com_ivanna/src/global/api/reservation/reservation_api.dart'; 
import 'package:wm_com_ivanna/src/models/rh/agent_count_model.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart';

class DashboardReservationController extends GetxController
    with StateMixin<List<ReservationPieChartModel>> {
  ReservationApi reservationApi = ReservationApi();
  PaiementReservationApi paiementReservationApi = PaiementReservationApi();
  final ProfilController profilController = Get.find();

  var reservationPieChartList = <ReservationPieChartModel>[].obs;
  // var reservationList = <ReservationModel>[].obs;
  // var paiementReservationList = <PaiementReservationModel>[].obs;

  final _montantPayE = 0.0.obs;
  double get montantPayE => _montantPayE.value;

  final _montantNonPayE = 0.0.obs;
  double get montantNonPayE => _montantNonPayE.value;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    await reservationApi.getChartPie().then((response) {
      reservationPieChartList.clear();
      reservationPieChartList.addAll(response);
      change(reservationPieChartList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });



    await reservationApi.getAllData().then((response) { 
      for (var element in response) {
        _montantPayE.value += double.parse(element.montant);
      } 
    });

    await paiementReservationApi.getAllData().then((response) { 
      for (var element in response) {
        _montantNonPayE.value += double.parse(element.montant);
      } 
    });
  }
}
