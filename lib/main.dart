import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle_turkce/controllers/controller.dart';
import 'package:wordle_turkce/widgets/klavye.dart';
import 'package:wordle_turkce/guide_page.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(Controller());
    _controller.setRandomKelime();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF0E0F10),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xFF0E0F10),
            elevation: 0.4,
            shadowColor: Colors.white,
            title: const Text('WORDLE TÜRKÇE'),
            leading: IconButton(
              onPressed: () {
                Get.to(() => const GuidePage(), transition: Transition.fade);
              },
              icon: const Icon(
                Icons.help_outline,
                color: Colors.grey,
              ),
            ),
          ),
          body: Center(
            child: Obx(() => _controller.durum.value.isEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              for (Map item in _controller.gecmisBloklar)
                                fakeGridItem(item),
                              GridView.count(
                                padding: const EdgeInsets.all(5),
                                shrinkWrap: true,
                                crossAxisCount: 5,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                children: harfListesi(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Kalan Hamle : ${6 - _controller.hamle.value}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const KlavyeWidget()
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _controller.durum.value == "Doğru"
                            ? "Doğru Bildin!"
                            : _controller.durum.value,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 30),
                      IconButton(
                        onPressed: () {
                          _controller.durum.value = "";
                        },
                        icon: const Icon(Icons.refresh),
                        iconSize: 50,
                        color: Colors.white,
                      )
                    ],
                  )),
          ),
        ),
      ),
    );
  }

  Widget fakeGridItem(Map item) {
    return GridView.count(
        padding: const EdgeInsets.all(5),
        shrinkWrap: true,
        crossAxisCount: 5,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: [
          for (var i = 0; i <= 4; i++)
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.5),
                      color: Color(item["renk"][i])),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      item["harf"][i],
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
        ]);
  }

  List<Widget> harfListesi() {
    final _controller = Get.put(Controller());
    return [
      for (var i = 1; i <= 5; i++)
        Stack(
          children: [
            Obx(
              () => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.5),
                  color: i == 1
                      ? Color(_controller.renk1.value)
                      : i == 2
                          ? Color(_controller.renk2.value)
                          : i == 3
                              ? Color(_controller.renk3.value)
                              : i == 4
                                  ? Color(_controller.renk4.value)
                                  : Color(_controller.renk5.value),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Obx(
                  () => Text(
                    i == 1
                        ? _controller.k1.value
                        : i == 2
                            ? _controller.k2.value
                            : i == 3
                                ? _controller.k3.value
                                : i == 4
                                    ? _controller.k4.value
                                    : _controller.k5.value,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
    ];
  }
}
