import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/helpers/monnaire_storage.dart';
import 'package:wm_com_ivanna/src/models/restaurant/facture_restaurant_model.dart';
import 'package:wm_com_ivanna/src/models/restaurant/restaurant_model.dart';
import 'package:wm_com_ivanna/src/navigation/drawer/components/drawer_menu_vip.dart'; 
import 'package:wm_com_ivanna/src/navigation/header/header_bar.dart';
import 'package:wm_com_ivanna/src/pages/vip/components/factures/cart/table_facture_vip_cart.dart'; 
import 'package:wm_com_ivanna/src/pages/vip/components/factures/pdf_a6/facture_vip_a6_pdf.dart'; 
import 'package:wm_com_ivanna/src/pages/vip/controller/factures/facture_vip_controller.dart'; 
import 'package:wm_com_ivanna/src/routes/routes.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart';
import 'package:wm_com_ivanna/src/widgets/print_widget.dart';
import 'package:wm_com_ivanna/src/widgets/title_widget.dart';

class DetailFactureVip extends StatefulWidget {
  const DetailFactureVip(
      {super.key, required this.factureRestaurantModel});
  final FactureRestaurantModel factureRestaurantModel;

  @override
  State<DetailFactureVip> createState() =>
      _DetailFactureVipState();
}

class _DetailFactureVipState extends State<DetailFactureVip> {
  final FactureVipController controller = Get.find();
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final FactureVipPDFA6 factureRestaurantPDFA6 =
      Get.put(FactureVipPDFA6());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Vip";

  Future<FactureRestaurantModel> refresh() async {
    final FactureRestaurantModel dataItem =
        await controller.detailView(widget.factureRestaurantModel.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(
          context, scaffoldKey, title, widget.factureRestaurantModel.client),
      drawer: const DrawerMenuVip(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: !Responsive.isMobile(context),
              child: const Expanded(flex: 1, child: DrawerMenuVip())),
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
                            right: Responsive.isDesktop(context) ? p20 : 0,
                            left: Responsive.isDesktop(context) ? p20 : 0),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                                            title:
                                                'Facture n° ${widget.factureRestaurantModel.client}'),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () async {
                                                      refresh().then((value) =>
                                                          Navigator.pushNamed(
                                                              context,
                                                              VipRoutes
                                                                  .factureVipDetail,
                                                              arguments:
                                                                  value));
                                                    },
                                                    icon: const Icon(
                                                        Icons.refresh,
                                                        color: Colors.green)),
                                                PrintWidget(
                                                    tooltip:
                                                        'Imprimer le document',
                                                    onPressed: () {
                                                      factureRestaurantPDFA6
                                                          .generatePdf(
                                                              widget
                                                                  .factureRestaurantModel,
                                                              monnaieStorage
                                                                  .monney);
                                                    })
                                              ],
                                            ),
                                            SelectableText(
                                                DateFormat("dd-MM-yy HH:mm")
                                                    .format(widget
                                                        .factureRestaurantModel
                                                        .created),
                                                textAlign: TextAlign.start),
                                          ],
                                        )
                                      ],
                                    ),
                                    Divider(
                                      color: mainColor,
                                    ),
                                    dataWidget(),
                                  ],
                                ),
                              ),
                            ),
                            TableFactureVipCart(
                                factureList:
                                    widget.factureRestaurantModel.cart),
                            const SizedBox(height: p20),
                            totalCart()
                          ],
                        ),
                      ))))
        ],
      ),
    );
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Nom client :',
                    textAlign: TextAlign.start,
                    style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  flex: 3,
                  child: SelectableText(widget.factureRestaurantModel.nomClient,
                      textAlign: TextAlign.start, style: bodyMedium)),
            ],
          ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Téléphone :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  flex: 3,
                  child: SelectableText(widget.factureRestaurantModel.telephone,
                      textAlign: TextAlign.start, style: bodyMedium)),
            ],
          ),
          Divider(
            color: mainColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Signature :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  flex: 3,
                  child: SelectableText(widget.factureRestaurantModel.signature,
                      textAlign: TextAlign.start, style: bodyMedium)),
            ],
          ),
          Divider(
            color: mainColor,
          ),
        ],
      ),
    );
  }

  Widget totalCart() {
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;

    List<RestaurantModel> cartItemList = widget.factureRestaurantModel.cart;

    double sumCart = 0;
    for (var data in cartItemList) {
      sumCart += double.parse(data.price) * double.parse(data.qty);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: p30, horizontal: p10),
      child: Row(
        mainAxisAlignment: Responsive.isDesktop(context)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
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
  }
}
