import 'package:flutter/material.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/model/restaurant_detail.dart';
import 'package:restaurant_app2/utils/helper/background/state_result.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  late final ApiService apiService;
  String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant();
  }

  late DetailRestaurant _restaurant;
  String _message = '';
  late StateResult _state;

  String get message => _message;

  DetailRestaurant get result => _restaurant;

  StateResult get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = StateResult.loading;
      notifyListeners();
      final restaurants = await apiService.detailRestaurant(id);
      if (restaurants.restaurant.id.isEmpty) {
        _state = StateResult.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = StateResult.hasData;
        notifyListeners();
        return _restaurant = restaurants;
      }
    } catch (e) {
      _state = StateResult.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
