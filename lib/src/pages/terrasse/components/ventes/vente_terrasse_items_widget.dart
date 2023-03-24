import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/helpers/monnaire_storage.dart';
import 'package:wm_com_ivanna/src/models/commercial/prod_model.dart';
import 'package:wm_com_ivanna/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/prod_model_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/table_terrasse_controller.dart';
import 'package:wm_com_ivanna/src/pages/terrasse/controller/terrasse_controller.dart';
import 'package:wm_com_ivanna/src/utils/regex.dart';
import 'package:wm_com_ivanna/src/widgets/loading.dart';

class VenteTerrasseItemWidget extends StatefulWidget {
  const VenteTerrasseItemWidget(
      {Key? key,
      required this.controller,
      required this.productModel,
      required this.profilController,
      required this.terrasseController})
      : super(key: key);
  final ProdModelTerrasseController controller;
  final ProductModel productModel;
  final ProfilController profilController;
  final TerrasseController terrasseController;

  @override
  State<VenteTerrasseItemWidget> createState() => _VenteTerrasseItemWidgetState();
}

class _VenteTerrasseItemWidgetState extends State<VenteTerrasseItemWidget> {
  final ProfilController profilController = Get.find();
  final TableTerrasseController tableterrasseController =
      Get.put(TableTerrasseController());

  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Après ajout au panier le produit quite la liste
  bool isActive = true;

  FocusNode focusNode = FocusNode();

  TextEditingController quantityCartController = TextEditingController();
  String? table;

  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    quantityCartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge; 
    final size = MediaQuery.of(context).size;

    return Visibility(
      visible: isActive,
      child: Responsive.isDesktop(context)
          ? Card(
              // elevation: 10,
              child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Icon(Icons.shopping_basket_sharp,
                            color: Colors.green.shade700, size: 40.0),
                        const SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.productModel.identifiant.toUpperCase(),
                              style: bodyLarge
                            ),
                            Text(
                              "Prix: ${NumberFormat.decimalPattern('fr').format(double.parse(widget.productModel.price))} ${monnaieStorage.monney}",
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Form(
                      key: formKey,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: qtyField()),
                          const SizedBox(width: p5),
                          Expanded(child: onChanged())
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
          : Card(
              // elevation: 10,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon(Icons.shopping_basket_sharp,
                  //     color: Colors.green.shade700, size: 40.0),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width / 2,
                              child: AutoSizeText(
                                widget.productModel.identifiant,
                                maxLines: 1,
                                // overflow: TextOverflow.visible,
                                style: bodyLarge,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width / 2,
                              child: AutoSizeText(
                                "Prix: ${NumberFormat.decimalPattern('fr').format(double.parse(widget.productModel.price))} ${monnaieStorage.monney}",
                                maxLines: 1,
                                // overflow: TextOverflow.visible,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                      // constraints: const BoxConstraints(maxWidth: 100),
                      child: Form(
                        key: formKey,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 1,
                              child: qtyField()),
                            const SizedBox(width: p5),
                            Expanded(
                              flex: 3,
                              child: onChanged())
                          ],
                        ),
                      ))
                ],
              ),
            ),
    );
  }

  Widget qtyField() {
    return TextFormField(
      controller:
          quantityCartController, // widget.cartController.quantityCartController,
      focusNode: focusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: const InputDecoration(
        hintText: 'Qté',
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Check Qté';
        } else if (RegExpIsValide().isValideVente.hasMatch(value!)) {
          return 'chiffres obligatoire';
        } else {
          return null;
        }
      },
    );
  }

  Widget onChanged() {
    return tableterrasseController.obx((state) {
      var tableList = state!.map((e) => e.table).toList();
      return Obx(() => (widget.terrasseController.isLoading)
          ? loadingMini()
          : DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Table',
                labelStyle: TextStyle(),
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(5.0)),
                // contentPadding: const EdgeInsets.only(left: 5.0),
              ),
              value: table,
              isExpanded: true,
              items: tableList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) => value == null ? "Select Table" : null,
              onChanged: (value) {
                setState(() {
                  final form = formKey.currentState!;
                  if (form.validate()) {
                    widget.terrasseController.addCommande(
                        widget.productModel, quantityCartController, value!);
                    isActive = !isActive;
                  }
                });
              },
            ));
    });
  }
}
