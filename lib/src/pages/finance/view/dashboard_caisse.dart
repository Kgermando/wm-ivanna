import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/helpers/monnaire_storage.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/drawer_menu_finance.dart';
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart';
import 'package:wm_com_ivanna/src/pages/finance/controller/caisses/caisse_controller.dart';
import 'package:wm_com_ivanna/src/pages/finance/controller/caisses/caisse_name_controller.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart';

class DashboardCaisse extends StatefulWidget {
  const DashboardCaisse({super.key});

  @override
  State<DashboardCaisse> createState() => _DashboardCaisseState();
}

class _DashboardCaisseState extends State<DashboardCaisse> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final CaisseNameController caisseNameController = Get.find();
  final CaisseController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Finances";
  String subTitle = "Dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenuFinance(),
        body: Row(
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenuFinance())),
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
