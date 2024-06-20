import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {

  static Future<List<Map<String, dynamic>>> fetchHealthInfoDog(String type) async {
    final response = await http.get(Uri.parse('https://api.thedogapi.com/v1/breeds'));

    if (response.statusCode == 200) {
      final List breeds = json.decode(response.body);
      List<Map<String, dynamic>> healthInfoList = breeds.map((breed) => {
        'name': breed['name'],
        'description': breed['temperament'],
        'image': breed['image'] != null ? breed['image']['url'] : null
      }).toList();
      return healthInfoList;
    } else {
      throw Exception('Failed to load health info');
    }
  }
  static Future<List<Map<String, dynamic>>> fetchHealthInfoCat() async {
    final response = await http.get(Uri.parse('https://api.thecatapi.com/v1/breeds'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // Transform data to match expected format
      return data.map((item) => {
        'name': item['name'],
        'description': item['description'],
        'image': item['image'] != null ? item['image']['url'] : null,
      }).toList().cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load health information');
    }
  }
}



