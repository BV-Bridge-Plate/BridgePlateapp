import 'package:http/http.dart' as http;

Future<void> sendNotifications() async {
    final response = await http.post(Uri.parse('http://localhost:3000/sendNotificationsToDonees'));
    if (response.statusCode == 200) {
        print('Notifications sent successfully');
    } else {
        throw Exception('Failed to send notifications');
    }
}