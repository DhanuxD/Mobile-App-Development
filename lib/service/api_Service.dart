import 'dart:convert';

import 'package:mobile_app/models/university_model.dart';
import 'package:http/http.dart' as http;

class LoadAPIData {
  Future<List<UniverSityModel>> fetchAllUniversities() async {
    final apiUrl = Uri.parse(
        'http://universities.hipolabs.com/search?country=United+States');

    final response = await http.get(apiUrl);
    // print(response.statusCode);

    if (response.statusCode == 200) {
      List<UniverSityModel> universities = parseJson(response.body);
      print('universities: ${universities.length}');
      return universities;
    } else {
      throw Exception('Failed to load universities');
    }
  }

  List<UniverSityModel> parseJson(String response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    return parsed
        .map<UniverSityModel>((json) => UniverSityModel.fromJson(json))
        .toList();
  }
}
