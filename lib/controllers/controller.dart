import 'package:get/get.dart';
import "dart:math";
import 'package:wordle_turkce/strings/kelime_listesi.dart';
import 'package:turkish/turkish.dart';

class Controller extends GetxController {
  var randomKelime = "".obs;

  var bulunanKelimeler = {}.obs;

  var durum = "".obs;

  var k1 = "".obs;
  var k2 = "".obs;
  var k3 = "".obs;
  var k4 = "".obs;
  var k5 = "".obs;

  var renk1 = 0.obs;
  var renk2 = 0.obs;
  var renk3 = 0.obs;
  var renk4 = 0.obs;
  var renk5 = 0.obs;

  List _renkList = [];
  List _kList = [];
  var gecmisBloklar = [].obs;

  var hamle = 0.obs;

  setRandomKelime() {
    final _random = Random();
    var _randomKelime = kelimeListesi[_random.nextInt(kelimeListesi.length)];
    return randomKelime.value = _randomKelime;
  }

  harfKontrol() {
    for (RxString k in _kList) {
      bool empty = false;
      if (k.value.isEmpty) {
        empty = true;
        break;
      }
      if (!empty) {
        if (randomKelime.contains(k.value.toLowerCaseTr())) {
          for (var i = 0; i <= 4; i++) {
            if (randomKelime.value[i] == k.value.toLowerCaseTr()) {
              bulunanKelimeler[i] = k.value;
            }
          }
        }
      }
    }
    renkAyarla();
  }

  renkAyarla() {
    _renkList = [renk1, renk2, renk3, renk4, renk5];
    final String _input = k1.value + k2.value + k3.value + k4.value + k5.value;

    for (var i = 0; i <= 4; i++) {
      if (_input[i] == bulunanKelimeler[i]) {
        _renkList[i].value = 0xFF77A815;
      } else if (bulunanKelimeler.containsValue(_input[i])) {
        _renkList[i].value = 0xFF856124;
      }
    }

    //hepsi doğru mu
    bool _yanlis = false;
    for (RxInt renk in _renkList) {
      if (renk.value != 4286031893) {
        _yanlis = true;
        break;
      }
    }

    if (!_yanlis) {
      durum.value = "Doğru";
      oyunuSifirla();
    } else {
      if (hamle.value > 2) {
        gecmisBloklar.removeAt(0);
        gecmisBloklar.refresh();
      }
      if (hamle.value == 5) {
        durum.value = "Maalesef Bilemedin!\nCevap: $randomKelime";
        oyunuSifirla();
        return;
      }

      hamle.value++;
      final _harfList = [k1.value, k2.value, k3.value, k4.value, k5.value];
      final _renkList = [
        renk1.value,
        renk2.value,
        renk3.value,
        renk4.value,
        renk5.value
      ];
      gecmisBloklar.add({
        "harf": _harfList,
        "renk": _renkList,
      });
      gecmisBloklar.refresh();
      sifirla();
    }
  }

  delk() {
    for (RxString k in _kList.reversed) {
      if (k.value.isNotEmpty) {
        k.value = "";
        break;
      }
    }
  }

  setk(String harf) {
    _kList = [k1, k2, k3, k4, k5];
    if (harf == "⌫") {
      delk();
    } else if (harf == "▶") {
      bool _isEmpty = false;
      for (RxString k in _kList) {
        if (k.value.isEmpty) {
          _isEmpty = true;
          break;
        }
        if (!_isEmpty) {
          harfKontrol();
        }
      }
    } else {
      for (RxString k in _kList) {
        if (k.value.isEmpty) {
          k.value = harf;
          break;
        }
      }
    }
  }

  sifirla() {
    for (RxString k in _kList) {
      k.value = "";
    }
    for (RxInt r in _renkList) {
      r.value = 0;
    }
  }

  oyunuSifirla() {
    hamle.value = 0;
    for (RxString k in _kList) {
      k.value = "";
    }
    for (RxInt r in _renkList) {
      r.value = 0;
    }
    setRandomKelime();
    bulunanKelimeler.value = {};
    gecmisBloklar.value = [];
    bulunanKelimeler.refresh();
    gecmisBloklar.refresh();
  }
}
