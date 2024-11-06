import 'package:untitled/module/news/dio/news_dio.dart';
import 'package:untitled/module/news/model/request/news_request_bean.dart';
import 'package:untitled/module/news/model/response/news_response_bean.dart';

class NewsRepository {
  NewsDio newsDio = NewsDio();

  Future<NewsResponseBean> getNewData(NewsRequestBean newsRequestBean) =>
      newsDio.getNewsData(newsRequestBean);
}
