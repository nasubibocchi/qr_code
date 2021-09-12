import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///provider
final stateModelProvider = StateNotifierProvider<StateModelState, StateModel>(
    (refs) => StateModelState());

///state
class StateModel {
  StateModel({required this.scanResult});
  ScanResult? scanResult;
}

///statemodel
class StateModelState extends StateNotifier<StateModel> {
  StateModelState() : super(StateModel(scanResult: ScanResult()));

  Future<void> scan(
      {required TextEditingController cancelController,
      required TextEditingController flashOnController,
      required TextEditingController flashOffController,
      required var selectedCamera,
      required var useAutoFocus,
      required var aspectTolerance,
      required var autoEnableFlash,
      required List<BarcodeFormat> selectedFormats}) async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': cancelController.text,
            'flash_on': flashOnController.text,
            'flash_off': flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: selectedCamera,
          autoEnableFlash: autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: aspectTolerance,
            useAutoFocus: useAutoFocus,
          ),
        ),
      );

      ///
      state = StateModel(scanResult: result);
      // setState(() => scanResult = result);
    } on PlatformException catch (e) {
      ///
      state = StateModel(
          scanResult: ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
        rawContent: e.code == BarcodeScanner.cameraAccessDenied
            ? 'The user did not grant the camera permission!'
            : 'Unknown error: $e',
      ));
      // setState(() {
      //   scanResult = ScanResult(
      //     type: ResultType.Error,
      //     format: BarcodeFormat.unknown,
      //     rawContent: e.code == BarcodeScanner.cameraAccessDenied
      //         ? 'The user did not grant the camera permission!'
      //         : 'Unknown error: $e',
      //   );
      // });
    }
  }
}
