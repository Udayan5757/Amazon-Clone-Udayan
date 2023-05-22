import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/loader.dart';
import 'package:flutter_amazon_clone/features/admin/models/sales.dart';
import 'package:flutter_amazon_clone/features/admin/services/admin_service.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/category_products_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminService adminService = AdminService();
  int totalSales=0;
  List<Sales> earnings=[];
  int totalAmount=0;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminService.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    totalAmount = totalSales.toInt();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              Text(
                totalAmount.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductChart(seriesList: [
                  charts.Series(
                    id: 'Sales',
                    data: earnings,
                    domainFn: (Sales sales, _) => sales.label,
                    measureFn: (Sales sales, _) => sales.earning,
                  ),
                ]),
              ),
            ],
          );
  }
}
