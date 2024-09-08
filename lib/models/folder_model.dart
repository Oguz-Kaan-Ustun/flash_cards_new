
class FolderModel {
  String name;
  List contents;
  String ownerId;

  FolderModel({
    required this.name,
    required this.contents,
    required this.ownerId,
  });

  FolderModel.fromJson(Map<String, Object?> json)
      : this(
    name: json['name']! as String,
    contents: json['contents']! as List,
    ownerId: json['ownerId']! as String,
  );

  FolderModel copyWith({
    String? name,
    List? contents,
    String? ownerId
  }) {
    return FolderModel(
      name: name ?? this.name,
      contents: contents ?? this.contents,
      ownerId: ownerId ?? this.ownerId
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'contents': contents,
      'ownerId': ownerId,
    };
  }
}