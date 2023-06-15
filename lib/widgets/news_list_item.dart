import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'newsGet.dart';

var newsData = {};

Widget newsListItem(String stockName){
  dynamic response;
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
                SizedBox(height: 2.25.h,),
                ListTile(title: Text(stockName.toUpperCase(),style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white,fontWeight: FontWeight.bold)),),
                SizedBox(height: 2.25.h,),
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