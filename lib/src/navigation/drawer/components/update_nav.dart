import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:wm_com_ivanna/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_com_ivanna/src/pages/update/controller/update_controller.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart'; 

class UpdateNav extends GetView<UpdateController> {
  const UpdateNav({super.key, required this.currentRoute});
  final String currentRoute; 

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium; 
      return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        (state) => ListView(
        shrinkWrap: true,
        children: state!.map((element) {
          return DrawerWidget(
              selected:
                  currentRoute == '/update/${element.id}',
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: element.version.toUpperCase(),
              style: bodyMedium!,
              onTap: () {
                Get.toNamed('/update/${element.id!}',
                    arguments: element);
              });
        }).toList(),
      )) ;  
  }
}
