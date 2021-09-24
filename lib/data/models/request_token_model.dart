class RequestTokenModel {
  final bool success;
  final String expiresAt;
  final String requestToken;

  RequestTokenModel({
    this.success,
    this.expiresAt,
    this.requestToken,
  });

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) {
    return RequestTokenModel(
        expiresAt: json['expires_at'],
        requestToken: json['request_token'],
        success: json['success']);
  }

  Map<String, dynamic> toJson() {
    return {
      'request_token': requestToken,
    };
  }
}
