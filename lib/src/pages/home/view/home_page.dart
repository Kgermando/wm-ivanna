import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/controllers/network_controller.dart';
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart';
import 'package:wm_com_ivanna/src/pages/home/components/home_list.dart';
import 'package:wm_com_ivanna/src/pages/home/controller/home_controller.dart';
import 'package:wm_com_ivanna/src/routes/routes.dart';
import 'package:wm_com_ivanna/src/widgets/barre_connection_widget.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart';
import 'package:wm_com_ivanna/src/widgets/responsive_child_widget.dart';
import 'package:wm_com_ivanna/src/widgets/title_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final HomeController controller = Get.put(HomeController());
  String title = "Acceuil";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, ''),
        body: controller.obx(
            onLoading: loadingPage(context),
            onEmpty: const Text('Aucune donnée'),
            onError: (error) => loadingError(context, error!),
            (state) => SingleChildScrollView(
              controller: ScrollController(),
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  const BarreConnectionWidget(),
                  Container(
                      margin: EdgeInsets.only(
                          top: Responsive.isMobile(context) ? 0.0 : p20,
                          right: Responsive.isMobile(context) ? 0.0 : p20,
                          left: Responsive.isMobile(context) ? 0.0 : p20,
                          bottom: p8),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TitleWidget(title: '💒 Home'.toUpperCase()),
                              // botomSheetWidget()
                            ],
                          ),
                          const SizedBox(height: p20),
                          Wrap(
                            runSpacing: p20,
                            spacing: p20,
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              ServiceHome(
                                  title: 'Commercial',
                                  icon: Icons.store,
                                  color: Colors.orange,
                                  onPress: () {
                                    Get.toNamed(ComRoutes.comDashboard);
                                  }),
                              ServiceHome(
                                  title: 'Reservation',
                                  icon: Icons.room,
                                  color: Colors.blueGrey,
                                  onPress: () {
                                    Get.toNamed(
                                        ReservationRoutes.dashboardReservation);
                                  }),
                              ServiceHome(
                                  title: 'Restaurant',
                                  icon: Icons.restaurant,
                                  color: Colors.pink,
                                  onPress: () {
                                    Get.toNamed(
                                        RestaurantRoutes.dashboardRestaurant);
                                  }),
                              ServiceHome(
                                  title: 'Terrasse',
                                  icon: Icons.nightlife,
                                  color: Colors.grey,
                                  onPress: () {
                                    Get.toNamed(TerrasseRoutes.dashboardTerrasse);
                                  }),
                              ServiceHome(
                                  title: 'VIP',
                                  icon: Icons.food_bank,
                                  color: Colors.red,
                                  onPress: () {
                                    Get.toNamed(VipRoutes.dashboardVip);
                                  }),
                              ServiceHome(
                                  title: 'Livraison',
                                  icon: Icons.delivery_dining,
                                  color: Colors.lightGreen,
                                  onPress: () {
                                    Get.toNamed(LivraisonRoutes.dashboardLivraison);
                                  }),
                              // ServiceHome(
                              //     title: 'Glace',
                              //     icon: Icons.icecream,
                              //     color: Colors.cyan,
                              //     onPress: () {}),
                              // ServiceHome(
                              //     title: 'Buffet',
                              //     icon: Icons.emoji_food_beverage,
                              //     color: Colors.purple,
                              //     onPress: () {}),
                              ServiceHome(
                                  title: 'Caisse',
                                  icon: Icons.savings,
                                  color: Colors.green,
                                  onPress: () {
                                    Get.toNamed(
                                        FinanceRoutes.transactionsCaisseDashbaord);
                                  }),
                              ServiceHome(
                                  title: 'Archive',
                                  icon: Icons.archive,
                                  color: Colors.brown,
                                  onPress: () {
                                    Get.toNamed(ArchiveRoutes.archivesFolder);
                                  }),
                              ServiceHome(
                                  title: 'RH',
                                  icon: Icons.group,
                                  color: Colors.blue,
                                  onPress: () {
                                    Get.toNamed(RhRoutes.rhPersonnelsPage);
                                  }),
                              // Wrap(
                              //   runSpacing: p20,
                              //   spacing: p20,
                              //   alignment: WrapAlignment.center,
                              //   runAlignment: WrapAlignment.center,
                              //   crossAxisAlignment: WrapCrossAlignment.start,
                              //   children: List.generate(state!.length, (index) {
                              //     var serviceHomeModel = state[index];
                              //     var color = listColors[index];
                              //     return HomeList(
                              //         serviceHomeModel: serviceHomeModel,
                              //         color: color);
                              //   }),
                              // ),
                            ],
                          ),
                          
                        ],
                      )),
                ],
              ),
            )));
  }

  Widget nameWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.nameController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom du service',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget iconPlaceWidget() {
    List<String> dataList = [
      'Bar',
      'VIP',
      'Terrasse',
      'Buffet',
      'Fast food',
      'Livraison',
      'Restaurant',
      'Gâteau',
      'Creme',
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Icon de service',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.iconPlace,
        isExpanded: true,
        items: dataList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select Icon de service" : null,
        onChanged: (value) {
          setState(() {
            controller.iconPlace = value!;
            final form = controller.formKey.currentState!;
            if (form.validate()) {
              controller.submit();
              form.reset();
              Navigator.of(context).pop();
            }
          });
        },
      ),
    );
  }

  Widget botomSheetWidget() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                useRootNavigator: true,
                isScrollControlled: true,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 3),
                builder: (BuildContext context) {
                  return Container(
                      padding: const EdgeInsets.all(p20),
                      child: Obx(() => controller.isLoading
                          ? loading()
                          : Form(
                              key: controller.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      TitleWidget(title: "Ajouter un service")
                                    ],
                                  ),
                                  const SizedBox(
                                    height: p20,
                                  ),
                                  ResponsiveChildWidget(
                                      child1: nameWidget(),
                                      child2: iconPlaceWidget()),
                                  const SizedBox(
                                    height: p20,
                                  ),
                                ],
                              ),
                            )));
                },
              );
            },
            icon: Icon(Icons.add_home, color: mainColor))
      ],
    );
  }
 
}
