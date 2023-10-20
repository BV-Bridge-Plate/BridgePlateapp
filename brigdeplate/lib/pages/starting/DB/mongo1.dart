import 'dart:developer';
import 'package:bridgeplate/dbhelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';



class MongoDatabase1 {
  static Db? db;
  static DbCollection? doneeCollection;

  static Future<void> connect() async {
    db = await Db.create(MONG_CONN_URL);
    await db?.open();
    inspect(db);
    doneeCollection = db?.collection(DONEE_COLLECTION);
  }

  static Future<int> fetchLatestdoneeId() async {
    try {
      var result = await doneeCollection
          ?.find(where.sortBy('id', descending: true))
          .toList();
      if (result != null) {
        var latestdonee = result?.first;
        int latestdoneeId = latestdonee?['id'] as int;
        return latestdoneeId;
      }
      return 0; // If no donees exist, start from 0
    } catch (e) {
      print("Error fetching latest donee: $e");
      return 0; // Handle errors by starting from 0
    }
  }

  static Future<void> insertdonee(Map<String, dynamic> doneeData) async {
    await doneeCollection?.insert(doneeData);
  }
}
