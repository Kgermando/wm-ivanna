import 'package:flutter/material.dart';
import 'package:wm_com_ivanna/src/constants/responsive.dart';
import 'package:wm_com_ivanna/src/helpers/monnaire_storage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wm_com_ivanna/src/models/restaurant/vente_chart_restaurant_model.dart'; 
import 'package:wm_com_ivanna/src/utils/list_colors.dart';

class ArticlePlusVendusTerrasse extends StatefulWidget {
  const ArticlePlusVendusTerrasse(
      {Key? key, required this.state, required this.monnaieStorage})
      : super(key: key);
  final List<VenteChartRestaurantModel> state;
  final MonnaieStorage monnaieStorage;

  @override
  State<ArticlePlusVendusTerrasse> createState() => _ArticlePlusVendusTerrasseState();
}

class _ArticlePlusVendusTerrasseState extends State<ArticlePlusVendusTerrasse> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return SizedBox(
      height: (Responsive.isDesktop(context)) ? 400 : 300,
      child: Card(
        child: SfCartesianChart(
          title: ChartTitle(
              text: 'Produits les plus vendus',
              textStyle: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
          // legend: Legend(
          //     position: Responsive.isDesktop(context)
          //         ? LegendPosition.right
          //         : LegendPosition.bottom,
          //     isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            // VenteChartModel
            BarSeries<VenteChartRestaurantModel, String>(
                name: 'Produits',
                pointColorMapper: (datum, index) =>
                    listColors[index % listColors.length],
                dataSource: widget.state,
                sortingOrder: SortingOrder.descending,
                xValueMapper: (VenteChartRestaurantModel gdp, _) => gdp.identifiant,
                yValueMapper: (VenteChartRestaurantModel gdp, _) => gdp.count,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true)
          ],
          primaryXAxis: CategoryAxis(
              isVisible: Responsive.isDesktop(context) ? true : false),
          primaryYAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(text: '10 produits les plus vendus'),
          ),
        ),
      ),
    );
  }
}
