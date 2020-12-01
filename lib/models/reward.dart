class Reward {
  String docId;

  String company;
  String offer;
  int karmaNeeded;
  String photoUrl;

  Reward({this.company, this.offer, this.karmaNeeded, this.photoUrl});

  Map<String, dynamic> toJson() => {
        s_company: company,
        s_offer: offer,
        s_karmaNeeded: karmaNeeded,
        s_photoUrl: photoUrl,
      };

  void fromJson(Map<String, dynamic> data, String rewardId) {
    this.docId = rewardId;

    company = data[s_company];
    offer = data[s_offer];
    karmaNeeded = data[s_karmaNeeded];
    photoUrl = data[s_photoUrl];
  }

  static const String s_company = 'company';
  static const String s_offer = 'offer';
  static const String s_karmaNeeded = 'karma_needed';
  static const String s_photoUrl = 'photo_url';
}
