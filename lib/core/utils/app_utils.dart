import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult.contains(ConnectivityResult.none)) {
    // No internet connection

    return false;
  } else {
    // Connected to a mobile network or WiFi

    return true;
  }
}
