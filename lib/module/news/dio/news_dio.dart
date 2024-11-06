import 'package:dio/dio.dart';
import 'package:untitled/module/news/model/request/news_request_bean.dart';
import 'package:untitled/module/news/model/response/news_response_bean.dart';
import 'package:untitled/util/base_dio.dart';

class NewsDio extends BaseDio {
  Future<NewsResponseBean> getNewsData(NewsRequestBean newsRequestBean) async {
    Dio dio = await getBaseDio();
    NewsResponseBean newsResponseBean = NewsResponseBean();
    try {
      Response response = await dio.get(
        "/v2/everything",
        queryParameters: newsRequestBean.toJson(),
      );
      if (response.statusCode == 200) {
        newsResponseBean = NewsResponseBean.fromJson(response.data);
        newsResponseBean.isSuccessFull = true;
      } else {
        newsResponseBean.isSuccessFull = false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        newsResponseBean.isSuccessFull = false;
        newsResponseBean.errorMessage = "Something went wrong";
      } else {
        newsResponseBean.isSuccessFull = false;
        newsResponseBean.errorMessage = e.response!.statusMessage;
      }
    }
    return newsResponseBean;
  }
}
