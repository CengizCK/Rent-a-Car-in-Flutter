class Araba_Detay {
  Araba_Detay(
      {required this.arabaid,
      required this.marka,
      required this.model,
      required this.vites,
      required this.depozito,
      required this.sinif,
      required this.yakit,
      required this.g_km,
      required this.fiyat,
      required this.resim,
      required this.plaka,
      required this.logo,
      required this.sirket,
      this.sirket_adi});
  final String arabaid;
  final String marka;
  final String model;
  final String vites;
  final String depozito;
  final String sinif;
  final String yakit;
  final int g_km;
  final double fiyat;
  final String resim;
  final String plaka;
  String logo;
  final String sirket;
  String? sirket_adi;
  factory Araba_Detay.fromJson(json) => Araba_Detay(
      arabaid: json["arabaid"] ?? "",
      marka: json["marka"] ?? "",
      model: json["model"] ?? "",
      vites: json["vites"] ?? "",
      yakit: json["yakit"] ?? "",
      resim: json["resim"] ?? "",
      depozito: json["depozito"] ?? "",
      sinif: json["sinif"] ?? "",
      g_km: json["g_km"] ?? 0,
      fiyat: double.tryParse((json["fiyat"] ?? 0).toString()) ?? 0,
      plaka: json["plaka"],
      logo: json["logo"] ?? "",
      sirket_adi: json["sirket_adi"] ?? "",
      sirket: json["sirket"] ?? "");

  toJson() {
    return {
      "arabaid": arabaid,
      "marka": marka,
      "model": model,
      "vites": vites,
      "yakit": yakit,
      "g_km": g_km,
      "depozito": depozito,
      "sinif": sinif,
      "fiyat": fiyat,
      "resim": resim,
      "plaka": plaka,
      "logo": logo,
      "sirket": sirket,
      "sirket_adi": sirket_adi
    };
  }
}
