import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DataController extends GetxController {
  var isLoading = true.obs;
  var allUsers = 0.obs.toInt();
  var allDonations = 0.obs.toInt();
  var allNGOs = 0.obs.toInt();

  getAllUser(users) {
    allUsers = users!;
    update();
  }

  getAllDonations(donations) {
    allDonations = donations!;
    update();
  }

  getAllNGOs(ngos) {
    allNGOs = ngos!;
    update();
  }
}
