import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_karma/models/reward.dart';

class RewardService {
  final CollectionReference rewardsCollection = FirebaseFirestore.instance.collection('rewards');

  Future createReward(Reward reward) async {
    DocumentReference result = await rewardsCollection.add(reward.toJson());
    if (result != null) {
      reward.docId = result.id;
    }
    return result;
  }

  Future getRewardById(String activityId) async {
    DocumentSnapshot snapshot = await rewardsCollection.doc(activityId).get();

    if (snapshot.exists) {
      Reward reward = Reward();
      reward.fromJson(snapshot.data(), snapshot.id);

      return reward;
    }
  }

  Future updateReward(Reward reward) async {
    return await rewardsCollection.doc(reward.docId).update(reward.toJson());
  }

  Future deleteReward(Reward reward) async {
    return await rewardsCollection.doc(reward.docId).delete();
  }

  List<Reward> _rewardsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Reward reward = Reward();
      reward.fromJson(doc.data(), doc.id);
      return reward;
    }).toList();
  }

  Future<List<Reward>> getAllRewards() async {
    QuerySnapshot snapshot = await rewardsCollection.get();
    return _rewardsListFromSnapshot(snapshot);
  }

  Stream<List<Reward>> streamAllActivities() {
    return rewardsCollection.snapshots().map(_rewardsListFromSnapshot);
  }
}
