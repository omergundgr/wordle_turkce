import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E0F10),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Text(
                    "NASIL OYNANIR",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 25,
                      ))
                ],
              ),
              const Divider(
                color: Colors.white,
              ),
              const Text(
                "WORDLE'i 6 denemede bulun.\n\nHer tahmin 5 harfli doğru bir kelime olmalıdır. Göndermek için enter'a basın.\n\nHer tahminden sonra kutucukların renkleri tahmininizin yakınlığına göre değişecektir.",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Image.asset(
                "assets/images/nasiloynanir.png",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
