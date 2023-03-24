import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/drawer_menu_restaurant.dart';
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart'; 
import 'package:wm_com_ivanna/src/pages/restaurant/controller/prod_model_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart';

class DashboardRestPage extends StatefulWidget {
  const DashboardRestPage({super.key});

  @override
  State<DashboardRestPage> createState() => _DashboardRestPageState();
}

class _DashboardRestPageState extends State<DashboardRestPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Restaurant";
  String subTitle = "Dashboard";

  @override
  Widget build(BuildContext context) {
    final ProdModelRestaurantController controller =
        Get.put(ProdModelRestaurantController());
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenuRestaurant(),
        body: Row(
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenuRestaurant())),
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
