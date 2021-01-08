import 'package:hacknroll2021/Carpark.dart';

class MallCarpark extends Carpark {
  String weekday1;
  String weekday2;
  String sat;
  String sunPH;

  MallCarpark.fromCarpark({Carpark carpark, this.weekday1, this.weekday2, this.sat,
    this.sunPH}) : super.fromCarpark(carpark);

  @override
  MallCarpark withPrice() {
    return this;
  }

}