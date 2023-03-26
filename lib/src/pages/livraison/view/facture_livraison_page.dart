import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/drawer_menu_livraison.dart'; 
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart'; 
import 'package:wm_com_ivanna/src/pages/livraison/components/factures/table_creance_livraison.dart';
import 'package:wm_com_ivanna/src/pages/livraison/components/factures/table_facture_livraison.dart';
import 'package:wm_com_ivanna/src/pages/livraison/controller/factures/creance_livraison_controller.dart'; 
import 'package:wm_com_ivanna/src/pages/livraison/controller/factures/facture_livraison_controller.dart'; 
import 'package:wm_com_ivanna/src/widgets/loading.dart';

class FactureLivraisonPage extends StatefulWidget {
  const FactureLivraisonPage({super.key});

  @override
  State<FactureLivraisonPage> createState() => _FactureLivraisonPageState();
}

class _FactureLivraisonPageState extends State<FactureLivraisonPage> {
  final FactureLivraisonController controller = Get.find();
  final ProfilController profilController = Get.find();
  final CreanceLivraisonController factureCreanceController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Livraison";
  String subTitle = "Factures";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenuLivraison(),
        body: Row(
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenuLivraison())),
            Expanded(
                flex: 5,
                child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                          child: TabBar(
                            physics: const ScrollPhysics(),
                            tabs: [
                              Tab(text: "$title Facture au comptant"),
                              Tab(text: "$title Facture à crédit")
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
                                  (state) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TableFactureLivraison(
                                        factureList: state!,
                                        controller: controller,
                                        profilController: profilController),
                                  )),
                              factureCreanceController.obx(
                                  onLoading: loadingPage(context),
                                  onEmpty: const Text('Aucune donnée'),
                                  onError: (error) =>
                                      loadingError(context, error!),
                                  (state) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TableCreanceLivraison(
                                        creanceRestaurantList: state!,
                                        controller: factureCreanceController,
                                        profilController: profilController),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ))) 
          ],
        ));
  }
}
