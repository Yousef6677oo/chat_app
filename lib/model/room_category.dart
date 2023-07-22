class RoomCategory {
  String idRoom;
  String nameRoom;
  String imagePathRoom;

  RoomCategory(
      {required this.idRoom,
      required this.nameRoom,
      required this.imagePathRoom});

  static List<RoomCategory> getRoomCategories() {
    return [
      RoomCategory(
          idRoom: 'music',
          nameRoom: 'Music',
          imagePathRoom: 'assets/music.png'),
      RoomCategory(
          idRoom: 'sports',
          nameRoom: 'Sports',
          imagePathRoom: 'assets/sports.png'),
      RoomCategory(
          idRoom: 'movies',
          nameRoom: 'Movies',
          imagePathRoom: 'assets/movies.png'),
    ];
  }
}
