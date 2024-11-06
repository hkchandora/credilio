import 'dart:async';

import 'package:untitled/module/news/model/request/news_request_bean.dart';
import 'package:untitled/module/news/model/response/news_response_bean.dart';
import 'package:untitled/module/news/repository/news_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsBloc {
  NewsRepository repository = NewsRepository();

  final newsController = StreamController<List<Articles>>.broadcast();
  get newsList => newsController.stream;

  Future<NewsResponseBean> getNewsData(NewsRequestBean newsRequestBean) async {
    NewsResponseBean wrapper = await repository.getNewData(newsRequestBean);
    if (wrapper.isSuccessFull!) {
      newsController.sink.add(wrapper.articles!);
    } else {
      newsController.sink.addError(wrapper.errorMessage!);
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
    newsController.close();
  }
}
