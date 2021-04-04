import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Task, String>> _seriesPieData;

  _generateData() {
    var piedata = [
      new Task('10%', 10, Colors.yellow),
      new Task('20%', 20, Colors.green),
      new Task('25%', 25, Colors.indigo),
      new Task('5%', 5, Colors.red),
      new Task('40%', 40, Colors.blue)
    ];
    _seriesPieData.add(
      // ignore: missing_required_param
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var chart = [
      for (var i = -4.0; i <= 4.0; i += 0.1)
        if (i <= 0)
          SalesData(i, 0, Colors.transparent)
        else
          SalesData(i, log(i), Colors.blue)
    ];
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: Colors.blue,
            tabs: [
              Tab(
                icon: Icon(Icons.multiline_chart, color: Colors.blue),
              ),
              Tab(icon: Icon(Icons.pie_chart, color: Colors.blue)),
            ],
          ),
          body: TabBarView(
            children: [
              Container(
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: SfCartesianChart(
                                primaryXAxis: NumericAxis(crossesAt: 0),
                                primaryYAxis: NumericAxis(crossesAt: 0),
                                // Enable legend
                                legend: Legend(isVisible: false),
                                // Enable tooltip
                                tooltipBehavior: TooltipBehavior(enable: false),
                                series: <LineSeries<SalesData, double>>[
                              LineSeries<SalesData, double>(
                                  dataSource: chart,
                                  pointColorMapper: (SalesData sales, _) =>
                                      sales.segmentColor,
                                  xValueMapper: (SalesData sales, _) => sales.x,
                                  yValueMapper: (SalesData sales, _) => sales.y,
                                  // Disable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: false))
                            ])),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: charts.PieChart(_seriesPieData,
                              animate: true,
                              animationDuration: Duration(seconds: 2),
                              defaultRenderer: new charts.ArcRendererConfig(
                                  arcWidth: 100,
                                  arcRendererDecorators: [
                                    new charts.ArcLabelDecorator(
                                        labelPosition:
                                            charts.ArcLabelPosition.inside)
                                  ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class SalesData {
  SalesData(this.x, this.y, this.segmentColor);
  final double x;
  final double y;
  final Color segmentColor;
}
