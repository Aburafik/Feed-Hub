// ignore_for_file: unnecessary_null_comparison

import 'package:feed_hub/Utils/router_helper.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/route_manager.dart';

class DynamicLinks {
  String? _linkMessage;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  void initLink() {
    FirebaseDynamicLinks.instance.getInitialLink().then((value) {
      final Uri uri = value!.link;
      var isStore = uri.queryParameters.containsKey("link");
      if (isStore) {
        print("##################${uri.queryParameters['link']}#############################");
        handleToken(value.link);
      }
    });
  }
//  ./gradlew signingReport
  Future<String> createDynamicLink({bool? short, String? link}) async {
    String urls = "https://com.example.feed_hub/?link=$link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: "https://feedhub.page.link",
      link: Uri.parse(urls),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.feed_hub',
        minimumVersion: 0,
      ),
    );

    Uri url;
    if (short!) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    _linkMessage = url.toString();
    return _linkMessage!;
  }

  handleToken(Uri url) {
    Get.toNamed(RouterHelper.page);
  }
}
