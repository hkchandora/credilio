import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled/module/news/bloc/news_bloc.dart';
import 'package:untitled/module/news/model/request/news_request_bean.dart';
import 'package:untitled/module/news/model/response/news_response_bean.dart';
import 'package:untitled/module/news/view/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final newsBloc = NewsBloc();

  @override
  void initState() {
    callApiToGetNewsList();
    super.initState();
  }

  @override
  void dispose() {
    newsBloc.dispose();
    super.dispose();
  }

  callApiToGetNewsList() async {
    NewsRequestBean newsRequestBean = NewsRequestBean(
      q: "Apple",
      apiKey: "14e1ece334414fbe87782f02a0661b23",
    );
    await newsBloc.getNewsData(newsRequestBean);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      backgroundColor: Colors.white,
      body: getData(),
    );
  }

  homeAppBar() {
    return AppBar(
      title: const Text("News"),
      backgroundColor: Colors.white,
    );
  }

  getData() async {
    return StreamBuilder<NewsResponseBean>(
      stream: newsBloc.newsList,
      builder: (context, AsyncSnapshot<NewsResponseBean> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return const Center(child: Text("No Data"));
          } else {
            return showNewsList(snapshot.data!);
          }
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const Center(child: Text("Loading..."));
        }
      },
    );
  }

  showNewsList(NewsResponseBean response) {
    ListView.builder(
        itemCount: response.articles!.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailsScreen(response.articles![index]),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: response.articles![index].urlToImage ??
                            "https://cdn.vox-cdn.com/thumbor/HrCFTBOBMrC5EZQO1at0ltS40K8=/0x530:7398x4403/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/23353770/1239503237.jpg",
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              response.articles![index].title.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(height: 20),
                            Text(response.articles![index].publishedAt
                                .toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
