import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code/initStateModel.dart';
import 'package:qr_code/simbleModel.dart';
import 'package:qr_code/statemodel.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  ///SimpleModelを参照
  final _simpleModel = SimpleModel();

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///stateFontroller
    final _stateModelController = ref.watch(stateModelProvider);

    ///変数
    var _aspectTolerance = 0.00;
    var _selectedCamera = -1;
    var _useAutoFocus = true;
    var _autoEnableFlash = false;
    String barcode = '';

    final _flashOnController = TextEditingController(text: 'Flash on');
    final _flashOffController = TextEditingController(text: 'Flash off');
    final _cancelController = TextEditingController(text: 'Cancel');

    List<BarcodeFormat> selectedFormats = [..._possibleFormats];

    ///initState
    useEffect(() {
      Future.delayed(Duration.zero,
          () => ref.read(initStateModelProvider.notifier).delayed());
    });

    ///メイン画面
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        ///stateModelを参照
        onPressed: () {
          ref.read(stateModelProvider.notifier).scan(
              cancelController: _cancelController,
              flashOnController: _flashOnController,
              flashOffController: _flashOffController,
              selectedCamera: _selectedCamera,
              useAutoFocus: _useAutoFocus,
              aspectTolerance: _aspectTolerance,
              autoEnableFlash: _autoEnableFlash,
              selectedFormats: selectedFormats);
        },
        child: Icon(Icons.camera),
      ),
      body: Center(
        child: Text(
          _stateModelController.scanResult!.rawContent.toString(),
        ),
      ),
    );
  }
}
