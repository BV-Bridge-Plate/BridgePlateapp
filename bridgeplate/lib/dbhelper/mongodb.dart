import 'dart:developer';
import 'package:bridgeplate/dbhelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, donationCollection;
  static var donorCollection, doneeCollection;
  static connect() async {
    db = await Db.create(MONG_CONN_URL);
    await db.open();
    inspect(db);
    donationCollection = db.collection(DONATION_COLLECTION);
  }

  static connect2() async {
    db = await Db.create(MONG_CONN_URL);
    await db.open();
    inspect(db);
    donorCollection = db.collection(DONOR_COLLECTION);
  }

  static connect3() async {
    db = await Db.create(MONG_CONN_URL);
    await db.open();
    inspect(db);
    doneeCollection = db.collection(DONEE_COLLECTION);
  }
}
