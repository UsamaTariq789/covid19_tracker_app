import 'package:covid19_tracker_app/Services/stats_services.dart';
import 'package:covid19_tracker_app/View/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statsServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                              title: Container(
                                height: 10,
                                width: 80,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 80,
                                color: Colors.white,
                              ),
                            ),
                          );
                        });
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchController.text.isEmpty) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CountryDetailScreen(
                                    country: snapshot.data![index]['country'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    image: snapshot.data![index]['countryInfo']
                                        ['flag'],
                                    tests: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]
                                        ['todayRecovered'],
                                    todayDeaths: snapshot.data![index]
                                        ['todayDeaths'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalDeaths: snapshot.data![index]
                                        ['deaths'],
                                    totalRecovered: snapshot.data![index]
                                        ['recovered'],
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(
                                  snapshot.data![index]['countryInfo']['flag'],
                                ),
                              ),
                              title: Text(
                                snapshot.data![index]['country'],
                              ),
                              subtitle: Text(
                                  'cases: ${snapshot.data![index]['cases']}'),
                            ),
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CountryDetailScreen(
                                    country: snapshot.data![index]['country'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    image: snapshot.data![index]['countryInfo']
                                        ['flag'],
                                    tests: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]
                                        ['todayRecovered'],
                                    todayDeaths: snapshot.data![index]
                                        ['todayDeaths'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalDeaths: snapshot.data![index]
                                        ['deaths'],
                                    totalRecovered: snapshot.data![index]
                                        ['recovered'],
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(
                                  snapshot.data![index]['countryInfo']['flag'],
                                ),
                              ),
                              title: Text(
                                snapshot.data![index]['country'],
                              ),
                              subtitle: Text(
                                  'cases: ${snapshot.data![index]['cases']}'),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
