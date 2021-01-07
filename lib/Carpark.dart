class Carpark {
  final String carparkId;
  final String area;
  final String development;
  final double location;
  final int availableLots;
  final String lotType;
  final String agency;


  Carpark({this.carparkId, this.area, this.development, this.location,
      this.availableLots, this.lotType, this.agency});

  factory Carpark.fromJson(Map<String, dynamic> json) {
    return Carpark(
      carparkId: json['CarParkID'],
      area: json['Area'],
      development: json['Development'],
      //location: json['Location'],
      availableLots: json['AvailableLots'],
      lotType: json['LotType'],
      agency: json['Agency'],
    );
  }
}