import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stocks_app/widgets/line_chart.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'newsGet.dart';


Future getHistoryData(String stock, String time)async{
  final response = await http.get(
    Uri.parse('http://10.0.2.2:5000/history?quote=$stock&time=$time'),
  );
  final resData = jsonDecode(response.body);
  return resData;
}

stockItem(BuildContext context, String symbol, String name, Map stockData){
//   String embededCode(String symbol) {
//     return '''
//       <!-- TradingView Widget BEGIN -->
//       <div class="tradingview-widget-container">
//         <div id="tradingview_187f2"></div>
//         <div class="tradingview-widget-copyright"><a href="https://in.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">Track all markets on TradingView</span></a></div>
//         <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
//         <script type="text/javascript">
//         new TradingView.widget(
//         {
//         "autosize": true,
//         "symbol": "NSE:TCS",
//         "interval": "D",
//         "timezone": "Etc/UTC",
//         "theme": "light",
//         "style": "1",
//         "locale": "in",
//         "toolbar_bg": "#f1f3f6",
//         "enable_publishing": false,
//         "backgroundColor": "rgba(0, 0, 0, 1)",
//         "withdateranges": true,
//         "hide_side_toolbar": false,
//         "container_id": "tradingview_187f2"
//       }
//         );
//         </script>
//       </div>
//       <!-- TradingView Widget END -->
//   ''';
//   }
//   // return WebView(
//   //     initialUrl: 'https://flutter.dev',
//   //     onWebViewCreated:
//   // (WebViewController webViewController) async {
//   //   _controller.complete(webViewController);
//   //   _loadHtmlString(_controller, context);
//   Future<void> _loadHtmlString(
//       WebViewController controller, BuildContext context) async {
//     await controller.loadHtmlString(embededCode(symbol));
//   }
//
//   // Future<Object> _loadHtmlString(
//   //     WebViewController controller, BuildContext context) async {
//   //   // WebViewController _controller = await controller.future;
//   //   // await _controller.loadHtmlString(embededCode(symbol));
//   //   // return WebViewWidget(
//   //   //   controller: _controller,
//   //   // );
//   //   print('insideshitty');
//   //   controller = WebViewController()..loadRequest(Uri.parse('https://flutter.dev'))..loadHtmlString(embededCode(symbol));
//   //   print('insideshity2');
//   //   return WebViewWidget(controller: controller);
//   // }

  var color = double.parse(stockData['change']) < 0 ? Colors.red : Colors.green;
  var duration = '1mo';
  return showModalBottomSheet(
      backgroundColor: Colors.black,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (context){
        return StatefulBuilder(builder: (context,state){
          return SingleChildScrollView(
            padding: EdgeInsets.all(2.h),
            child: SizedBox(
              height: 83.5.h,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(symbol, style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 3.2.h),),
                          SizedBox(
                            width: 30.h,
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                color: Colors.grey,
                                fontSize: 1.7.h,
                                height: 0.2.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.add_circle_outline,color: Colors.white,)),
                    ],
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.4),thickness: 1,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(width:20.w, child: Text(stockData['price'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 2.3.h),)),
                              SizedBox(height: 1.h,),
                              SizedBox(width: 20.w, child: Text('${stockData['exchange']}  ${stockData['currency']}', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 1.7.h),),)
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(width:20.w, child: Text(stockData['volume'], textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: color, fontWeight: FontWeight.bold,fontSize: 2.1.h),)),
                              SizedBox(height: 1.h,),
                              SizedBox(width: 20.w, child: Text('Vol', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 1.7.h),),)
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(width:20.w, child: Text(stockData['change'], textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: color, fontWeight: FontWeight.bold,fontSize: 2.1.h),)),
                              SizedBox(height: 1.h,),
                              SizedBox(width: 20.w, child: Text('Chg', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 1.7.h),),)
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(width:20.w, child: Text(stockData['percent_change']+'%', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: color, fontWeight: FontWeight.bold,fontSize: 2.1.h),)),
                              SizedBox(height: 1.h,),
                              SizedBox(width: 20.w, child: Text('% Chg', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 1.7.h),),)
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.4),thickness: 1,
                      ),
                      SizedBox(
                        height: 3.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: (duration == '1mo') ? Colors.grey : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                              ),
                              child: InkWell(
                                focusColor: Colors.grey,
                                onTap: (){
                                  state((){duration = '1mo';});
                                },
                                autofocus: true,
                                child: Container(
                                  padding: EdgeInsets.all(1.w),
                                  width: 10.w,
                                  child: Text('1M', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 1.7.h),),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.5.w,),
                            Container(
                              decoration: BoxDecoration(
                                color: (duration == '3mo') ? Colors.grey : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: InkWell(
                                focusColor: Colors.grey,
                                onTap: (){
                                  state((){duration = '3mo';});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1.w),
                                  width: 10.w,
                                  child: Text('3M', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 1.7.h),),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.5.w,),
                            Container(
                              decoration: BoxDecoration(
                                color: (duration == '6mo') ? Colors.grey : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: InkWell(
                                focusColor: Colors.grey,
                                onTap: (){
                                  state((){duration = '6mo';});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1.w),
                                  width: 10.w,
                                  child: Text('6M', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 1.7.h),),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.5.w,),
                            Container(
                              decoration: BoxDecoration(
                                color: (duration == '1y') ? Colors.grey : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: InkWell(
                                focusColor: Colors.grey,
                                onTap: (){
                                  state((){duration = '1y';});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1.w),
                                  width: 10.w,
                                  child: Text('1Y', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 1.7.h),),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.5.w,),
                            Container(
                              decoration: BoxDecoration(
                                color: (duration == '2y') ? Colors.grey : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: InkWell(
                                focusColor: Colors.grey,
                                onTap: (){
                                  state((){duration = '2y';});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1.w),
                                  width: 10.w,
                                  child: Text('2Y', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 1.7.h),),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.5.w,),
                            Container(
                              decoration: BoxDecoration(
                                color: (duration == '5y') ? Colors.grey : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: InkWell(
                                focusColor: Colors.grey,
                                onTap: (){
                                  state((){duration = '5y';});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1.w),
                                  width: 10.w,
                                  child: Text('5Y', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 1.7.h),),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.5.w,),
                            Container(
                              decoration: BoxDecoration(
                                color: (duration == '10y') ? Colors.grey : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: InkWell(
                                focusColor: Colors.grey,
                                onTap: (){
                                    state((){duration = '10y';});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1.w),
                                  width: 10.w,
                                  child: Text('10Y', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 1.7.h),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.4),thickness: 1,
                      ),
                      Container(
                        height: 30.h,
                        width: double.infinity,
                        color: Colors.transparent,
                        child:
                            FutureBuilder<dynamic>(
                              future: getHistoryData(symbol, duration),
                              builder: (context, snapshot){
                                if(snapshot.hasData){
                                  print(duration);
                                  return LineChartWidget(
                                    data: snapshot.data,
                                  );
                                }else{
                                  return const Center(child: CircularProgressIndicator(backgroundColor: Colors.white12, color: Colors.white,));
                                }
                              },
                            )
                        // child: const Center(child: Text('Graph', style: TextStyle(color:Colors.white),)),
                      ),
                      SizedBox(
                        height: 12.h,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            Container(
                              padding: EdgeInsets.all(2.w),
                              width: 40.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Open',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontSize: 2.h)),
                                      Text(stockData['open'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 1.8.h)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('High',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontSize: 2.h)),
                                      Text(stockData['high'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 1.8.h)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Low',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontSize: 2.h)),
                                      Text(stockData['low'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 1.8.h)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey.withOpacity(0.6),thickness: 1,
                              indent: 1.h,
                              endIndent: 1.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(3.w),
                              width: 40.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Vol',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontSize: 2.h)),
                                      Text(stockData['volume'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 1.8.h)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('P/E',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontSize: 2.h)),
                                      Text(stockData['p/e'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 1.8.h)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Mkt Cap',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontSize: 2.h)),
                                      Text(stockData['mcap'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 1.8.h)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey.withOpacity(0.6),thickness: 1,
                              indent: 1.h,
                              endIndent: 1.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(2.w),
                              width: 40.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('52W H',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontSize: 2.h)),
                                      Text(stockData['52weekhi'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 1.8.h)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('52W L',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontSize: 2.h)),
                                      Text(stockData['52weeklo'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 1.8.h)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Avg Vol',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontSize: 2.h)),
                                      Text(stockData['avgvol'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 1.8.h)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey.withOpacity(0.6),thickness: 1,
                              indent: 1.h,
                              endIndent: 1.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(2.w),
                              width: 40.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Yield',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontSize: 2.h)),
                                      Text(stockData['yield'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 1.8.h)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text('Beta',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontSize: 2.h)),
                                      Text(stockData['beta'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 1.8.h)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('EPS',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontSize: 2.h)), Text(stockData['eps'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 1.8.h)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey.withOpacity(0.6),thickness: 1,
                              indent: 1.h,
                              endIndent: 1.h,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.4),thickness: 1,
                      ),
                      Center(child:Text("Yahoo's analyst opinion",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 2.3.h))),
                      SizedBox(height: 2.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('Technicals',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 2.1.h)),
                              Text(stockData['recommendationKey'].toUpperCase(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: stockData['recommendationKey'].endsWith('buy') ? Colors.green : Colors.red,fontSize: 1.8.h))
                            ],
                          ),
                          Column(
                            children: [
                              Text('Target High',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 2.1.h),),
                              Text(stockData['targetHighPrice'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.green,fontSize: 2.h)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Target Low',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 2.1.h),),
                              Text(stockData['targetLowPrice'],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 2.h) )
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.4),thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: (){
                            var url = 'NSE-';
                            if(symbol.endsWith('.BO')){
                              url = 'BSE-';
                            }
                            late final WebViewController controller = WebViewController();
                            // _loadHtmlString(controller, context);
                            launchURLApp('https://www.tradingview.com/symbols/$url${symbol.substring(0,symbol.length-3)}/');
                            WebViewWidget(
                              controller: controller,
                            );
                          },
                              child: const Text('TradingView.in', style: TextStyle(color:Colors.blueAccent,fontWeight: FontWeight.bold),)),
                          TextButton(onPressed: (){launchURLApp('https://stockcharts.com/freecharts/pnf.php?c=${symbol.substring(0,symbol.length-3)}.in,P');}, child: const Text('StockCharts.com', style: TextStyle(color:Colors.blueAccent,fontWeight: FontWeight.bold),),),
                          TextButton(onPressed: (){launchURLApp('https://finance.yahoo.com/quote/$symbol');}, child: const Text('YahooFinance', style: TextStyle(color:Colors.blueAccent,fontWeight: FontWeight.bold),),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      }
  );
}