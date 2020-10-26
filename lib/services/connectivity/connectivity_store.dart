import 'package:connectivity/connectivity.dart';
import 'package:mobx/mobx.dart';

part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStore with _$ConnectivityStore;

abstract class _ConnectivityStore with Store {
  // _ConnectivityStore() {
  //   checkConnection();
  // }

  @observable
  bool connectionState = false;

  @action
  Future<dynamic> checkConnection() async {
    Connectivity _connectivity = Connectivity();

    _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          if (connectionState == false) {
            print('MobX Online');
            connectionState = true;
          }
        }
        if (result == ConnectivityResult.none) {
          if (connectionState == true) {
            print('MobX Offline');
            connectionState = false;
          }
        }
      },
    );
  }
}
