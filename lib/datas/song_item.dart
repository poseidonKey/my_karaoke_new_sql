enum Janre { BALLADE, DABCE, TROT, POP, CLASSIC }

class SongItem {
  String? id;
  String songName;
  String songJanre;
  String songFavorite;
  SongItem(this.id, this.songName, this.songJanre, this.songFavorite);
  Map<String, dynamic> toMap() {
    return {
      "id": (id == 0) ? null : id,
      "songName": songName,
      "songJanre": songJanre,
      "songFavorite": songFavorite,
    };
  }
}
