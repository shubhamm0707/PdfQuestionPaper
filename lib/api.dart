import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uidesign_pdf/details.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _url = "https://owlbot.info/api/v4/dictionary/";
  String _token = "YOUR API KEY HERE";

  TextEditingController _controller = TextEditingController();

  StreamController _streamController;
  Stream _stream;

  Timer _debounce;
  List<Detail> details = [];
  Map<String,List<Map<String,String>>> map_list={};

  _search() async {

    print("hey====================================================================================================");

    // if (_controller.text == null || _controller.text.length == 0) {
    //   _streamController.add(null);
    //   return;
    // }

    _streamController.add("waiting");

    var url="http://labsmart-global-lis-staging.herokuapp.com/doc_app/v1/doctor_access/labs/1/reports?page=1&q=${_controller.text}";
    var response= await http.get(Uri.parse(url),
        headers: {
          'access-token': "ZgCy1vaRiyyBRpgo_B35SQ",  //P1cmCdEoXrfr12UDbekpUg
          'uid':"doc_5@mailinator.com",  //doc_5@mailinator.com
          'client':"ITCGUQbyqNLkJrcOG04FqA",  //kkPCdg5JPfSl7Em2fh-Rbg
          'token-type':'Bearer',
          'content-type': 'application/json'
        }

    );

    var jsonData= jsonDecode(response.body);


    if (response.statusCode == 200) {

      details=[];

      for (MapEntry u in jsonData['cases'].entries) {

        Detail detail = new Detail(u.value['patient']['name'], u.value['patient']['age'],
            u.value['patient']['mobile_number'], u.value['date'] ,u.value['patient']['sex'],u.key);

           details.add(detail);
      }

      _streamController.add(details);

    } else {
      print('error');
    }
  }

  @override
  void initState() {
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;

    _search();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flictionary"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextFormField(
                    onChanged: (String text) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000), () {
                      });
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Search for a word",
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  _search();
                },
              )
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: _stream,
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text("Enter a search word"),
              );
            }

            if (snapshot.data == "waiting") {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListBody(
                  children: <Widget>[
                    Container(
                      color: Colors.grey[300],
                      child: ListTile(
                        title: Text(_controller.text.trim() + "(" + snapshot.data[index].name + ")"),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}