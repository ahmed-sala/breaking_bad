class Character{
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic>jobs;
  late String statusIfDeadOrAlive;
  late List<dynamic>appearanceInSeasons;
  late String actorName;
  late String categoryForTwoSeries;
  late List<dynamic>betterCallSaulAppearanse;

  Character.fromJson(Map<String,dynamic>json){
    charId=json['char_id'];
    name=json['name'];
    nickName=json['nickname'];
    image=json['img'];
    jobs=json['occupation'];
    statusIfDeadOrAlive=json['status'];
    appearanceInSeasons=json['appearance'];
    actorName=json['portrayed'];
    categoryForTwoSeries=json['category'];
    betterCallSaulAppearanse=json['better_call_saul_appearance'];
  }
}