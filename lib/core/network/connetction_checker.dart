import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final Connectivity connectivity;

  ConnectionCheckerImpl(this.connectivity);
  @override
  Future<bool> get isConnected async {
    var result = await connectivity.checkConnectivity();
    // Return true if connected to Wi-Fi or mobile, false if none
    return result.any((result) =>
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile);
  }
}
