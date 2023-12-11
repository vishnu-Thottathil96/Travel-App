import 'package:url_launcher/url_launcher.dart';

void launchGoogleMaps(String locationLink) async {
  // ignore: deprecated_member_use
  if (await canLaunch(locationLink)) {
    // ignore: deprecated_member_use
    await launch(locationLink);
  } else {
    throw 'Could not launch $locationLink';
  }
}
