import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;

class SalesHomePage extends StatefulWidget {
  @override
  _SalesHomePageState createState() => _SalesHomePageState();
}

class _SalesHomePageState extends State<SalesHomePage> {
  // 1.Generate the data for chart
  List<charts.Series<Sales, String>> _seriesBarData;
  // Create another list which h olds the detail from json file
  List<Sales> myData;
  _generateData(myData) {
    _seriesBarData.add(charts.Series(
        domainFn: (Sales sales, _) => sales.saleYear.toString(),
        measureFn: (Sales sales, _) => sales.saleVal,
        id: 'Sales',
        data: myData,
        labelAccessorFn: (Sales row, _) => "${row.saleYear}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales'),
      ),
      body: FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString("asset/jsondata.json"),
        builder: (context, snapshot) {
          var myData = json.decode(snapshot.data.toString());
          if (myData == null) {
            return Center(
              child: Text(
                'Loading',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            );
          } else {

            List<Sales> sales = sanpshot.data.documents.map((documentSnapshot) => Sales.fromMap(documentSnapshot.data))
                .toList();

            return _buildChart(context,sales);
          }
        },
      ),
    );
  }
}

Widget _buildChart(BuildContext context, List<Sales> sales) {
  myData = sales;
  _generateData(myData);
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(child:
      Center(
        child: Column(
          children: <Widget>[
            Text('Sales By Year'),
            Expanded(
                child: charts.BarChart(_seriesBarData,

                )
            ),
          ],
        ),
      ),
    ),
  );

}

class Sales {
  final int saleVal;
  final String saleYear;

  Sales(this.saleVal, this.saleYear);
  Sales.fromMap(Map<String, dynamic> map)
      : assert(map['saleVal'] != null),
        assert(map['saleYear'] != null),
        saleVal = map['saleVal'],
        saleYear = map['saleYear'];

  @override
  String tostring() => "Record<$saleVal:$saleYear>";
}
