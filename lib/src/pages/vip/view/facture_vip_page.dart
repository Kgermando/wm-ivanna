import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/drawer_menu_vip.dart'; 
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart'; 
import 'package:wm_com_ivanna/src/pages/vip/components/factures/table_creance_vip.dart';
import 'package:wm_com_ivanna/src/pages/vip/components/factures/table_facture_vip.dart';
import 'package:wm_com_ivanna/src/pages/vip/controller/factures/creance_vip_controller.dart'; 
import 'package:wm_com_ivanna/src/pages/vip/controller/factures/facture_vip_controller.dart'; 
import 'package:wm_com_ivanna/src/widgets/loading.dart';

class FactureVipPage extends StatefulWidget {
  const FactureVipPage({super.key});

  @override
  State<FactureVipPage> createState() => _FactureVipPageState();
}

class _FactureVipPageState extends State<FactureVipPage> {
  final FactureVipController controller = Get.find();
  final ProfilController profilController = Get.find();
  final CreanceVipController factureCreanceController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Vip";
  String subTitle = "Factures";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenuVip(),
        body: Row(
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenuVip())),
            Expanded(
                flex: 5,
                child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                          child: TabBar(
                            physics: ScrollPhysics(),
                            tabs: [
                              Tab(text: "Facture au comptant"),
                              Tab(text: "Facture à crédit")
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const ScrollPhysics(),
                            children: [
                              controller.obx(
                                  onLoading: loadingPage(context),
                                  onEmpty: const Text('Aucune donnée'),
                                  onError: (error) =>
                                      loadingError(context, error!),
                                  (state) => Container(
                                      margin: EdgeInsets.only(
                                          top: Responsive.isMobile(context)
                                              ? 0.0
                                              : p20,
                                          bottom: p8,
                                          right: Responsive.isDesktop(context)
                                              ? p20
                                              : 0,
                                          left: Responsive.isDesktop(context)
                                              ? p20
                                              : 0),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: TableFactureVip(
                                          factureList: state!,
                                          controller: controller,
                                          profilController: profilController))),
                              factureCreanceController.obx(
                                  onLoading: loadingPage(context),
                                  onEmpty: const Text('Aucune donnée'),
                                  onError: (error) =>
                                      loadingError(context, error!),
                                  (state) => Container(
                                      margin: EdgeInsets.only(
                                          top: Responsive.isMobile(context)
                                              ? 0.0
                                              : p20,
                                          right: Responsive.isMobile(context)
                                              ? 0.0
                                              : p20,
                                          left: Responsive.isMobile(context)
                                              ? 0.0
                                              : p20,
                                          bottom: p8),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: TableCreanceVip(
                                          creanceRestaurantList: state!,
                                          controller: factureCreanceController,
                                          profilController: profilController)))
                            ],
                          ),
                        ),
                      ],
                    ))) 
          ],
        ));
  }
}
