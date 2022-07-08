import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:restaurant_app2/data/model/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _search = 'search?q=';

  // API for Restaurant List
  Future<RestaurantList> listRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to Load Restaurant List');
    }
  }

  // API for Restaurant Detail
  Future<DetailRestaurant> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load Restaurant Detail');
    }
  }

  // API for Search Restaurant
  Future<SearchRestaurant> searchingRestaurant(String name) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + name));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Search Restaurant');
    }
  }

  Future<bool> checkConnection() async {
    try {
      final connect =
          await InternetAddress.lookup('restaurant-api.dicoding.dev');
      if (connect.isNotEmpty && connect[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
