class SongItem {
  String? id;
  String songName;
  String songFavorite;
  SongItem(this.id, this.songName, this.songFavorite);
  Map<String, dynamic> toMap() {
    return {
      "id": (id == 0) ? null : id,
      "songName": songName,
      "songFavorite": songFavorite,
    };
  }
}
