class KayitModel {
  KayitModel(
      {required this.email,
      required this.marka,
      required this.model,
      required this.tc,
      required this.tel,
      required this.btarih,
      required this.musait,
      required this.bitarih,
      required this.plaka,
      required this.fiyat});
  String marka;
  String model;
  String email;
  double fiyat;
  String tc;
  bool musait;
  String tel;
  DateTime btarih;
  DateTime bitarih;
  String plaka;
  factory KayitModel.fromJson(json) => KayitModel(
      marka: json["marka"] ?? "",
      email: json["email"] ?? "",
      tel: json["tel"] ?? "",
      tc: json["tc"] ?? "",
      model: json["model"] ?? "",
      btarih: json["btarih"] ?? DateTime.now(),
      bitarih: json["bitarih"] ?? DateTime.now(),
      musait: json["musait"] ?? false,
      plaka: json["plaka"] ?? "",
      fiyat: json["fiyat"] ?? 0);

  toJson() {
    return {
      "marka": marka,
      "model": model,
      "email": email,
      "tel": tel,
      "btarih": btarih,
      "bitarih": bitarih,
      "tc": tc,
      "musait": musait,
      "plaka": plaka,
      "fiyat": fiyat
    };
  }
}
