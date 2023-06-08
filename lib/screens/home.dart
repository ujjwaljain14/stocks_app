import 'package:flutter/material.dart';
import 'package:stocks_app/screens/signin.dart';
import 'package:stocks_app/widgets/search_data.dart';
import '../widgets/news_list_item.dart';
import 'package:sizer/sizer.dart';


class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    loadingCsv();
  }

  void loadingCsv() async{
    await loadCSV();
  }

  var _showSheet = true;
  var _showSearchItems = false;

  final TextEditingController _searchTextController = TextEditingController();

  var newsStocks = ['RELIANCE', 'Adani ports','sail'];
  var stocks = ['RELIANCE', 'Adani ports','sail'];
  final month = {
    1:'Jan', 2:'Feb', 3:'Mar', 4:'Apr', 5:'May', 6:'June', 7:'July', 8:'Aug',
    9:'Sept', 10:'Oct', 11:'Nov', 12:'Dec',
  };
  var stocksList = [];

  @override
  Widget build(BuildContext context) {
    var x=[];

    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: double.infinity.h,
              color: Colors.black,
              // decoration: const  BoxDecoration(
              //   gradient: LinearGradient(colors:
              //   [ Colors.black, Colors.black87,],
              //   //   [ Color(0xff000000), Color(0xff130F40),],
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //   ),
              // ),
            child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).padding.top,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*0.16 - MediaQuery.of(context).padding.top,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 1.12.h, right: 1.12.h, bottom: 0.56.h ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Stocks",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                                  Text("${DateTime.now().day} ${month[DateTime.now().month]}",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.circle_sharp,color: Colors.grey.shade900.withOpacity(0.8),size: 3.93.h,),
                                    IconButton(
                                      onPressed: (){
                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) => const SignInScreen()
                                            ),
                                                (Route<dynamic> route) => false);
                                      },
                                      icon: const Icon(Icons.more_horiz), color: Colors.blueAccent,iconSize: 3.37.h,),
                                  ]
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.12.h, horizontal: 1.12.h),
                          child: TextField(
                            onTap: ()=>setState(() {
                              _showSheet = false;
                              _showSearchItems = true;
                            }),
                            onChanged: (value){
                              x = search(_searchTextController.text);
                              // x = await search(_searchTextController.text).whenComplete(() => search);
                              setState(() {
                                stocksList = x;
                              });
                            },
                            onSubmitted: (event)=>setState(() {
                              _searchTextController.clear();
                              _showSheet = true;
                              _showSearchItems = false;
                            }),
                            style: const TextStyle(color: Colors.white),
                            maxLines: 1,
                            controller: _searchTextController,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 3.37.h),
                                labelText:  'Search',
                                labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.blueGrey.shade400.withOpacity(0.2),
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(1.68.h)))

                            ),
                          ),
                        ),
                        Visibility(
                          maintainSize: false,
                          visible: _showSearchItems,
                          child: SizedBox(
                            height: MediaQuery.of(context).viewInsets.bottom != 0 ? 40.5.h : 75.5.h,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: stocksList.length,
                                itemBuilder: (context,index){
                                  return
                                    ListTile(
                                      title: Text(stocksList[index][0],style: const TextStyle(color: Colors.white),),
                                      subtitle: Text(stocksList[index][1],style: const TextStyle(color: Colors.white)),
                                      leading:
                                        stocksList[index][5]
                                      ?
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Icon(Icons.circle_sharp, color: Colors.blueGrey.withOpacity(0.3), size: 3.h,),
                                              IconButton(onPressed: (){
                                                setState(() {
                                                  stocksList[index][5] = false;
                                                  newsStocks.add(stocksList[index][0]);
                                                  if(stocksList[index][4] =='NSE'){
                                                    stocks.add('${stocksList[index][0]}.NS');
                                                  }else{
                                                    stocks.add('${stocksList[index][0]}.BO');
                                                  }

                                                });
                                              }, icon: Icon(Icons.add, color: Colors.blueAccent, size: 2.4.h,),)
                                            ],
                                          )
                                      :
                                              IconButton(onPressed: (){
                                                setState(() {
                                                  stocksList[index][5] = true;
                                                  newsStocks.remove(stocksList[index][0]);
                                                  if(stocksList[index][4] =='NSE'){
                                                    stocks.remove('${stocksList[index][0]}.NS');
                                                  }else{
                                                    stocks.remove('${stocksList[index][0]}.BO');
                                                  }
                                                });
                                              }, icon: Icon(Icons.check_circle),color: Colors.blue.shade500,iconSize: 2.5.h),

                                      trailing: Text(stocksList[index][4],style: const TextStyle(color: Colors.white)),
                                  );
                                }),
                          ),
                        ),
                        // Visibility(
                        //   visible: !_showSearchItems,
                        //   child: Center(
                        //     child: TextButton(
                        //       child: const Text('Log Out'),
                        //       onPressed: ()=>Navigator.of(context).pushAndRemoveUntil(
                        //           MaterialPageRoute(
                        //               builder: (context) => const SignInScreen()
                        //           ),
                        //               (Route<dynamic> route) => false),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                )
          ),
          _showSheet
              ?
          DraggableScrollableSheet(
              initialChildSize: 0.14,
              maxChildSize: 0.85,
              minChildSize: 0.14,
              // expand: true,
              snap: true,
              snapSizes: const [0.35, 0.85],
              snapAnimationDuration: const Duration(milliseconds: 200),
              builder: (context, controller)=>ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(1.35.h), topRight: Radius.circular(1.35.h)),
                child: Container(
                  color: Colors.black,
                  child:
                    CustomScrollView(
                      controller: controller,
                      slivers:[
                        SliverAppBar(
                          collapsedHeight: 9.h,
                          backgroundColor: Colors.white10,
                          flexibleSpace:  FlexibleSpaceBar(
                              title:  null,
                              background: Padding(
                                padding: EdgeInsets.only(left: 1.125.h, right: 1.125.h, top: 1.125.h, bottom: 2.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(width: double.infinity.w, alignment: Alignment.center, child: Divider(color: Colors.white,indent: 41.36.w, endIndent: 41.36.w, thickness: 0.45.h,),),
                                    SizedBox(height: 1.35.h,),
                                    Text('Business News', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold, ),textAlign: TextAlign.left),
                                    Text('By Usual Finance', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey), textAlign: TextAlign.left,),
                                  ],
                                ),
                              ),
                          ),
                        ),
                          SliverAnimatedList(
                            initialItemCount: newsStocks.length,
                            itemBuilder: (context, index, animation) => newsListItem(newsStocks[index]),
                        ),
                      ],
                    ),
                ),
              ),
              
          )
              :
          SizedBox(height: 11.25.h,child: const Text('',style: TextStyle(color: Colors.transparent)),)
        ],
      ),
    );


  }
}

