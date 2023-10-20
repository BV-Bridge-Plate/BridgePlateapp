import 'package:bridgeplate/dbhelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DetailService {
  static Future<Map<String, dynamic>?> fetchDetailsByUserId(
      String userId) async {
    // Assuming you have your MongoDatabase set up somewhere, either import it or initialize here.
    try {
      await MongoDatabase.connect2();
      var doc = await MongoDatabase.donorCollection
          .findOne(where.eq('userid', userId));
      return doc;
    } catch (error) {
      print('Error fetching details: $error');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchDonationDetailsByUserId(
      String userId) async {
    // Assuming you have your MongoDatabase set up somewhere, either import it or initialize here.
    try {
      await MongoDatabase.connect();
      var doc = await MongoDatabase.donationCollection
          .findOne(where.eq('donerid', userId));
      return doc;
    } catch (error) {
      print('Error fetching details: $error');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchDetailsByUserPhone(
      String phone) async {
    try {
      await MongoDatabase.connect3();
      phone = '8765432109';

      var phoneInt = int.parse(phone);
      var doc = await MongoDatabase.doneeCollection
          .findOne(where.eq('phone', phoneInt));
      return doc;
    } catch (error) {
      print('Error fetching details: $error');
      return null;
    }
  }
}
