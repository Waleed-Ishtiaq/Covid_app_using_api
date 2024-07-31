// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:covid_19_app/Services/statusServies.dart';
import 'package:flutter/material.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices services = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: search,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: 'Search with Countries name'),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: services.fetchCountriesList(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return Text('loading');
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (search.text.isEmpty) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]
                                          ['country']
                                      .toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['falg']),
                                  ),
                                ),
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(search.text.toLowerCase())) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]
                                          ['country']
                                      .toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['falg']),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]
                                          ['country']
                                      .toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['falg']),
                                  ),
                                ),
                              ],
                            );
                          }
                        });
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
