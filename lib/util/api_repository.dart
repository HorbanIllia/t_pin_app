import 'package:t_pin_app/models/pin_model.dart';

import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<Pin> checkPin(String id) {
    return _provider.fetchFakePin(id);
  }
}

class NetworkError extends Error {}