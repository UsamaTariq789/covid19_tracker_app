import 'package:covid19_tracker_app/Model/world_stats_model.dart';
import 'package:covid19_tracker_app/Services/stats_services.dart';
import 'package:covid19_tracker_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xFF4285F4),
    const Color(0xFF1AA260),
    const Color(0xFFDE5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(
                future: statsServices.fetchFromWorldStatsModel(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        controller: _controller,
                        size: 50,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered!.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths!.toString()),
                          },
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          colorList: colorList,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                ReuseableRow(
                                  title: 'Total Cases',
                                  value: snapshot.data!.cases!.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered!.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths!.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active!.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Today Cases',
                                  value: snapshot.data!.todayCases!.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Today Recovered',
                                  value:
                                      snapshot.data!.todayRecovered!.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Today Deaths',
                                  value: snapshot.data!.todayDeaths!.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: GestureDetector(
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
                                color: const Color(0xFF1aa260),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text('Track Countries'),
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

class ReuseableRow extends StatelessWidget {
  const ReuseableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(NumberFormat("###,###", "en_US").format(int.parse(value))),
              //Total Cases: 646,278,129
            ],
          ),
        ],
      ),
    );
  }
}
