import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_karma/common/globals.dart';
import 'package:green_karma/common/helper.dart';

enum KarmaCategory {
  food_waste,
  electricity,
  commute,
  water_usage,
  ecofriendly_purchase,
  recycling,
  community_service,
}

class KarmaTask {
  String id;
  KarmaCategory category;
  String task;
  int points;

  KarmaTask(this.category, this.task, this.points, this.id);

  KarmaTask.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    task = data['task'];
    points = data['points'];
    category = Helper.s2e(data['category'], KarmaCategory.values);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': Helper.e2s(category),
        'task': task,
        'points': points,
        'time': Timestamp.now(),
      };
}

class Badge {
  //String id;
  KarmaCategory category;
  Map<KarmaTask, bool> completionStatus;
  String name;

  Badge.fromJson(dynamic data, KarmaCategory category) {
    this.category = category;
    completionStatus = new Map<KarmaTask, bool>();
    switch (category) {
      case KarmaCategory.community_service:
        completionStatus[AppGlobals.getKarmaById('cs1')] = data['cs1'];
        completionStatus[AppGlobals.getKarmaById('cs2')] = data['cs2'];
        completionStatus[AppGlobals.getKarmaById('cs3')] = data['cs3'];
        this.name = 'Community Service Titan';

        break;

      case KarmaCategory.commute:
        completionStatus[AppGlobals.getKarmaById('c1')] = data['c1'];
        completionStatus[AppGlobals.getKarmaById('c2')] = data['c2'];
        completionStatus[AppGlobals.getKarmaById('c3')] = data['c3'];
        this.name = 'Commute Champion';
        break;

      case KarmaCategory.ecofriendly_purchase:
        completionStatus[AppGlobals.getKarmaById('ep1')] = data['ep1'];
        completionStatus[AppGlobals.getKarmaById('ep2')] = data['ep2'];
        completionStatus[AppGlobals.getKarmaById('ep3')] = data['ep3'];
        this.name = 'Green Sensei';
        break;

      case KarmaCategory.electricity:
        completionStatus[AppGlobals.getKarmaById('e1')] = data['e1'];
        completionStatus[AppGlobals.getKarmaById('e2')] = data['e2'];
        completionStatus[AppGlobals.getKarmaById('e3')] = data['e3'];
        this.name = 'Energy Expert';
        break;

      case KarmaCategory.food_waste:
        completionStatus[AppGlobals.getKarmaById('fw1')] = data['fw1'];
        completionStatus[AppGlobals.getKarmaById('fw2')] = data['fw2'];
        completionStatus[AppGlobals.getKarmaById('fw3')] = data['fw3'];
        this.name = 'Anti-Waster';
        break;

      case KarmaCategory.recycling:
        completionStatus[AppGlobals.getKarmaById('r1')] = data['r1'];
        completionStatus[AppGlobals.getKarmaById('r2')] = data['r2'];
        completionStatus[AppGlobals.getKarmaById('r3')] = data['r3'];
        this.name = 'Recycling Rockstar';
        break;

      case KarmaCategory.water_usage:
        completionStatus[AppGlobals.getKarmaById('wu1')] = data['wu1'];
        completionStatus[AppGlobals.getKarmaById('wu2')] = data['wu2'];
        completionStatus[AppGlobals.getKarmaById('wu3')] = data['wu3'];
        this.name = 'Water Warrior';
        break;
    }
  }

  void markTaskAsComplete(KarmaTask task) {
    completionStatus[AppGlobals.getKarmaById(task.id)] = true;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = Map<String, dynamic>();

    //result['badge_id'] = id;
    result['category'] = Helper.e2s(category);
    result['name'] = name;
    result['completion_status'] = completionStatus;

    return result;
  }

  double get completedDecimal {
    return (completedTasks / totalTasks);
  }

  int get totalTasks {
    return completionStatus.length;
  }

  int get completedTasks {
    int completeCount = 0;
    completionStatus.forEach((key, value) {
      if (value) {
        completeCount++;
      }
    });
    return completeCount;
  }

  int get numberOfTasksLeft {
    return totalTasks - completedTasks;
  }

  bool get isCompleted {
    return completedDecimal > 99;
  }
}
