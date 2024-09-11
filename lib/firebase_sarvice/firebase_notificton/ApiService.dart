import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:googleapis_auth/auth_io.dart';

class ApiService {
  ApiService._();

  static ApiService apiService = ApiService._();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static const String baseUrl =
      'https://fcm.googleapis.com/v1/projects/chatbox-48c70/messages:send';

  // Future<String> getServerToken() async {
  //   final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
  //   final privateKey = jsonEncode(appJson);
  //   final client = ServiceAccountCredentials.fromJson(privateKey);
  //
  //   final servicesClient = await clientViaServiceAccount(client, scopes);
  //
  //   String serverToken = servicesClient.credentials.accessToken.data;
  //   log("Server Token: \n $serverToken \n \n");
  //   return serverToken;
  // }

  // onclick method call
  Future<void> sendMessage(String title, String body, String token) async {
    String accessToken = await getAccessToken();
    Map notification = {
      "message": {
        "token": token, // Use a va
        // lid FCM token here
        "notification": {
          "title": title,
          "body": body,
        },
        "data": {"response": "Message Done !"}
      }
    };

    final jsonNotification = jsonEncode(notification);
    try {
      // String serverToken = getServerToken().toString();
      String serverToken = 'ya29.a0AcM612z7uKwkapv1QzRBKbza3KDaLpubpby4XDZZxEMDNnZQrHgJbx6gbADpKQvYv7tO8xQeKZtbqCtPPSvkl_EktiHcOIaPFmnnR8QJC3OT4DLqbyu4BXM4w6C_But3cjfI4m1y2SWlmsiZGYbwrgUKKGavqwYhiP8llyE1aCgYKAeISARESFQHGX2MiycuBxdxYzQcnlSfV9DY-pg0175';
     log('$title----------------------------$body-------------$token');
      var response = await http.post(Uri.parse(baseUrl),
          body: jsonNotification,
          headers: <String, String>{
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        log('Successfully sent message: ${response.body}');
      } else {
        log('Error sending message: ${response.body}');
      }
    } catch (e) {
      log("Api error: ${e.toString()}");
    }
  }

  Future<String> getAccessToken() async {
    // Load the service account credentials from the JSON file
    var accountCredentials = ServiceAccountCredentials.fromJson(appJson);

    // Define the scopes required for FCM (Cloud Platform scope)
    var scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    // Use the credentials to get an authenticated client
    var authClient = await clientViaServiceAccount(accountCredentials, scopes);

    // Return the OAuth 2.0 access token
    return authClient.credentials.accessToken.data;
  }
}

String serverKey = 'ya29.a0AcM612y8vcEOviC7oTgvnFc1reuCvZmOAP7dMG8NXP9_3sbRUV649SbM2hKZg8DbRHylOzkhbg2MJyE1bTHy902-zi0Rrt9eMxajcpGDLg8A8Smd2Jq70Fuivit5yhaai3Iu77d3s3QNK3nNzXThg3NvyQQSQBapIrq9O5kYaCgYKAaYSARESFQHGX2MiWdMg9cq34yVxTC31L5_WdA0175';
final appJson = {
  "type": "service_account",
  "project_id": "chatbox-48c70",
  "private_key_id": "475fb6a0028fb902f2a3590dfa35dac3f152be34",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC83MT8vB45Zhm6\n0RyqptyZ+9YP8CNwdoYB0g3mPQXon0PBC7OBzhPjeBh+QE5Io8oXosKnLB2n9qJf\nayHGnNnlUryPHAxMV0KTX+sEx2uzZAdNvaQseD2kuxv0nSHuhygV02WZGRoTWS47\nlIKnuZaJ/ezidvasO6r3kNe8BOl8npf7dn+pYPvb7EW0NW4hPKiCav7zIcW/h4Jt\nLnDUrAd/GqzEY59dbWzK35JqhrNgfhGVINjByant8kuRwVGDG1h0SwABOBUlSeqB\n5Q8ZP8fEqfqzjza2A+hntbykeHNcJZWOx6SrHLHYft04nIrmrwuH72LDhexLmaf9\nDFHKuLClAgMBAAECggEAV/wTy1hKTlxKBVXxIHFvGU+RGMi7geO9p3B36DiqnYZA\n9tjgLktWyaSD6KFFtyKS/jLlsyLiyAKm/4P17sTY4DSMwrEC67fFPMo1P3s2KhMi\nMe3044C62xkOO4XOroSJwK1Eyi+/DZ+A4eHcgo3721qQNqrMXU3I5t+0GZRCQDsG\nCLUO2uCjFeqJRxzz8hVTkjpk19BL59JtBQSjmbo7el6cayTvXBzTerqnpvkGgBcx\nDYOi52kcOOhT9/9EoU57LOSdTYjOnk9YYgeRr601ueq3w6Of+qT/dTcBypOBeXmk\n1G5Ms8H80V6rDhuA5yF/zdb9EaWT1Okn7xSB75fCCwKBgQD2WFvE+1GgdwXgYKo6\n0rPPWj7A2rHumzWe/+6gqrfVOjOiELLObXpajw9YeNQRBNvrdUE+3dGYoP/pQeN1\nEo049JZGA3k5poUEt0e8O0XDP2n8zAcA9MO8ksT2kBM+PMDV4/Zd+XUOWdvFvjhU\nnGAOjIsU48E77tWnoVvJSZGAvwKBgQDEQ6wXa5xTlD5fG5cUxwjArVYHDDCSON9V\nJmi62dN8UHbhXfL56/YCYs0vBIdNR+CSis6jsA8HN7yxb7skkKBDf/4oqBCQ2lXg\nledtNcQkXWbZfZH/i4Vrl5OoD7sdBmF4zXmTC5nbjWYK8MaVDuLr5jwLoQUCPnra\nlkDrRsKDmwKBgC+YRrK6M70jAdmmE32l8+Od9f3gwvvstOFxZTNZiIcD5bHsM/+6\nGyef+EEJpz9ahvro/qAcz0AD6y2v8zhNS0ezyczhIuzGhXCx0IRHl2TvvZR//uJq\nZ97pJHDWyUD/D+rDTng9mCYbqmB8Lfn69HwbH0v77PudW141yLwNILWVAoGAeIvM\nHpJ08Qzjhk0O7a8WHCoa5bdB+f2+hrFRsDpsYDWX3vJyc7jPYEXJGvDgHcJhGADz\nzKwtftRoLF+hBWNjXDI4LEaV7jJ8frXz8CsO7vsDWeB7lQbgCuaNxbLrzXcG1Uj3\nPC7q8GQX4e5jOlhrXlMKXGYpCmjP0oRpGVlbzbMCgYEAozE/Ul4psBlJBL+7jkll\nIyd8zQCkz5D4CMamgndMgPGhdp6PfSdn76RjegzypdWFIQALMWqO3mfCxjgRkGXl\nYWKLXxgKCD0kUH1Wn/ckvXjYFAqVRInxVck8ebLXABtc9TMt7KcW0ZsvW+gubLOU\nK+RpZeKd61BA6Zkv4FISqbs=\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-7k4rk@chatbox-48c70.iam.gserviceaccount.com",
  "client_id": "106332125849553441561",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-7k4rk%40chatbox-48c70.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
};