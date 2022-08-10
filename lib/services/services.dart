import 'package:url_launcher/url_launcher.dart';

class UrlServices {
  static phoneCallLaunch(String number) async {
    await launchUrl(Uri.parse(number));
  }

  static smsLaunch(String sms) async {
    await launchUrl(Uri.parse(sms));
  }
  static emailLaunch(String mail) async {
    await launchUrl(Uri.parse(mail));
  }

  static geolocLaunch(String coordinates) async {
    await launchUrl(Uri.parse(coordinates), mode: LaunchMode.externalApplication);
  }

  static urlLaunch(String url) async {
    await launchUrl(Uri.parse(url),
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true, enableDomStorage: true));
  }
}
