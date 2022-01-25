class Originalartist {
  int? idartist;
  String? name;
  String? image;

  Originalartist({this.idartist, this.name, this.image});

  factory Originalartist.fromJson(Map<String, dynamic> json) {
    return Originalartist(
      idartist: json['idartist'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'idartist': idartist,
        'name': name,
        'image': image,
      };
}
