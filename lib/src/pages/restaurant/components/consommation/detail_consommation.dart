import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/helpers/monnaire_storage.dart';
import 'package:wm_com_ivanna/src/models/restaurant/restaurant_model.dart';
import 'package:wm_com_ivanna/src/models/restaurant/table_restaurant_model.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/drawer_menu_restaurant.dart';
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart';
import 'package:wm_com_ivanna/src/pages/commercial/components/factures/pdf_a6/facture_cart_a6_pdf.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/components/consommation/pro_format.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/restaurant_controller.dart';
import 'package:wm_com_ivanna/src/pages/restaurant/controller/table_restaurant_controller.dart';
import 'package:wm_com_ivanna/src/routes/routes.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart';
import 'package:wm_com_ivanna/src/widgets/title_widget.dart';

class DetailConsommation extends StatefulWidget {
  const DetailConsommation({super.key, required this.tableRestaurantModel});
  final TableRestaurantModel tableRestaurantModel;

  @override
  State<DetailConsommation> createState() => _DetailConsommationState();
}

class _DetailConsommationState extends State<DetailConsommation> {
  final TableRestaurantController controller = Get.find();
  final RestaurantController restaurantController = Get.find();
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final FactureCartPDFA6 factureCartPDFA6 = Get.put(FactureCartPDFA6());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Restaurant";

  Future<TableRestaurantModel> refresh() async {
    final TableRestaurantModel dataItem =
        await controller.detailView(widget.tableRestaurantModel.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    var restaurants = restaurantController.restaurantList
        .where((p0) =>
            p0.table == widget.tableRestaurantModel.table &&
            p0.statutCommande == 'true')
        .toList();
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(
          context, scaffoldKey, title, widget.tableRestaurantModel.table),
      drawer: const DrawerMenuRestaurant(),
      floatingActionButton:
          (restaurants.isNotEmpty) ? speedialWidget(restaurants) : Container(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: !Responsive.isMobile(context),
              child: const Expanded(flex: 1, child: DrawerMenuRestaurant())),
          Expanded(
              flex: 5,
              child: restaurantController.obx(
                  onLoading: loadingPage(context),
                  onEmpty: const Text('Aucune donnée'),
                  onError: (error) => loadingError(context, error!), (state) {
                var restaurantList = state!
                    .where((element) =>
                        element.table == widget.tableRestaurantModel.table &&
                        element.statutCommande == 'true')
                    .toList();
                return SingleChildScrollView(
                    controller: ScrollController(),
                    physics: const ScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: Responsive.isMobile(context) ? 0.0 : p20,
                          bottom: p8,
                          right: Responsive.isMobile(context) ? 0 : p20,
                          left: Responsive.isMobile(context) ? 0 : p20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          Card(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: p20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleWidget(
                                          title: widget
                                              .tableRestaurantModel.table
                                              .toUpperCase()),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () async {
                                                    refresh().then((value) =>
                                                        Navigator.pushNamed(
                                                            context,
                                                            RestaurantRoutes
                                                                .tableConsommationRestaurantDetail,
                                                            arguments: value));
                                                  },
                                                  icon: const Icon(
                                                      Icons.refresh,
                                                      color: Colors.green)),
                                             if(restaurantList.isEmpty) editButton(),
                                             if (restaurantList.isEmpty)  deleteButton(),
                                            ],
                                          ),
                                          SelectableText(
                                              DateFormat("dd-MM-yy HH:mm")
                                                  .format(widget
                                                      .tableRestaurantModel
                                                      .created),
                                              textAlign: TextAlign.start),
                                        ],
                                      )
                                    ],
                                  ),
                                  // Divider(
                                  //   color: mainColor,
                                  // ),
                                  // dataWidget(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: p20),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: restaurantList.length,
                              itemBuilder: (context, index) {
                                final data = restaurantList[index];
                                double total = double.parse(data.qty) *
                                    double.parse(data.price);
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        // An action can be bigger than the others.
                                        flex: 2,
                                        onPressed: (context) =>
                                            showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: Text(
                                                'Etes-vous sûr de supprimer ${data.unite}?',
                                                style: TextStyle(
                                                    color:
                                                        Colors.red.shade700)),
                                            content: Obx(() => controller
                                                    .isLoading
                                                ? loading()
                                                : const Text(
                                                    'Cette action permet de retirer cette consommation.')),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: Text('Annuler',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .red.shade700)),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  restaurantController
                                                      .deleteData(data.id!);
                                                  Navigator.pop(context, 'ok');
                                                },
                                                child: Text('OK',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .red.shade700)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.cancel,
                                        label: 'Annuler consommation',
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    child: ListTile(
                                      leading: const Icon(Icons.table_bar,
                                          size: p40),
                                      title: Text(
                                          data.identifiant.capitalizeFirst!,
                                          style: bodyMedium),
                                      subtitle: Text(
                                          "Qty: ${NumberFormat.decimalPattern('fr').format(double.parse(data.qty))} ${data.unite}",
                                          style: bodyMedium),
                                      trailing: AutoSizeText(
                                          "Prix: ${NumberFormat.decimalPattern('fr').format(total)} ${monnaieStorage.monney}",
                                          maxLines: 1,
                                          style: bodyMedium),
                                    ),
                                  ),
                                );
                              }),
                          const SizedBox(height: p20),
                          totalCart(),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ));
              }))
        ],
      ),
    );
  }

  Widget totalCart() {
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;

    return restaurantController.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!), (state) {
      double sumCart = 0;
      var restaurants = state!
          .where((element) =>
              element.table == widget.tableRestaurantModel.table &&
              element.statutCommande == 'true')
          .toList();
      for (var data in restaurants) {
        sumCart += double.parse(data.qty) * double.parse(data.price);
      }
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: p30, horizontal: p20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(left: p10),
                  child: Text("Total: ",
                      style: headlineSmall!.copyWith(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.bold)),
                )),
            const SizedBox(width: p20),
            Text(
                "${NumberFormat.decimalPattern('fr').format(sumCart)} ${monnaieStorage.monney}",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: headlineSmall.copyWith(color: Colors.red.shade700))
          ],
        ),
      );
    });
  }

  SpeedDial speedialWidget(List<RestaurantModel> restaurants) {
    return SpeedDial(
      closedForegroundColor: themeColor,
      openForegroundColor: Colors.white,
      closedBackgroundColor: themeColor,
      openBackgroundColor: themeColor,
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
            child: const Icon(Icons.food_bank),
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
            label: 'Facture Pro',
            onPressed: () {
              ProFormatPDFA6().generatePdf(widget.tableRestaurantModel.table,
                  restaurants, monnaieStorage.monney);
            }),
        SpeedDialChild(
            child: const Icon(Icons.add_shopping_cart),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            label: 'Vente au comptant',
            onPressed: () {
              newAComptantDialog(restaurants);
            }),
        SpeedDialChild(
            child: const Icon(Icons.add_shopping_cart),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueGrey,
            label: 'Vente à crédit',
            onPressed: () {
              newACreditDialog(restaurants);
            }),
      ],
      child: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }

  newAComptantDialog(List<RestaurantModel> restaurants) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (dialogContext) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title:
                  Text('Vente au comptant', style: TextStyle(color: mainColor)),
              content: SizedBox(
                  height: 200,
                  width: 200,
                  child: Obx(() => restaurantController.isFactureLoading
                      ? loading()
                      : Form(
                          key: restaurantController.factureFormKey,
                          child: Column(
                            children: [
                              nomClientWidget(),
                              telephoneWidget(),
                            ],
                          )))),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    final form =
                        restaurantController.factureFormKey.currentState!;
                    if (form.validate()) {
                      restaurantController.submitFacture(restaurants);
                      form.reset();
                      Navigator.pop(context, 'ok');
                    }
                  },
                  child: const Text('📨 Save'),
                ),
                TextButton(
                  onPressed: () {
                    final form =
                        restaurantController.factureFormKey.currentState!;
                    if (form.validate()) {
                      restaurantController.submitFacture(restaurants);
                      restaurantController.createFacturePDF(restaurants);
                      form.reset();
                      Navigator.pop(context, 'ok');
                    }
                  },
                  child: const Text('🖨 Print'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          });
        });
  }

  newACreditDialog(List<RestaurantModel> restaurants) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (dialogContext) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Vente à Crédit',
                  style: TextStyle(color: Colors.orange)),
              content: SizedBox(
                  height: 400,
                  width: 300,
                  child: Obx(() => restaurantController.isCreanceLoading
                      ? loading()
                      : Form(
                          key: restaurantController.creanceFormKey,
                          child: Column(
                            children: [
                              nomClientACreditWidget(),
                              telephoneACreditWidget(),
                              adresseACreditWidget(),
                              delaiPaiementWidget(),
                            ],
                          )))),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    final form =
                        restaurantController.creanceFormKey.currentState!;
                    if (form.validate()) {
                      restaurantController.submitFactureCreance(restaurants);
                      form.reset();
                      Navigator.pop(context, 'ok');
                    }
                  },
                  child: const Text('📨 Save'),
                ),
                TextButton(
                  onPressed: () {
                    final form =
                        restaurantController.creanceFormKey.currentState!;
                    if (form.validate()) {
                      restaurantController.submitFactureCreance(restaurants);
                      restaurantController.createPDFCreance(restaurants);
                      form.reset();
                      Navigator.pop(context, 'ok');
                    }
                  },
                  child: const Text('🖨 Print'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          });
        });
  }

  Widget nomClientWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: restaurantController.nomClientController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom du client',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          // validator: (value) {
          //   if (value != null && value.isEmpty) {
          //     return 'Ce champs est obligatoire';
          //   } else {
          //     return null;
          //   }
          // },
        ));
  }

  Widget telephoneWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: restaurantController.telephoneController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Téléphone',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          // validator: (value) {
          //   if (value != null && value.isEmpty) {
          //     return 'Ce champs est obligatoire';
          //   } else {
          //     return null;
          //   }
          // },
        ));
  }

  Widget nomClientACreditWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: restaurantController.nomClientAcreditController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom du client',
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

  Widget telephoneACreditWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: restaurantController.telephoneAcreditController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Téléphone',
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

  Widget adresseACreditWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: restaurantController.addresseAcreditController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Adresse',
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

  Widget delaiPaiementWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextButton.icon(
            onPressed: () async {
              DateTime? dateTime = await showOmniDateTimePicker(
                context: context,
                initialDate: DateTime.now(),
                type: OmniDateTimePickerType.date,
                firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
                lastDate: DateTime.now().add(
                  const Duration(days: 3652),
                ),
                is24HourMode: false,
                isShowSeconds: false,
                minutesInterval: 1,
                secondsInterval: 1,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                constraints: const BoxConstraints(
                  maxWidth: 350,
                  maxHeight: 650,
                ),
                transitionBuilder: (context, anim1, anim2, child) {
                  return FadeTransition(
                    opacity: anim1.drive(
                      Tween(
                        begin: 0,
                        end: 1,
                      ),
                    ),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 200),
                barrierDismissible: true,
                selectableDayPredicate: (dateTime) {
                  // Disable 25th Feb 2023
                  if (dateTime == DateTime(2023, 2, 25)) {
                    return false;
                  } else {
                    return true;
                  }
                },
              );
              restaurantController.delaiPaiementAcredit = dateTime;
            },
            icon: const Icon(Icons.calendar_month),
            label: const Text("Delai de Paiement")));
  }

  Widget editButton() {
    return IconButton(
      icon: Icon(Icons.edit, color: Colors.purple.shade700),
      tooltip: "Modification du nom",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:
              Text('Modification du nom', style: TextStyle(color: mainColor)),
          content: SizedBox(
            height: 200,
            child: Obx(() => controller.isLoading
                ? loading()
                : Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        nomTabletWidget(),
                      ],
                    ))),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                controller.submitUpdate(widget.tableRestaurantModel);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  Widget nomTabletWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.tableController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom de la table',
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

  Widget deleteButton() {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.red.shade700),
      tooltip: "Supprimer",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Etes-vous sûr de supprimer ceci?',
              style: TextStyle(color: Colors.red.shade700)),
          content: Obx(() => controller.isLoading
              ? loading()
              : const Text(
                  'Cette action permet de supprimer définitivement ce document.')),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child:
                  Text('Annuler', style: TextStyle(color: Colors.red.shade700)),
            ),
            TextButton(
              onPressed: () {
                controller.deleteData(widget.tableRestaurantModel.id!);
                Navigator.pop(context, 'ok');
              },
              child: Text('OK', style: TextStyle(color: Colors.red.shade700)),
            ),
          ],
        ),
      ),
    );
  }
}
