import 'package:url_launcher/url_launcher.dart';

class SimpleModel {
  ///読み取ったURLに飛ぶ
  Future<void> launchURL({required String url}) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}