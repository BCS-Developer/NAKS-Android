class TokenManager {
  static String? _tenetId;

  // Set the tenet_id
  static void setTenetId(String tenetId) {
    _tenetId = tenetId;
  }

  // Get the tenet_id
  static String? getTenetId() {
    return _tenetId;
  }
}
