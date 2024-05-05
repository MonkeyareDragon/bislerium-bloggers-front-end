// common.UrlUtil
class UrlUtil {
  static String getImageUrl(String imageid) {
    String baseUrl = 'https://localhost:7283/image';

    return '$baseUrl/$imageid';
  }
}

class ApiUrlHelper {
  static const String baseUrl = 'https://127.0.0.1:5181';
  // static const String baseUrl = 'http://192.168.1.79:8000/';

  static Uri buildUrl(String path) {
    return Uri.parse('$baseUrl/$path');
  }
}
