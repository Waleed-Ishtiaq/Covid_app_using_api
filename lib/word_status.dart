// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:covid_19_app/Model/world_states_model.dart';
import 'package:covid_19_app/Services/statusServies.dart';
import 'package:covid_19_app/View/countriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatus extends StatefulWidget {
  const WorldStatus({super.key});

  @override
  State<WorldStatus> createState() => _WorldStatusState();
}

class _WorldStatusState extends State<WorldStatus>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: statesServices.fetchWorldStatesModel(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases!.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered!.toString()),
                            'Deaths':
                                double.parse(snapshot.data!.deaths!.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: 180,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases.toString(),
                                ),
                                ReusableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString(),
                                ),
                                ReusableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered.toString(),
                                ),
                                ReusableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString(),
                                ),
                                ReusableRow(
                                  title: 'Criticle',
                                  value: snapshot.data!.critical.toString(),
                                ),
                                ReusableRow(
                                  title: 'Today Deaths',
                                  value: snapshot.data!.todayDeaths.toString(),
                                ),
                                ReusableRow(
                                  title: 'Today Recovered',
                                  value:
                                      snapshot.data!.todayRecovered.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CountriesListScreen()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          )
        ],
      ),
    );
  }
}
