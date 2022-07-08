import 'package:flutter/material.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:restaurant_app2/utils/helper/background/state_result.dart';

class RestaurantProvider extends ChangeNotifier {
  ApiService apiServices = ApiService();

  RestaurantProvider() {
    _fetchAllRestaurant();
  }

  late RestaurantList _restaurantList;
  late StateResult _state;
  String _message = '';

  RestaurantList get result => _restaurantList;
  StateResult get state => _state;
  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = StateResult.loading;
      notifyListeners();
      final getConnection = await apiServices.checkConnection();
      if (getConnection) {
        final restaurant = await apiServices.listRestaurant();
        if (restaurant.restaurants.isEmpty) {
          _state = StateResult.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = StateResult.hasData;
          notifyListeners();
          return _restaurantList = restaurant;
        }
      } else {
        _state = StateResult.error;
        notifyListeners();
        return _message = 'Check Your Internet Connection';
      }
    } catch (e) {
      _state = StateResult.error;
      notifyListeners();
      return _message = 'Error : $e';
    }
  }
}
