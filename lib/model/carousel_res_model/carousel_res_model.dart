import 'carousel_data.dart';

class CarouselResModel {
  int? status;
  String? name;
  String? message;
  int? errorCode;
  int? code;
  List<CarouselData>? carouselData;

  CarouselResModel({
    this.status,
    this.name,
    this.message,
    this.errorCode,
    this.code,
    this.carouselData,
  });

  factory CarouselResModel.fromJson(Map<String, dynamic> json) {
    return CarouselResModel(
      status: json['status'] as int?,
      name: json['name'] as String?,
      message: json['message'] as String?,
      errorCode: json['error_code'] as int?,
      code: json['code'] as int?,
      carouselData: (json['data'] as List<dynamic>?)
          ?.map((e) => CarouselData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'name': name,
        'message': message,
        'error_code': errorCode,
        'code': code,
        'data': carouselData?.map((e) => e.toJson()).toList(),
      };
}
