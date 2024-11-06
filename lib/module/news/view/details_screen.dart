import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled/module/news/bloc/news_bloc.dart';
import 'package:untitled/module/news/model/response/news_response_bean.dart';

class DetailsScreen extends StatelessWidget {
  Articles? articles;

  DetailsScreen(this.articles, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailsAppBar(),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              articles!.title!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          const SizedBox(height: 20),
          CachedNetworkImage(
            imageUrl: articles!.urlToImage ??
                "https://cdn.vox-cdn.com/thumbor/HrCFTBOBMrC5EZQO1at0ltS40K8=/0x530:7398x4403/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/23353770/1239503237.jpg",
            height: 150,
            width: 150,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 20),
          Text(articles!.description!),
          const SizedBox(height: 20),
          MaterialButton(
              child: const Text("Load URL"),
              onPressed: () async {
                await NewsBloc().launchUrlInBrowser(Uri.parse(articles!.url!));
              }),
          Text(articles!.url!),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  detailsAppBar() {
    return AppBar(
      title: const Text("Details"),
      backgroundColor: Colors.white,
    );
  }
}
