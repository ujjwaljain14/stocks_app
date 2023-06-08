import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

  var data = [];
  // data format
  // var list = [['Stock Symbol','Stock Name','Last Price','change','exchange','symbol to add or not']];
  late List<List<dynamic>> nse;
  late List<List<dynamic>> bse;

  loadCSV() async {
    final nseData = await rootBundle.loadString("./assets/stockslist/nse_list.csv");
    final bseData = await rootBundle.loadString("./assets/stockslist/bse_list.csv");
    nse = const CsvToListConverter().convert(nseData);
    bse = const CsvToListConverter().convert(bseData);
  }

  List<dynamic> search(String str){
    data.clear();
    nse.forEach((element) {
      if(element[0].toUpperCase().startsWith(str.toUpperCase()) && element[0]!='SYMBOL' && str!=''){
        var temp =[];
        temp.add(element[0]); //stock symbol
        temp.add(element[1]); //stock name
        // final finalUrl = Uri.parse('https://www.nseindia.com/api/quote-equity?symbol=$str&section=trade_info');
        // final response = await http.get(finalUrl);
        // final resData = jsonDecode(response.body);
        temp.add('0'); // last traded price  resData["marketDeptOrderBook"]["bid"][0]["price"]
        temp.add('0'); // change in rupee
        temp.add('NSE');// stock exchange
        temp.add(true);//stock to add or not
        data.add(temp);
      }
    });
    bse.forEach((element) {
      if(element[2].toUpperCase().startsWith(str.toUpperCase()) && element[2]!='Security Id' && str!=''){
        var temp =[];
        temp.add(element[2]); //stock symbol
        temp.add(element[3]); //stock name
        temp.add('0'); // last traded price
        temp.add('0'); // change in rupee
        temp.add('BSE');// stock exchange
        temp.add(true);//stock to add or not
        data.add(temp);
      }
    });
    print(data);
    return data;

  }