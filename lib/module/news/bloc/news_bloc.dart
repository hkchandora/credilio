import 'dart:async';

import 'package:untitled/module/news/model/request/news_request_bean.dart';
import 'package:untitled/module/news/model/response/news_response_bean.dart';
import 'package:untitled/module/news/repository/news_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsBloc {
  NewsRepository repository = NewsRepository();

  /// Created a SteamController
  final newsController = StreamController<List<Articles>>.broadcast();

  /// Stream the data from the stream controller
  get newsList => newsController.stream;

  Future<NewsResponseBean> getNewsData(NewsRequestBean newsRequestBean) async {
    NewsResponseBean wrapper = await repository.getNewData(newsRequestBean);
    if (wrapper.isSuccessFull!) {
      newsController.sink.add(wrapper.articles!); /// Sink the data into StreamController
    } else {
      newsController.sink.addError(wrapper.errorMessage!); /// Sink the error into StreamController
    }
    return wrapper;
  }

  Future<void> launchUrlInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void dispose() {
    newsController.close(); /// Dispose the streamController
  }
}
