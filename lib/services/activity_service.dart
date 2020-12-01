import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_karma/models/activity.dart';
import 'package:green_karma/models/green_karma_user.dart';

class ActivityService {
  final CollectionReference activitiesCollection = FirebaseFirestore.instance.collection('activities');

  Future createActivity(Activity activity) async {
    activity.time = DateTime.now();
    DocumentReference result = await activitiesCollection.add(activity.toJson());
    if (result != null) {
      activity.docId = result.id;
    }
    return result;
  }

  Future getActivityById(String activityId) async {
    DocumentSnapshot snapshot = await activitiesCollection.doc(activityId).get();

    if (snapshot.exists) {
      Activity activity = Activity();
      activity.fromJson(snapshot.data(), snapshot.id);

      return activity;
    }
  }

  Future updateActivity(Activity activity) async {
    return await activitiesCollection.doc(activity.docId).update(activity.toJson());
  }

  Future deleteActivity(Activity activity) async {
    return await activitiesCollection.doc(activity.docId).delete();
  }

  List<Activity> _activityListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Activity activity = Activity();
      activity.fromJson(doc.data(), doc.id);
      return activity;
    }).toList();
  }

  Future<List<Activity>> getFriendsActivities(GreenKarmaUser user) async {
    QuerySnapshot snapshot = await activitiesCollection.orderBy('time', descending: true).get();
    return _activityListFromSnapshot(snapshot);
  }

  Stream<List<Activity>> streamAllActivities() {
    return activitiesCollection.snapshots().map(_activityListFromSnapshot);
  }
}
