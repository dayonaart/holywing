import 'news.dart';

class CarouselData {
  int? idhighlight;
  String? type;
  int? idtype;
  News? news;
  dynamic event;
  dynamic promo;
  int? ordernum;

  CarouselData({
    this.idhighlight,
    this.type,
    this.idtype,
    this.news,
    this.event,
    this.promo,
    this.ordernum,
  });

  factory CarouselData.fromJson(Map<String, dynamic> json) => CarouselData(
        idhighlight: json['idhighlight'] as int?,
        type: json['type'] as String?,
        idtype: json['idtype'] as int?,
        news: json['news'] == null
            ? null
            : News.fromJson(json['news'] as Map<String, dynamic>),
        event: json['event'] as dynamic,
        promo: json['promo'] as dynamic,
        ordernum: json['ordernum'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'idhighlight': idhighlight,
        'type': type,
        'idtype': idtype,
        'news': news?.toJson(),
        'event': event,
        'promo': promo,
        'ordernum': ordernum,
      };
}
