class WrapResponse {
  String? message;
  int? statusCode;
  dynamic data;
  WrapResponse({
    this.message,
    this.statusCode,
    this.data,
  });
  WrapResponse.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();
    statusCode = json['code'];
    data = json['data'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['status_code'] = statusCode;
    _data['data'] = data;
    return _data;
  }
}
