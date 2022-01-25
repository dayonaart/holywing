import 'song.dart';

class SongChartData {
  int? idsong;
  int? totalHits;
  Song? song;

  SongChartData({this.idsong, this.totalHits, this.song});

  factory SongChartData.fromJson(Map<String, dynamic> json) => SongChartData(
        idsong: json['idsong'] as int?,
        totalHits: json['total_hits'] as int?,
        song: json['song'] == null ? null : Song.fromJson(json['song'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'idsong': idsong,
        'total_hits': totalHits,
        'song': song?.toJson(),
      };
}
