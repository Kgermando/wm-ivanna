import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/drawer_menu_terrasse.dart'; 
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/prod_model_terrasse_controller.dart'; 
import 'package:wm_com_ivanna/src/widgets/loading.dart';

class DashboardTerrassePage extends StatefulWidget {
  const DashboardTerrassePage({super.key});

  @override
  State<DashboardTerrassePage> createState() => _DashboardTerrassePageState();
}

class _DashboardTerrassePageState extends State<DashboardTerrassePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Terrasse";
  String subTitle = "Dashboard";

  @override
  Widget build(BuildContext context) {
    final ProdModelTerrasseController controller =
        Get.put(ProdModelTerrasseController());
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenuTerrasse(),
        body: Row(
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenuTerrasse())),
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
                        child: Container()))),
          ],
        ));
  }
}
