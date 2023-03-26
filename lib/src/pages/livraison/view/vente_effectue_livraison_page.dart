import 'package:badges/badges.dart' as badges;
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/helpers/monnaire_storage.dart';
import 'package:wm_com_ivanna/src/models/restaurant/vente_restaurant_model.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/drawer_menu_livraison.dart'; 
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart';
import 'package:wm_com_ivanna/src/pages/livraison/components/vente_effectue/vente_effectue_livraison_xlsx.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/prod_model_livraison_controller.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/ventes_effectue_livraison_controller.dart';
import 'package:wm_com_ivanna/src/routes/routes.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart';
import 'package:wm_com_ivanna/src/widgets/title_widget.dart';

class VenteEffectueLivraison extends StatefulWidget {
  const VenteEffectueLivraison({super.key});

  @override
  State<VenteEffectueLivraison> createState() => _VenteEffectueLivraisonState();
}

class _VenteEffectueLivraisonState extends State<VenteEffectueLivraison> {
  final VenteEffectueLivraisonController controller = Get.put(VenteEffectueLivraisonController());
  final ProdModelLivraisonController prodModelRestaurantController = Get.find();
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Livraison";
  String subTitle = "Ventes effectués";

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenuLivraison(),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenuLivraison())),
            Expanded(
                flex: 5,
                child: controller.obx(
                    onLoading: loadingPage(context),
                    onEmpty: const Text('Aucune donnée'),
                    onError: (error) => loadingError(context, error!),
                    (state) => SingleChildScrollView(
                        controller: ScrollController(),
                        physics: const ScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    TitleWidget(
                                      title: "$title Historique de ventes"),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          final values =
                                              await showCalendarDatePicker2Dialog(
                                            context: context,
                                            config:
                                                CalendarDatePicker2WithActionButtonsConfig(
                                              calendarType:
                                                  CalendarDatePicker2Type
                                                      .range,
                                            ),
                                            dialogSize: const Size(325, 400),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            // initialValue: [],
                                            dialogBackgroundColor:
                                                Colors.white,
                                          ); 
                                          DateTime? date1 = values![0];
                                          DateTime? date2 = values[1];
                                          var reppoting = state!
                                              .where((element) =>
                                                  element.created
                                                          .millisecondsSinceEpoch >=
                                                      date1!
                                                          .millisecondsSinceEpoch &&
                                                  element.created
                                                          .millisecondsSinceEpoch <=
                                                      date2!
                                                          .millisecondsSinceEpoch)
                                              .toList();
                                          VenteEffectueLivraisonXlsx()
                                              .exportToExcel(
                                                  title, reppoting); 
                                        },
                                        icon:
                                            const Icon(Icons.install_desktop),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            controller.getList();
                                            Navigator.pushNamed(context,
                                                LivraisonRoutes.ventEffectueLivraison);
                                          },
                                          icon: const Icon(Icons.refresh,
                                              color: Colors.green)),
                                    ],
                                  )
                                ],
                              ),
                              treeView(state!)
                            ],
                          ),
                        ))))
          ],
        ));
  }

  Widget treeView(List<VenteRestaurantModel> state) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Column(
      children: prodModelRestaurantController.produitModelList
          .map((e) {
            List<VenteRestaurantModel> ventList = state
                .where((element) => e.identifiant == element.identifiant)
                .toList();

            String count =
                (ventList.length > 9999) ? "9999+" : "${ventList.length}";
            return Card(
              child: ExpansionTile(
                leading: badges.Badge(
                  badgeContent: Padding(
                    padding: const EdgeInsets.all(p10),
                    child: Text(count,
                        style: bodySmall!.copyWith(color: Colors.white)),
                  ),
                  showBadge: (ventList.isNotEmpty),
                ),
                title: Text(e.idProduct),
                onExpansionChanged: (val) {
                  setState(() {
                    isOpen = !val;
                  });
                },
                children: List.generate(ventList.length, (index) {
                  var vente = ventList[index];
                  double unitaire = double.parse(vente.priceTotalCart) /
                      double.parse(vente.qty);
                  var countItem = index + 1;
                  return ListTile(
                    onTap: () => Get.toNamed(
                        LivraisonRoutes.ventEffectueLivraisonDetail,
                        arguments: vente),
                    leading: Text("$countItem.", style: bodyMedium),
                    title: Text(
                        "${NumberFormat.decimalPattern('fr').format(double.parse(vente.qty))} ${vente.unite} x ${NumberFormat.decimalPattern('fr').format(unitaire)} = ${NumberFormat.decimalPattern('fr').format(double.parse(vente.priceTotalCart))} ${monnaieStorage.monney}",
                        style: bodyMedium),
                    subtitle: Text(vente.signature,
                        style: bodyMedium!.copyWith(color: mainColor)),
                    trailing: Text(
                        DateFormat("dd-MM-yy HH:mm").format(vente.created),
                        style: bodyMedium),
                  );
                }),
              ),
            );
          })
          .toSet()
          .toList(),
    );
  }
}
