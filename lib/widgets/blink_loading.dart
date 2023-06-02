import 'package:flutter/material.dart';


// loaderOn(BuildContext context) {
//   showDialog(context: context,
//       builder: (BuildContext dialogContext) {
//       return Container(
//         height: 6,
//         width: 6,
//         alignment: Alignment.center,
//         child:
//             Icon(Icons.currency_rupee_sharp, color: Colors.green.shade400,)
//             Icon(Icons.currency_rupee_sharp, color: Colors.transparent,)
//             // Image.asset('./assets/gif/loader.gif', fit: BoxFit.fill,),
//       );
//   });
// }


class BlinkLoading extends StatefulWidget{
  @override
  _BlinkLoadingState createState() => _BlinkLoadingState();
}
class _BlinkLoadingState extends State<BlinkLoading> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animationController.repeat(reverse: true);
    super.initState();
    _navigatewait();
  }

  _navigatewait()async{
    await Future.delayed(const Duration(seconds: 5),(){});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          height: double.infinity,
          alignment: Alignment.center,
          decoration: const  BoxDecoration(
            gradient: LinearGradient(colors: [ Colors.black, Colors.black87,],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: FadeTransition(
            opacity: _animationController,
            child: Icon(Icons.currency_rupee_sharp, color: Colors.green.shade800,size: 50,)
      ),
        )
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
