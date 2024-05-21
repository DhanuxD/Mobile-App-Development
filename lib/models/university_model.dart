// ignore: file_names
class UniverSityModel {
  String country;
  String webPage;
  String alpha_two_code;
  String domains;
  String state;
  String name;

  UniverSityModel(
      {required this.country,
      required this.webPage,
      required this.alpha_two_code,
      required this.domains,
      required this.name,
      required this.state});

  factory UniverSityModel.fromJson(Map<String, dynamic> json) {
    return UniverSityModel(
        country: json['country'],
        webPage: json['web_pages'][0],
        alpha_two_code: json['alpha_two_code'],
        domains: json['domains'][0],
        name: json['name'],
        state: json['state-province'] ?? "N/A");
  }
}
