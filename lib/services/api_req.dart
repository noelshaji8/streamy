import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class ApiReq {
  Future fetchValues() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.tvmaze.com/search/shows?q=all'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return data;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      return e;
    }
  }

  Future searchValues(String? search_term) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.tvmaze.com/search/shows?q=${search_term}'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      return e;
    }
  }
}
