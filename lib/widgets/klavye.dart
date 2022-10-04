import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:wordle_turkce/controllers/controller.dart';

class KlavyeWidget extends StatefulWidget {
  const KlavyeWidget({Key? key}) : super(key: key);

  @override
  State<KlavyeWidget> createState() => _KlavyeWidgetState();
}

class _KlavyeWidgetState extends State<KlavyeWidget> {
  @override
  void initState() {
    UnityAds.init(gameId: '4584497');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          const UnityBannerAd(
            placementId: "Banner_Android",
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              klavyeTusu("E"),
              klavyeTusu("R"),
              klavyeTusu("T"),
              klavyeTusu("Y"),
              klavyeTusu("U"),
              klavyeTusu("I"),
              klavyeTusu("O"),
              klavyeTusu("P"),
              klavyeTusu("Ğ"),
              klavyeTusu("Ü"),
            ],
          ),
          Row(
            children: [
              klavyeTusu("A"),
              klavyeTusu("S"),
              klavyeTusu("D"),
              klavyeTusu("F"),
              klavyeTusu("G"),
              klavyeTusu("H"),
              klavyeTusu("J"),
              klavyeTusu("K"),
              klavyeTusu("L"),
              klavyeTusu("Ş"),
              klavyeTusu("İ"),
            ],
          ),
          Row(
            children: [
              klavyeTusu("▶"),
              klavyeTusu("Z"),
              klavyeTusu("C"),
              klavyeTusu("V"),
              klavyeTusu("B"),
              klavyeTusu("N"),
              klavyeTusu("M"),
              klavyeTusu("Ö"),
              klavyeTusu("Ç"),
              klavyeTusu("⌫"),
            ],
          )
        ],
      ),
    );
  }

  Widget klavyeTusu(String harf) {
    final _controller = Get.put(Controller());
    return Expanded(
      flex: harf == "⌫" || harf == "▶" ? 3 : 2,
      child: InkWell(
        onTap: () {
          _controller.setk(harf);
          if ((_controller.hamle.value == 2) && (harf == "▶")) {
            UnityAds.showVideoAd(placementId: "Interstitial_Android");
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(3),
            color: Color(harf == "▶"
                ? 0xFF708052
                : harf == "⌫"
                    ? 0xFF914C4C
                    : 0xFF5E666A),
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 14),
            child: Text(
              harf,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
