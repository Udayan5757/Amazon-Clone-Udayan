import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/models/sales.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CategoryProductChart extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;
  const CategoryProductChart({
    super.key,
    required this.seriesList,
  });

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
