import 'package:flutter/material.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/utils/helper/background/state_result.dart';

import '../data/model/restaurant.dart';

class SearchProvider extends ChangeNotifier {
  ApiService apiService = ApiService();

  SearchProvider() {
    _state = StateResult.noInput;
  }

  late SearchRestaurant _searchRestaurant;
  late StateResult _state;
  String _message = '';

  SearchRestaurant get result => _searchRestaurant;
  StateResult get state => _state;
  String get message => _message;

  Future<void> fetchSearchRestaurant(String query) async {
    try {
      _state = StateResult.loading;
      notifyListeners();
      final getConnection = await apiService.checkConnection();
      if (getConnection) {
        final result = await apiService.searchingRestaurant(query);
        if (result.restaurants.isEmpty) {
          _state = StateResult.noData;
          notifyListeners();
          _message = 'Restaurant or Menu\nCould Not Be Found';
        } else {
          _state = StateResult.hasData;
          notifyListeners();
          _searchRestaurant = result;
        }
      } else {
        _state = StateResult.error;
        notifyListeners();
        _message = 'Check Your Internet Connection';
      }
    } catch (e) {
      _state = StateResult.error;
      notifyListeners();
      _message = 'Error : $e $query';
    }
  }
}
