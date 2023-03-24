import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/drawer_menu_terrasse.dart'; 
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart'; 
import 'package:wm_com_ivanna/src/pages/terrasse/components/ventes/vente_terrasse_items_widget.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/prod_model_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/terrasse_controller.dart';
import 'package:wm_com_ivanna/src/routes/routes.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart';

class VenteTerrassePage extends StatefulWidget {
  const VenteTerrassePage({super.key});

  @override
  State<VenteTerrassePage> createState() => _VenteTerrassePageState();
}

class _VenteTerrassePageState extends State<VenteTerrassePage> {
  final ProdModelTerrasseController controller = Get.find();
  final TerrasseController restaurantController = Get.find();
  final ProfilController profilController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Terrasse";
  String subTitle = "Ventes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const DrawerMenuTerrasse(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  (state) => SingleChildScrollView(
                      controller: ScrollController(),
                      physics: const ScrollPhysics(),
                      child: Container(
                          margin: EdgeInsets.only(
                            top: Responsive.isMobile(context) ? 0.0 : p20,
                            bottom: p8,
                            right: Responsive.isMobile(context) ? 0.0 : p20,
                            left: Responsive.isMobile(context) ? 0.0 : p20,
                          ),
                          child: Obx(() => Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          color: Theme.of(context).primaryColor,
                                          child: ListTile(
                                            leading: const Icon(Icons.search),
                                            title: TextField(
                                              controller:
                                                  controller.filterController,
                                              decoration: InputDecoration(
                                                hintText: 'Search',
                                                border: InputBorder.none,
                                                suffixIcon: controller
                                                        .filterController
                                                        .text
                                                        .isNotEmpty
                                                    ? GestureDetector(
                                                        child: const Icon(
                                                            Icons.close,
                                                            color:
                                                                Colors.red),
                                                        onTap: () {
                                                          controller
                                                              .filterController
                                                              .clear();
                                                          controller
                                                              .onSearchText(
                                                                  '');
                                                          FocusScope.of(
                                                                  context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                        },
                                                      )
                                                    : null,
                                              ),
                                              onChanged: (value) => controller
                                                  .onSearchText(value),
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            controller.getList();
                                            Navigator.pushNamed(
                                                context, TerrasseRoutes.venteTerrasse);
                                          },
                                          icon: const Icon(Icons.refresh,
                                              color: Colors.green))
                                    ],
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.venteList.length,
                                      itemBuilder: (context, index) {
                                        final data =
                                            controller.venteList[index];
                                        return VenteTerrasseItemWidget(
                                            controller: controller,
                                            productModel: data,
                                            profilController: profilController,
                                            terrasseController:
                                                restaurantController,);
                                      })
                                ],
                              ))))))
        ],
      ),
    );
  }
}
