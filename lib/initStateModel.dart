import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///provider
final initStateModelProvider = StateNotifierProvider<InitStateModelState, InitStateModel>(
        (refs) => InitStateModelState());

///state
class InitStateModel {
  InitStateModel({required numberOfCameras});
  int? numberOfCameras;
}

///statemodel
class InitStateModelState extends StateNotifier<InitStateModel> {
  InitStateModelState() : super(InitStateModel(numberOfCameras: 0));

  Future delayed () async {
    state = InitStateModel(numberOfCameras: await BarcodeScanner.numberOfCameras);
  }

  // Future.delayed(Duration.zero, () async {
  // _numberOfCameras = await BarcodeScanner.numberOfCameras;
  // setState(() {});
  // });

}



