import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker deviceStatus;

  NetworkInfoImpl(this.deviceStatus);
  
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => deviceStatus.hasConnection;

}
