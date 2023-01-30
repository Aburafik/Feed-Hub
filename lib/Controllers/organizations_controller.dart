import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OrganizationsController extends GetxController {
  var organizations = [].obs;
  @override
  void onInit() {
    fetchAllOrganizations();
    super.onInit();
  }

  final getOrganizations =
      FirebaseFirestore.instance.collection('organizations').get();
  fetchAllOrganizations() {
    print("gettting ###############################");
    getOrganizations.then((value) {
      final data = value.docs.map((e) => e.data()).toList();

      organizations.value = data;

      // print(organizations);

      // print("...........the data is ..................");
    }, onError: (e) => print("Error getting document: $e"));
  }
}
