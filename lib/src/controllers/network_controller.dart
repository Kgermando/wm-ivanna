import 'package:get/get.dart'; 
import 'package:connectivity_listener/connectivity_listener.dart';

class NetworkController extends GetxController {
  static NetworkController to = Get.find();

final _connectionListener = ConnectionListener();


  final _connectionStatus = 0.obs;
  int get connectionStatus => _connectionStatus.value;


  @override
  void onInit() {
    super.onInit();

     _connectionListener.init(
      onConnected: () => print("CONNECTED"),
      onReconnected: () => print("RECONNECTED"),
      onDisconnected: () => print("DISCONNECTED"),
    );
  }

  @override
  void dispose() {
    _connectionListener.dispose();
    super.dispose();
  }
}
