class NewsRequestBean {
  String? q;
  String? apiKey;

  NewsRequestBean({this.q, this.apiKey});

  NewsRequestBean.fromJson(Map<String, dynamic> json) {
    q = json['q'];
    apiKey = json['apiKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['q'] = q;
    data['apiKey'] = apiKey;
    return data;
  }
}
