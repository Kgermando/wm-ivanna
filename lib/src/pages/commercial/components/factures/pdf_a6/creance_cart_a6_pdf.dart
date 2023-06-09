// ignore_for_file: unused_local_variable

import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:printing/printing.dart'; 
import 'package:wm_com_ivanna/src/constants/app_theme.dart';
import 'package:wm_com_ivanna/src/global/store/auth/login_store.dart';
import 'package:wm_com_ivanna/src/models/commercial/cart_model.dart';
import 'package:wm_com_ivanna/src/models/commercial/creance_cart_model.dart';
import 'package:wm_com_ivanna/src/models/users/user_model.dart';
import 'package:wm_com_ivanna/src/utils/info_system.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class CreanceCartPDFA6 extends GetxController {
  generatePdf(CreanceCartModel factureCartModel, String monnaie) async {
    await Printing.layoutPdf(
        onLayout: (format) => _generatePdf(factureCartModel, monnaie));
  }

  Future<Uint8List> _generatePdf(
      CreanceCartModel creanceCartModel, monnaie) async {
    final pdf = Document();

    final user = await AuthStore().getUserId();

    pdf.addPage(MultiPage(
      margin: const EdgeInsets.all(0.0),
      pageFormat: PdfPageFormat.a6,
      build: (context) => [
        buildInvoiceInfo(creanceCartModel, user, monnaie),
        buildTitle(),
        buildInvoice(creanceCartModel, monnaie),
        Divider(),
        buildTotal(creanceCartModel, monnaie),
        Divider(),
        buildFooter()
      ],
      // footer: (context) => buildFooter(),
    ));

    // return PdfApi.saveDocument(name: 'facture', pdf: pdf);
    return pdf.save();
  }

  static Widget buildInvoiceInfo(
      CreanceCartModel creanceCartModel, UserModel user, String monnaie) {
    // final titles = <String>[
    //   'Entreprise:',
    //   'N° Facture:',
    //   'Date:',
    //   'Monnaie:',
    // ];
    // final data = <String>[
    //   InfoSystem().name(),
    //   factureCartModel.client,
    //   DateFormat("dd/MM/yy HH:mm").format(factureCartModel.created),
    //   monnaie
    // ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(InfoSystem().nameClient(), style: const TextStyle(fontSize: p10)),
      Text("RCCM: ${InfoSystem().rccm()}",
          style: const TextStyle(fontSize: p8)),
      Text("Tél.: ${InfoSystem().phone()}",
          style: const TextStyle(fontSize: p8)),
      Text("Facture N° ${creanceCartModel.client}",
          style: const TextStyle(fontSize: p8)),
      Text(
          "Date: ${DateFormat("dd/MM/yy HH:mm").format(creanceCartModel.created)}",
          style: const TextStyle(fontSize: p8)),
      Text("Monnaie: $monnaie", style: const TextStyle(fontSize: p8))
    ]);
  }

  static Widget buildTitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(
            'Facture'.toUpperCase(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(
      CreanceCartModel creanceCartModel, String monnaie) {
    final headers = ['Qté', 'Designation', 'PVU', 'Montant'];

    // final jsonList = jsonDecode(creanceCartModel.cart) as List;
    List<CartModel> cartItemList = creanceCartModel.cart;

    // for (var element in creanceCartModel.cart) {
    //   cartItemList.add(CartModel.fromJson(element));
    // }

    final data = cartItemList.map((item) {
      double priceTotal = 0;

      var qtyRemise = double.parse(item.qtyRemise);
      var quantity = double.parse(item.quantityCart);

      if (quantity >= qtyRemise) {
        priceTotal +=
            double.parse(item.remise) * double.parse(item.quantityCart);
      } else {
        priceTotal +=
            double.parse(item.priceCart) * double.parse(item.quantityCart);
      }

      String produit = '';
      if (item.idProductCart.contains('--')) {
        produit = item.idProductCart;
      } else if (!item.idProductCart.contains('--')) {
        var idproduit = item.idProductCart.split('-');
        produit =
            "${idproduit.elementAt(2)} ${idproduit.elementAt(3)} ${idproduit.elementAt(4)}";
      }

      return [
        (NumberFormat.decimalPattern('fr')
            .format(double.parse(item.quantityCart))),
        produit,
        (double.parse(item.quantityCart) >= double.parse(item.qtyRemise))
            ? NumberFormat.decimalPattern('fr')
                .format(double.parse(item.remise))
            : NumberFormat.decimalPattern('fr')
                .format(double.parse(item.priceCart)),
        (NumberFormat.decimalPattern('fr')
            .format(priceTotal.toStringAsFixed(2))),
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      cellPadding: const EdgeInsets.all(2.0),
      tableWidth: pw.TableWidth.min,
      headerStyle: const TextStyle(fontSize: 7),
      cellStyle: const TextStyle(fontSize: 7),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      // cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
        3: Alignment.centerRight
      },
    );
  }

  static Widget buildTotal(CreanceCartModel creanceCartModel, String monnaie) {
    // var tva = 0.0;
    double sumCart = 0;
    // final jsonList = jsonDecode(creanceCartModel.cart) as List;

    List<CartModel> cartItemList = creanceCartModel.cart;

    // for (var element in jsonList) {
    //   cartItemList.add(CartModel.fromJson(element));
    // }

    for (var item in cartItemList) {
      // TVA
      // tva = double.parse(item.tva);

      var qtyRemise = double.parse(item.qtyRemise);
      var quantity = double.parse(item.quantityCart);

      if (quantity >= qtyRemise) {
        sumCart += double.parse(item.remise) * double.parse(item.quantityCart);
      } else {
        sumCart +=
            double.parse(item.priceCart) * double.parse(item.quantityCart);
      }
    }
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // buildText(
          //   title: 'TVA',
          //   titleStyle: const TextStyle(
          //     fontSize: 7,
          //   ),
          //   value: "16 %",
          //   unite: true,
          // ),
          buildText(
            title: 'Total',
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            value:
                "${NumberFormat.decimalPattern('fr').format(sumCart.toStringAsFixed(2))} $monnaie",
            unite: true,
          ),
        ],
      ),
    );
  }

  static Widget buildFooter() => Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: '', value: InfoSystem().nameAdress()),
          // pw.Text('Merçi.', style: const TextStyle(fontSize: 7),
          //     textAlign: pw.TextAlign.center)
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    const style = TextStyle(fontSize: 7);

    return Row(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        Text(title, style: style, textAlign: TextAlign.center),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value, style: style, textAlign: TextAlign.center),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    // final style = titleStyle ?? const TextStyle(fontSize: 8);
    const style = TextStyle(fontSize: 8);
    return Container(
      child: pw.Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: style, textAlign: TextAlign.left),
          SizedBox(width: 100),
          Text(value, style: style, textAlign: TextAlign.right),
        ],
      ),
    );
  }
}
