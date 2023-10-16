class ApiResponse {
  String? src;

  ApiResponse({this.src});

  ApiResponse.fromJson(dynamic json) {
    src = json['src'] as String;
  }
}

class Src {
  String? tiny;

  Src({this.tiny});

  Src.fromJson(Map<String, dynamic> json) {
    tiny = json['tiny'];
  }
}
