import 'song_chart_data.dart';

class SongChatResModel {
  int? status;
  String? name;
  String? message;
  int? errorCode;
  int? code;
  List<SongChartData>? songChartData;

  SongChatResModel({
    this.status,
    this.name,
    this.message,
    this.errorCode,
    this.code,
    this.songChartData,
  });

  factory SongChatResModel.fromJson(Map<String, dynamic> json) {
    return SongChatResModel(
      status: json['status'] as int?,
      name: json['name'] as String?,
      message: json['message'] as String?,
      errorCode: json['error_code'] as int?,
      code: json['code'] as int?,
      songChartData: (json['data'] as List<dynamic>?)
          ?.map((e) => SongChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'name': name,
        'message': message,
        'error_code': errorCode,
        'code': code,
        'data': songChartData?.map((e) => e.toJson()).toList(),
      };
}
