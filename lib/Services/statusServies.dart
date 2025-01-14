import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Model/world_states_model.dart';
import 'Utilities/app_url.dart';

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesModel() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Erros');
    }
  }

  Future<List<dynamic>> fetchCountriesList() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Erros');
    }
  }
}
