import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_karma/common/globals.dart';
import 'package:green_karma/common/helper.dart';
import 'package:green_karma/models/green_karma_user.dart';
import 'package:green_karma/models/karma.dart';
import 'package:green_karma/models/reward.dart';

class UserProfileService {
  final GreenKarmaUser user;
  UserProfileService({this.user});

  static final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  static DocumentReference referenceFromId(String id) {
    return usersCollection.doc(id);
  }

  Future<UserProfile> getOrCreateUserProfile() async {
    DocumentSnapshot snapshot = await usersCollection.doc(user.profileDocId).get();

    if (!snapshot.exists) {
      await usersCollection.doc(user.profileDocId).set(UserProfile.initialProfileData(user));
      snapshot = await usersCollection.doc(user.profileDocId).get();
    }

    return UserProfile.fromJson(snapshot.data(), snapshot.id);
  }

  Future updateUserProfile() async {
    return await user.profile.docRef.update(user.profile.toJson());
  }

  Future updateUserProfileFields(DocumentReference userDocRef, Map<String, dynamic> fields) async {
    return await userDocRef.update(fields);
  }

  Future<int> getNumberOfTasks() async {
    CollectionReference tasksCollection = FirebaseFirestore.instance.collection('users/${user.profile.email}/tasks');
    QuerySnapshot snapshot = await tasksCollection.get();
    return snapshot.size;
  }

  Future addReward(Reward reward) async {
    user.profile.karmaPoints -= reward.karmaNeeded;
    Map<String, dynamic> fields = {
      UserProfile.s_karmaPoints: user.profile.karmaPoints,
    };

    DocumentReference docRef = usersCollection.doc(user.userDocId);
    await updateUserProfileFields(docRef, fields);
  }

  Future addTask(KarmaTask task) async {
    CollectionReference tasksCollection = FirebaseFirestore.instance.collection('users/${user.profile.email}/tasks');
    await tasksCollection.add(task.toJson());

    user.profile.karmaPoints += task.points;

    Badge currBadge;
    user.profile.badges.forEach((element) {
      if (element.category == task.category) {
        currBadge = element;
        element.markTaskAsComplete(task);
      }
    });

    Map<String, bool> bd;
    switch (currBadge.category) {
      case KarmaCategory.community_service:
        bd = {
          'cs1': currBadge.completionStatus[AppGlobals.getKarmaById('cs1')],
          'cs2': currBadge.completionStatus[AppGlobals.getKarmaById('cs2')],
          'cs3': currBadge.completionStatus[AppGlobals.getKarmaById('cs3')],
        };
        break;

      case KarmaCategory.commute:
        bd = {
          'c1': currBadge.completionStatus[AppGlobals.getKarmaById('c1')],
          'c2': currBadge.completionStatus[AppGlobals.getKarmaById('c2')],
          'c3': currBadge.completionStatus[AppGlobals.getKarmaById('c3')],
        };
        break;

      case KarmaCategory.ecofriendly_purchase:
        bd = {
          'ep1': currBadge.completionStatus[AppGlobals.getKarmaById('ep1')],
          'ep2': currBadge.completionStatus[AppGlobals.getKarmaById('ep2')],
          'ep3': currBadge.completionStatus[AppGlobals.getKarmaById('ep3')],
        };
        break;

      case KarmaCategory.electricity:
        bd = {
          'e1': currBadge.completionStatus[AppGlobals.getKarmaById('e1')],
          'e2': currBadge.completionStatus[AppGlobals.getKarmaById('e2')],
          'e3': currBadge.completionStatus[AppGlobals.getKarmaById('e3')],
        };
        break;

      case KarmaCategory.food_waste:
        bd = {
          'fw1': currBadge.completionStatus[AppGlobals.getKarmaById('fw1')],
          'fw2': currBadge.completionStatus[AppGlobals.getKarmaById('fw2')],
          'fw3': currBadge.completionStatus[AppGlobals.getKarmaById('fw3')],
        };
        break;

      case KarmaCategory.recycling:
        bd = {
          'r1': currBadge.completionStatus[AppGlobals.getKarmaById('r1')],
          'r2': currBadge.completionStatus[AppGlobals.getKarmaById('r2')],
          'r3': currBadge.completionStatus[AppGlobals.getKarmaById('r3')],
        };
        break;

      case KarmaCategory.water_usage:
        bd = {
          'wu1': currBadge.completionStatus[AppGlobals.getKarmaById('wu1')],
          'wu2': currBadge.completionStatus[AppGlobals.getKarmaById('wu2')],
          'wu3': currBadge.completionStatus[AppGlobals.getKarmaById('wu3')],
        };
        break;
    }

    String s = Helper.e2s(currBadge.category);
    Map<String, dynamic> fields = {
      UserProfile.s_karmaPoints: user.profile.karmaPoints,
      'badge $s': bd,
    };

    DocumentReference docRef = usersCollection.doc(user.userDocId);
    await updateUserProfileFields(docRef, fields);
  }

  List<KarmaTask> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return KarmaTask.fromJson(doc.data());
    }).toList();
  }

  Future<List<KarmaTask>> getAllCompletedTasks() async {
    CollectionReference tasksCollection = FirebaseFirestore.instance.collection('users/${user.profile.email}/tasks');
    QuerySnapshot snapshot = await tasksCollection.get();
    return _taskListFromSnapshot(snapshot);
  }
}
