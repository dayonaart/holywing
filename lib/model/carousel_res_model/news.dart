class News {
  int? idnews;
  String? title;
  String? content;
  String? url;
  String? image;
  String? createdTimestamp;

  News({
    this.idnews,
    this.title,
    this.content,
    this.url,
    this.image,
    this.createdTimestamp,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        idnews: json['idnews'] as int?,
        title: json['title'] as String?,
        content: json['content'] as String?,
        url: json['url'] as String?,
        image: json['image'] as String?,
        createdTimestamp: json['created_timestamp'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'idnews': idnews,
        'title': title,
        'content': content,
        'url': url,
        'image': image,
        'created_timestamp': createdTimestamp,
      };
}
