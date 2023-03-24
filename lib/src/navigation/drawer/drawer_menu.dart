import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/controllers/departement_notify_controller.dart'; 
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_com_ivanna/src/routes/routes.dart';
import 'package:wm_com_ivanna/src/utils/info_system.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart';

class DrawerMenu extends GetView<DepartementNotifyCOntroller> {
  const DrawerMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ProfilController profilController = Get.find();
    return Drawer(
        child: profilController.obx(
            onLoading: loadingDrawer(),
            onError: (error) => loadingError(context, error!), (user) {
      return ListView(
        shrinkWrap: true,
        children: [
          InkWell(
            onTap: () => Get.toNamed(HomeRoutes.home),
            child: DrawerHeader(
                child: Image.asset(
              InfoSystem().logo(),
              width: 100,
              height: 100,
            )),
          ),
         
          // if (Platform.isWindows)
          //   UpdateNav(
          //     currentRoute: currentRoute,
          //     user: user,
          //   )
        ],
      );
    }));
  }
}
