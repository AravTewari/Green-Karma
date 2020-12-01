import 'package:green_karma/models/green_karma_user.dart';
import 'package:green_karma/models/karma.dart';

GreenKarmaUser globalUser;
String globalDisplayName;

class AppGlobals {
  AppGlobals._();

  static List<KarmaTask> karmaTasks;
  //static Map<KarmaCategory, List<KarmaTask>> karmas;

  static initialize() {
    karmaTasks = new List<KarmaTask>();

    karmaTasks.add(new KarmaTask(KarmaCategory.community_service, 'Trash pickup', 100, 'cs1'));
    karmaTasks.add(new KarmaTask(KarmaCategory.community_service, 'Community garden', 70, 'cs2'));
    karmaTasks.add(new KarmaTask(KarmaCategory.community_service, 'Recyling fair', 150, 'cs3'));

    karmaTasks.add(new KarmaTask(KarmaCategory.commute, 'Bike to work', 100, 'c1'));
    karmaTasks.add(new KarmaTask(KarmaCategory.commute, 'Take the bus', 70, 'c2'));
    karmaTasks.add(new KarmaTask(KarmaCategory.commute, 'Carpool', 50, 'c3'));

    karmaTasks.add(new KarmaTask(KarmaCategory.ecofriendly_purchase, 'Buy an electric car', 500, 'ep1'));
    karmaTasks.add(new KarmaTask(KarmaCategory.ecofriendly_purchase, 'Buy a hybrid car', 250, 'ep2'));
    karmaTasks.add(new KarmaTask(KarmaCategory.ecofriendly_purchase, 'Install solar panels', 1000, 'ep3'));

    karmaTasks.add(new KarmaTask(KarmaCategory.electricity, 'Save on electricity bill', 100, 'e1'));
    karmaTasks.add(new KarmaTask(KarmaCategory.electricity, 'Install energy efficient lights', 100, 'e2'));
    karmaTasks.add(new KarmaTask(KarmaCategory.electricity, 'Keep light switches off when not in use', 50, 'e3'));

    karmaTasks.add(new KarmaTask(KarmaCategory.food_waste, 'Composting', 50, 'fw1'));
    karmaTasks.add(new KarmaTask(KarmaCategory.food_waste, 'Cooking', 70, 'fw2'));
    karmaTasks.add(new KarmaTask(KarmaCategory.food_waste, 'Donate food', 100, 'fw3'));

    karmaTasks.add(new KarmaTask(KarmaCategory.recycling, 'Recycle all your cardboard boxes', 90, 'r1'));
    karmaTasks.add(new KarmaTask(KarmaCategory.recycling, 'Recycle all your plastic bottles', 70, 'r2'));
    karmaTasks.add(new KarmaTask(KarmaCategory.recycling, 'Recycle two pounds worth of material', 100, 'r3'));

    karmaTasks.add(new KarmaTask(KarmaCategory.water_usage, 'Save on water bill', 100, 'wu1'));
    karmaTasks.add(new KarmaTask(KarmaCategory.water_usage, 'Use sprinklers less often', 100, 'wu2'));
    karmaTasks.add(new KarmaTask(KarmaCategory.water_usage, 'Keep the faucet off when brushing', 20, 'wu3'));
  }

  static List<KarmaTask> getAllTasksInCategory(KarmaCategory category) {
    List<KarmaTask> newList = List<KarmaTask>();
    karmaTasks.forEach((element) {
      if (element.category == category) {
        newList.add(element);
      }
    });
    return newList;
  }

  static KarmaTask getKarmaById(String id) {
    for (int i = 0; i < karmaTasks.length; i++) {
      if (karmaTasks[i].id == id) {
        return karmaTasks[i];
      }
    }
    return null;
  }
}
