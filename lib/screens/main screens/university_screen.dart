import 'package:flutter/material.dart';
import 'package:mobile_app/models/university_model.dart';
import 'package:mobile_app/service/api_Service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoadAPIData loadAPIData = LoadAPIData();
  Future<List<UniverSityModel>>? universities;
  @override
  void initState() {
    super.initState();
    universities = loadAPIData.fetchAllUniversities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<UniverSityModel>>(
        future: universities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<UniverSityModel> allUniversities = snapshot.data!;
              return ListView.builder(
                itemCount: allUniversities.length,
                itemBuilder: (context, index) {
                  UniverSityModel university = allUniversities[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      title: Text(
                        university.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4.0),
                          Text(
                            'Country: ${university.country}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Country Code: ${university.alpha_two_code}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'State: ${university.state}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            university.webPage,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Color.fromARGB(255, 15, 86, 145),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            university.domains,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          }
          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
