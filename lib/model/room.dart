class Room{
  static const String collectionName = "room";
  String? id;
  String? name;
  String? description;
  String? categoryId;

  Room({this.id, this.name, this.categoryId, this.description});

  Room.fromFireStore(Map<String,dynamic> data):this(
    id: data["id"],
    name: data["name"],
    description: data["description"],
    categoryId: data["categoryId"],
  );

  Map<String,dynamic>toFireStore(){
    return {
      "id":id,
      "name":name,
      "description":description,
      "categoryId":categoryId,
    };
  }
}