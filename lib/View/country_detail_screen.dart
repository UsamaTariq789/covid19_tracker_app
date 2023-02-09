import 'package:covid19_tracker_app/View/world_stats.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatefulWidget {
  CountryDetailScreen(
      {required this.country,
      required this.active,
      required this.critical,
      required this.image,
      required this.tests,
      required this.todayRecovered,
      required this.todayDeaths,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered});

  String country, image;
  int totalCases,
      totalRecovered,
      totalDeaths,
      active,
      critical,
      todayRecovered,
      todayDeaths,
      tests;

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .06),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .06,
                        ),
                        ReuseableRow(
                          title: 'Total Cases',
                          value: widget.totalCases.toString(),
                        ),
                        ReuseableRow(
                          title: 'Total Recovered',
                          value: widget.totalRecovered.toString(),
                        ),
                        ReuseableRow(
                          title: 'Total Deaths',
                          value: widget.totalDeaths.toString(),
                        ),
                        ReuseableRow(
                          title: 'Active',
                          value: widget.active.toString(),
                        ),
                        ReuseableRow(
                          title: 'Critical',
                          value: widget.critical.toString(),
                        ),
                        ReuseableRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovered.toString(),
                        ),
                        ReuseableRow(
                          title: 'Today Deaths',
                          value: widget.todayDeaths.toString(),
                        ),
                        ReuseableRow(
                          title: 'Tests',
                          value: widget.tests.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
