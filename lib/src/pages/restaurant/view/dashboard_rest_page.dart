import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/helpers/monnaire_storage.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/drawer_menu_restaurant.dart'; 
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart';  
import 'package:wm_com_ivanna/src/pages/restaurant/components/dashboard/arcticle_plus_vendus_rest.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/components/dashboard/courbe_vente_gain_day_rest.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/components/dashboard/courbe_vente_gain_mounth_rest.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/components/dashboard/courbe_vente_gain_year_rest.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/dashboard_rest_controller.dart';
import 'package:wm_com_ivanna/src/routes/routes.dart';
import 'package:wm_com_ivanna/src/widgets/barre_connection_widget.dart';
import 'package:wm_com_ivanna/src/widgets/dash_count_widget.dart'; 
import 'package:wm_com_ivanna/src/widgets/dash_number_widget.dart';
import 'package:wm_com_ivanna/src/widgets/responsive_child_widget.dart';
import 'package:wm_com_ivanna/src/widgets/title_widget.dart'; 

class DashboardRestPage extends StatefulWidget {
  const DashboardRestPage({super.key});

  @override
  State<DashboardRestPage> createState() => _DashboardRestPageState();
}

class _DashboardRestPageState extends State<DashboardRestPage> {
  final DashboardRestController controller = Get.find();
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage()); 
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Restaurant";
  String subTitle = "Dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenuRestaurant(),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenuRestaurant())),
            Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      const BarreConnectionWidget(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleWidget(title: title),
                                  const SizedBox(height: p10),
                                  Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    children: [
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(ComRoutes.comVente);
                                          },
                                          number:
                                              '${NumberFormat.decimalPattern('fr').format(controller.sumVente)} ${monnaieStorage.monney}',
                                          title: 'Ventes journalières',
                                          icon: Icons.shopping_cart,
                                          color: Colors.green.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(ComRoutes.comCreance);
                                          },
                                          number:
                                              '${NumberFormat.decimalPattern('fr').format(controller.sumDCreance)} ${monnaieStorage.monney}',
                                          title: 'Créances',
                                          icon: Icons.money_off_outlined,
                                          color: Colors.pink.shade700),
                                      DashCountWidget(
                                        title: 'Commande en cours',
                                        count1:
                                            controller.tableCommandeCount.toString(),
                                        count2: controller.tableTotalCount
                                            .toString(),
                                        icon: Icons.table_bar,
                                        color: Colors.blue.shade700,
                                        gestureTapCallback: () {
                                          Get.toNamed(RestaurantRoutes.tableCommandeRestaurant);
                                        },
                                      ),
                                      DashCountWidget(
                                        title: 'Consommation en cours',
                                        count1: controller.tableConsommationCount
                                            .toString(),
                                        count2:
                                            controller.tableTotalCount.toString(),
                                        icon: Icons.table_bar,
                                        color: Colors.orange.shade700,
                                        gestureTapCallback: () {
                                          Get.toNamed(RestaurantRoutes
                                              .tableConsommationRestaurant);
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  ResponsiveChildWidget(
                                    child1: CourbeVenteGainDayRest(
                                      controller: controller,
                                      monnaieStorage: monnaieStorage,
                                    ),
                                    child2: CourbeVenteGainMounthRest(
                                      controller: controller,
                                      monnaieStorage: monnaieStorage,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  CourbeVenteGainYearRest(
                                    controller: controller,
                                    monnaieStorage: monnaieStorage,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  ArticlePlusVendusRest(
                                      state: controller.venteChartList,
                                      monnaieStorage: monnaieStorage)
                                ])),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
