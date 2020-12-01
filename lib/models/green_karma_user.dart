import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_karma/models/karma.dart';
import 'package:green_karma/services/profile_service.dart';

class GreenKarmaUser {
  User firebaseUser;
  UserProfile profile;

  GreenKarmaUser.fromFirebaseUser(this.firebaseUser);

  String get userDocId {
    if (firebaseUser.email != null || firebaseUser.email.isNotEmpty) {
      return firebaseUser.email;
    } else {
      return firebaseUser.uid;
    }
  }

  String get profileDocId {
    return firebaseUser.email;
  }
}

class UserProfile {
  String firebaseUserId;
  String docId;

  String displayName;
  String email;
  String photoUrl;
  int karmaPoints;
  int tasksCompleted;
  List<Badge> badges;

  UserProfile({
    this.firebaseUserId,
    this.docId,
    this.displayName,
    this.email,
    this.photoUrl,
    this.karmaPoints,
  });

  UserProfile.fromJson(Map<String, dynamic> data, String docId) {
    this.docId = docId;

    displayName = data[s_displayName];
    email = data[s_email];
    photoUrl = data[s_photoUrl];
    karmaPoints = data[s_karmaPoints];
    badges = new List<Badge>();

    badges.add(Badge.fromJson(data['badge_community_service'], KarmaCategory.community_service));
    badges.add(Badge.fromJson(data['badge_commute'], KarmaCategory.commute));
    badges.add(Badge.fromJson(data['badge_ecofriendly_purchase'], KarmaCategory.ecofriendly_purchase));
    badges.add(Badge.fromJson(data['badge_electricity'], KarmaCategory.electricity));
    badges.add(Badge.fromJson(data['badge_food_waste'], KarmaCategory.food_waste));
    badges.add(Badge.fromJson(data['badge_recycling'], KarmaCategory.recycling));
    badges.add(Badge.fromJson(data['badge_water_usage'], KarmaCategory.water_usage));
  }

  Map<String, dynamic> toJson() => {
        s_displayName: displayName,
        s_email: email,
        s_photoUrl: photoUrl,
        s_karmaPoints: karmaPoints,
      };

  DocumentReference get docRef {
    return UserProfileService.referenceFromId(docId);
  }

  static Map<String, dynamic> initialProfileData(GreenKarmaUser gkUser) {
    return {
      s_displayName: gkUser.firebaseUser.displayName,
      s_email: gkUser.firebaseUser.email,
      s_firebase_uid: gkUser.firebaseUser.uid,
      s_photoUrl: gkUser.firebaseUser.photoURL,
      s_karmaPoints: 0,
      'badge_community_service': {'cs1': false, 'cs2': false, 'cs3': false},
      'badge_commute': {'c1': false, 'c2': false, 'c3': false},
      'badge_ecofriendly_purchase': {'ep1': false, 'ep2': false, 'ep3': false},
      'badge_electricity': {'e1': false, 'e2': false, 'e3': false},
      'badge_food_waste': {'fw1': false, 'fw2': false, 'fw3': false},
      'badge_recycling': {'r1': false, 'r2': false, 'r3': false},
      'badge_water_usage': {'wu1': false, 'wu2': false, 'wu3': false},
    };
  }

  static const String s_firebase_uid = 'firebase_uid';
  static const String s_displayName = 'display_name';
  static const String s_email = 'email';
  static const String s_photoUrl = 'photo_url';
  static const String s_karmaPoints = 'karma';
}
