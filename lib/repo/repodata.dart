import 'dart:convert';

import 'package:http/http.dart';
import 'package:tester/model/datamodel.dart';

class DataRepo {
  String endpoint = 'https://dummyjson.com/products/categories';
  Future<List<ModelData>> getData() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List getdata = jsonDecode(response.body);
      print(response.body);
      return getdata.map((e) => ModelData.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
