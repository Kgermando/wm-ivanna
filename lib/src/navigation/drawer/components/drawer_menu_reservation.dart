

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/controllers/departement_notify_controller.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/update_nav.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_com_ivanna/src/routes/routes.dart';
import 'package:wm_com_ivanna/src/utils/info_system.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart';

class DrawerMenuReservation extends GetView<DepartementNotifyCOntroller> {
  const DrawerMenuReservation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
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
          DrawerWidget(
              selected: currentRoute == ReservationRoutes.dashboardReservation,
              icon: Icons.dashboard,
              sizeIcon: 15.0,
              title: 'Dashboard',
              style: bodyMedium!,
              onTap: () {
                Get.toNamed(ReservationRoutes.dashboardReservation);
              }),
          DrawerWidget(
              selected: currentRoute == ReservationRoutes.reservation,
              icon: Icons.meeting_room,
              sizeIcon: 20.0,
              title: 'Reservations',
              style: bodyMedium,
              onTap: () {
                Get.toNamed(ReservationRoutes.reservation);
              }),
          if (GetPlatform.isWindows)
            UpdateNav(
              currentRoute: currentRoute,
            )
        ],
      );
    }));
  }
}
