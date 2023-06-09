import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/drawer_menu_commercial.dart';
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart';
import 'package:wm_com_ivanna/src/pages/commercial/components/produit_model/table_produit_model.dart';
import 'package:wm_com_ivanna/src/pages/commercial/controller/produit_model/produit_model_controller.dart';
import 'package:wm_com_ivanna/src/routes/routes.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart';

class ProduitModelPage extends StatefulWidget {
  const ProduitModelPage({super.key});

  @override
  State<ProduitModelPage> createState() => _ProduitModelPageState();
}

class _ProduitModelPageState extends State<ProduitModelPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";
  String subTitle = "Produit Modèle";

  @override
  Widget build(BuildContext context) {
    final ProduitModelController controller = Get.find();
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenuCommercial(),
        floatingActionButton: Responsive.isMobile(context)
            ? FloatingActionButton(
                tooltip: "Nouveau produit modèle",
                child: const Icon(Icons.add),
                onPressed: () {
                  Get.toNamed(ComRoutes.comProduitModelAdd);
                })
            : FloatingActionButton.extended(
                label: const Text("Ajout produit modèle"),
                tooltip: "Nouveau produit modèle",
                icon: const Icon(Icons.add),
                onPressed: () {
                  Get.toNamed(ComRoutes.comProduitModelAdd);
                }),
        body: Row(
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenuCommercial())),
            Expanded(
                flex: 5,
                child: controller.obx(
                    onLoading: loadingPage(context),
                    onEmpty: const Text('Aucune donnée'),
                    onError: (error) => loadingError(context, error!),
                    (data) => Container(
                        margin: EdgeInsets.only(
                            top: Responsive.isMobile(context) ? 0.0 : p20,
                            bottom: p8,
                            right: Responsive.isDesktop(context) ? p20 : 0,
                            left: Responsive.isDesktop(context) ? p20 : 0),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TableProduitModel(
                          produitModelList: controller.produitModelList,
                          controller: controller,
                          title: title,
                        )))),
          ],
        ));
  }
}
