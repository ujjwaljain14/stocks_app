import 'package:flutter/material.dart';
import 'newsGet.dart';

var newsData = {};

Widget newsListItem(String stockName){
  var response;
  if(newsData.containsKey(stockName)){
    response = newsData[stockName];
  }else{
    try {
      response = getResponseData(stockName);
    }catch(e){
      return const ListTile();
    }
    newsData[stockName] = response;
  }

  return ListTile(
    title: FutureBuilder(
      future: response,
      builder: (context, AsyncSnapshot snapshot){
        if(snapshot.hasData && snapshot.data['articles'].length!=0){
          return Column(
              children: [
                const SizedBox(height: 20,),
                ListTile(title: Text(stockName.toUpperCase(),style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white,fontWeight: FontWeight.bold)),),
                const SizedBox(height: 20,),
                getStockNews(context, snapshot.data),
                Divider(color: Colors.white.withOpacity(0.6),thickness: 2,)
              ]
          );
        }else{
          return const Text('');
        }
      },
    ),

  );


}