import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


launchURLApp(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url, mode: LaunchMode.inAppWebView,);
  } else {
    throw 'Couldn\'t load site';
  }
}

Future getResponseData(String stock)async{
  DateTime date = DateTime.now().subtract(const Duration(days: 30));
  String fromDate = date.toString().substring(0, 11);
  final url = Uri.parse('https://newsapi.org/v2/everything?q=$stock&from=$fromDate&sortBy=popularity&language=en&apiKey=71bcfe13e327473db97a115020ae56d2');
  final response = await http.get(url);
  final resData = jsonDecode(response.body);
  return resData;
}

Widget getStockNews(context, resData){

  return Column(
      //.sublist(0,3)
      children: resData['articles'].sublist(0,3).map<Widget>((item) =>
          InkWell(
            onTap: (){launchURLApp(item['url']);},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['source']['name'], style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey)),
                Text(item['title'],maxLines: 4, overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),),
                Text('${DateTime.now().difference(DateTime.parse(item['publishedAt'])).inDays}d ago', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey)),
                const SizedBox(height: 14,)
              ],
            ),
          )
      ).toList());

  return ListView.builder(
    itemCount: resData['totalResults'] < 5 ? resData['totalResults']:5,
    shrinkWrap: true,
    itemBuilder: (context, index){
      return ListTile(
        textColor: Colors.white,
        onTap: (){launchURLApp(resData['articles'][index]['url']);},
        title: Text(resData['articles'][index]['title']),
        subtitle: Text(resData['articles'][index]['source']['name']),
      );
      },
  );
}


//   71bcfe13e327473db97a115020ae56d2