import 'originalartist.dart';

class Song {
  String? title;
  Originalartist? originalartist;
  String? url;
  String? image;
  dynamic externalUrlSpotify;
  dynamic externalUrlApplemusic;
  dynamic externalUrlStreamlink;
  dynamic externalUrlLink;

  Song({
    this.title,
    this.originalartist,
    this.url,
    this.image,
    this.externalUrlSpotify,
    this.externalUrlApplemusic,
    this.externalUrlStreamlink,
    this.externalUrlLink,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        title: json['title'] as String?,
        originalartist: json['originalartist'] == null
            ? null
            : Originalartist.fromJson(
                json['originalartist'] as Map<String, dynamic>),
        url: json['url'] as String?,
        image: json['image'] as String?,
        externalUrlSpotify: json['external_url_spotify'] as dynamic,
        externalUrlApplemusic: json['external_url_applemusic'] as dynamic,
        externalUrlStreamlink: json['external_url_streamlink'] as dynamic,
        externalUrlLink: json['external_url_link'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'originalartist': originalartist?.toJson(),
        'url': url,
        'image': image,
        'external_url_spotify': externalUrlSpotify,
        'external_url_applemusic': externalUrlApplemusic,
        'external_url_streamlink': externalUrlStreamlink,
        'external_url_link': externalUrlLink,
      };
}
