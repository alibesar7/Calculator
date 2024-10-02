import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
      home: const MyHomePage( ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
     List<String>bot=[
       "C",
       "Del",
       "%",
       "/",
       "9",
       "8",
       "7",
       "*",
       "6",
       "5",
       "4",
       "+",
       "3",
       "2",
       "1",
       "-",
       ".",
       "0",
       "Ans",
       "=",
     ];
     String input="";
     String output="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text("Calculator",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
       centerTitle: true,
       backgroundColor: Colors.blue,

     ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(5),
              width: double.infinity,
              child: Text(
                input,
                textAlign: TextAlign.left,
                style:const TextStyle(fontSize: 40,fontWeight: FontWeight.w300,color: Colors.black),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(5),
              width: double.infinity,
              child: Text(
                 output,
                textAlign: TextAlign.right,
                style:  const TextStyle(fontSize: 40,fontWeight: FontWeight.w400,color: Colors.deepOrange),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: bot.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder:( context,index){
                 return InkWell(
                   onTap: (){
                     if(bot[index]=="C"){
                      setState(() {
                        input="";
                        output="";
                      });
                     }else if(bot[index]=="Del"){
                       setState(() {
                         input=input.substring(0,input.length-1);
                       });
                     }
                     else if(bot[index]=="Ans"){
                      setState(() {
                        input=output;
                        output="";
                      });
                     }else if (bot[index]=="%"||
                         bot[index]=="/"||
                         bot[index]=="*"||
                         bot[index]=="+"||
                         bot[index]=="-"){
                       if(input.endsWith("/")||input.endsWith("%")||input.endsWith("*")||
                           input.endsWith("+")||input.endsWith("-")){
                         null;
                       }else {
                         setState(() {
                           input+=bot[index];
                         });
                       }

                     }else if (bot[index]=="="){
                       Parser p = Parser();
                       Expression exp = p.parse(input);
                       double res=exp.evaluate(EvaluationType.REAL, ContextModel());
                       setState(() {
                         output=res.toString();
                       });
                     }else{
                       setState(() {
                         input+=bot[index];
                       });
                     }
                   },
                   child: Container(
                     margin: EdgeInsets.all(5),
                     alignment: Alignment.center,
                     child: Text(bot[index],style:
                       TextStyle(
                         color: colortext(bot[index]),
                         fontSize: 25,
                         fontWeight: FontWeight.w300
                       ),),
                     decoration: BoxDecoration(
                       color:  mybackgroundcolor(bot[index]),
                       borderRadius: BorderRadius.circular(20)
                     ),
                   ),
                 );
                }),
          )

        ],
      ),

    );
  }
}
Color mybackgroundcolor(String s){
  if(s=="C"){
    return Colors.teal.shade300;
  }else if(s=="Del"){
    return Colors.deepOrangeAccent.shade200;
  }else if(s=="%"||s=="/"||s=="*"||s=="+"||s=="-"||s=="="){
    return Colors.blue.shade400;
  }
  else{
    return Colors.grey.shade300;
  }
}
Color colortext(String s){
  if(s=="C"||s=="Del"||s=="%"||s=="+"||s=="-"||s=="="||s=="/"||s=="*"){
    return Colors.white;
  }else{
    return Colors.black;
  }
}