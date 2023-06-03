import 'package:flutter/material.dart';
import 'package:stocks_app/screens/signin.dart';


class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var showSheet = true;
  @override
  Widget build(BuildContext context) {

    TextEditingController _searchTextController = TextEditingController();


    var month = {
      1:'Jan', 2:'Feb', 3:'Mar', 4:'Apr', 5:'May', 6:'June', 7:'July', 8:'Aug',
      9:'Sept', 10:'Oct', 11:'Nov', 12:'Dec',
    };

    var stocks = ['TCS', 'ITC', 'SAIL', 'ADANIPORTS'];

    Widget _newsListItem(String stockName){
      return ListTile(
        title: Text('Hola News of $stockName', style: const TextStyle(color: Colors.white),),
      );
    }


    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: double.infinity,
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
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5 ),
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
                                    IconButton(onPressed: (){},icon: const Icon(Icons.circle_sharp),color: Colors.grey.shade900.withOpacity(0.8),iconSize: 35,),
                                    const Icon(Icons.more_horiz, color: Colors.blueAccent,size: 30,),
                                  ]
                              )
                            ],
                          ),
                        ),

                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                child: TextField(
                                  onTap: ()=>setState(() {
                                    showSheet = false;
                                  }),
                                  onSubmitted: (event)=>setState(() {
                                    showSheet = true;
                                  }),
                                  maxLines: 1,
                                  controller: _searchTextController,
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                    prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 30),
                                    labelText:  'Search',
                                    labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.blueGrey.shade400.withOpacity(0.2),
                                    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))

                                  ),
                                ),
                              )
                            ],

                          ),
                        ),
                        Center(
                          child: TextButton(
                            child: const Text('Log Out'),
                            onPressed: ()=>Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()
                                ),
                                    (Route<dynamic> route) => false),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
          ),
          showSheet
              ?
          DraggableScrollableSheet(
              initialChildSize: 0.12,
              maxChildSize: 0.85,
              minChildSize: 0.12,
              // expand: true,
              snap: true,
              snapSizes: const [0.4, 0.85],
              snapAnimationDuration: const Duration(milliseconds: 200),
              builder: (context, controller)=>ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                child: Container(
                  color: Colors.black,
                  child:
                    CustomScrollView(
                      controller: controller,
                      slivers:[
                        SliverAppBar(
                          backgroundColor: Colors.white10,
                          // title:
                          flexibleSpace:  FlexibleSpaceBar(
                              title:  null,
                              background: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(width: double.infinity, alignment: Alignment.center, child: const Divider(color: Colors.white,indent: 170, endIndent: 170, thickness: 4,),),
                                    const SizedBox(height: 12,),
                                    Text('Business News', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold, ),textAlign: TextAlign.left),
                                    Text('By Usual Finance', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey), textAlign: TextAlign.left,),
                                  ],
                                ),
                              ),
                          ),
                        ),
                        // SliverFixedExtentList(
                        //   itemExtent: 2.0,
                          SliverAnimatedList(
                            initialItemCount: stocks.length,
                            itemBuilder: (context, index, animation) => _newsListItem(stocks[index]),
                        ),
                      ],
                    ),
                ),
              ),
              
          )
              :
          const SizedBox(height: 100,child: Text('',style: TextStyle(color: Colors.transparent)),)
        ],
      ),
    );


  }
}
