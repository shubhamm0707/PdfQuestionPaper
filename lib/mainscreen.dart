import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pdf/pdf.dart';
import 'package:uidesign_pdf/model.dart';
import 'package:uidesign_pdf/pdf_api.dart';
import 'package:uidesign_pdf/pdf_paragraph_api.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';


class PaymentPage extends StatefulWidget {

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController controller = TextEditingController();
  TextEditingController school = TextEditingController();
  TextEditingController classs = TextEditingController();
  TextEditingController test = TextEditingController();
  TextEditingController marks = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController footer = TextEditingController();
  TextEditingController pdf = TextEditingController();
  TextEditingController ans = TextEditingController();

  String watermark = "GRM";
  String schoolName = "Shool GRM";
  String className = "Class-12th Maths";
  String testName = "Unit Test";
  String marksName = "Marks: 100";
  String dateName = "20/12/2021";
  String timeName = "3.00 hrs";
  String footerName="";
  String pdfname="";
  String ansname="";


  void func() {
    setState(() {
      watermark = controller.text;
      schoolName = school.text;
      className = classs.text;
      testName = test.text;
      marksName = marks.text;
      dateName = date.text;
      timeName = time.text;
      footerName=footer.text;
      pdfname=pdf.text;
      ansname=ans.text;
    });
  }

  void Erase() {
    setState(() {
      controller.clear();
      school.clear();
      classs.clear();
      test.clear();
      time.clear();
      date.clear();
      marks.clear();
    });
  }

  List list;
  List<List<Uint8List>> answers;
  List<int> listTotal=[];
  String s;
  bool value=false;



  make() async
  {
    final image1 = (await rootBundle.load('assets/picc1.JPG')).buffer
        .asUint8List();
    final image2 = (await rootBundle.load('assets/picc5.JPG')).buffer
        .asUint8List();
    final image3 = (await rootBundle.load('assets/picc4.JPG')).buffer
        .asUint8List();
    final image4 = (await rootBundle.load('assets/picc2.JPG')).buffer
        .asUint8List();
    final image5 = (await rootBundle.load('assets/picc3.JPG')).buffer
        .asUint8List();

    final ans1 = (await rootBundle.load('assets/ans1.JPG')).buffer
        .asUint8List();
    final ans2 = (await rootBundle.load('assets/ans2.JPG')).buffer
        .asUint8List();
    final ans31 = (await rootBundle.load('assets/ans31.JPG')).buffer
        .asUint8List();
    final ans32 = (await rootBundle.load('assets/ans32.JPG')).buffer
        .asUint8List();
    final ans41 = (await rootBundle.load('assets/ans41.JPG')).buffer
        .asUint8List();

    final ans51 = (await rootBundle.load('assets/ans51.JPG')).buffer
        .asUint8List();
    final ans52 = (await rootBundle.load('assets/ans52.JPG')).buffer
        .asUint8List();
    final ans53 = (await rootBundle.load('assets/ans53.JPG')).buffer
        .asUint8List();
    final ans54 = (await rootBundle.load('assets/ans54.JPG')).buffer
        .asUint8List();
    final ans55 = (await rootBundle.load('assets/ans55.JPG')).buffer
        .asUint8List();
    final ans6 = (await rootBundle.load('assets/ans6.JPG')).buffer
        .asUint8List();




        list=[image1,image2,image3,image4,image5,image1,image3,image3,image3];
        answers=[[ans1],[ans31,ans32],[ans41],[ans2],[ans51,ans52,ans53,ans54,ans55],[ans6]];


  }


  bool showList=true;
  
  List<String> allQ=["assets/picc1.JPG","assets/picc5.JPG","assets/picc4.JPG","assets/picc2.JPG",
    "assets/picc3.JPG","assets/picc1.JPG","assets/picc1.JPG","assets/picc1.JPG"
  ];

  List<AllData> allQu=[AllData(img: "assets/picc1.JPG",text: "Abody falling from rest"),
    AllData(img: "assets/picc5.JPG",text: "A body A is thrown up"),
    AllData(img: "assets/picc4.JPG",text: "When a ball is thrown vertically upwards"),
    AllData(img: "assets/picc2.JPG",text: "What will be ratio in the first"),
    AllData(img: "assets/picc3.JPG",text: "As acceleration (g) remains constant"),
    AllData(img: "assets/picc1.JPG",text: "Abody falling from rest"),
  ];

  List<AllData> finalList=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3D84B8),
        title: Text('Pdf Generator', style: GoogleFonts.acme(),),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => ZoomDrawer.of(context).toggle(),
        ),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search Question"
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
                itemCount:6,
                itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  onTap: () {
                    listTotal.contains(index) ? listTotal.remove(index) : listTotal.add(index);
                    setState(() {

                    });
                  },
                  tileColor: listTotal.contains(index)?Colors.blue : Colors.grey,
                  title: Column(
                    children: [
                      Text("Question: ${index+1}",style: TextStyle(
                          color: Colors.white
                      ),),
                      Image.asset(allQu[index].img)

                    ],
                  )
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.create_new_folder_outlined),
        label: Text("Create PDF", style: GoogleFonts.acme(),),
        backgroundColor: Color(0xff082032),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 300,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Set Title",
                                    style: GoogleFonts.acme(),
                                  ).text
                                      .color(Color(0xff344FA1))
                                      .bold
                                      .size(20)
                                      .make(),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0), child: Text("Header Inputs",
                                      style: GoogleFonts.balsamiqSans(),).text
                                        .color(Colors.white).size(20).make(),
                                  ),
                                  color: Color(0xff344FA1),
                                ),
                                TextFormField(
                                  controller: school,
                                  style: GoogleFonts.acme(),
                                  decoration: InputDecoration(
                                      hintText: "School GRM",
                                      hintStyle: TextStyle(
                                          color: Color(0xff848482).withOpacity(
                                              0.5)
                                      )
                                  ),
                                ),
                                TextFormField(
                                  controller: classs,
                                  style: GoogleFonts.acme(),
                                  decoration: InputDecoration(
                                      hintText: "Class:12 Maths",
                                      hintStyle: TextStyle(
                                          color: Color(0xff848482).withOpacity(
                                              0.5)
                                      )
                                  ),
                                ),
                                TextFormField(
                                  controller: test,
                                  style: GoogleFonts.acme(),
                                  decoration: InputDecoration(
                                    hintText: "Unit Test",
                                    hintStyle: TextStyle(
                                        color: Color(0xff848482).withOpacity(
                                            0.5)
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: marks,
                                  style: GoogleFonts.acme(),
                                  decoration: InputDecoration(
                                      hintText: "Marks: 100",
                                      hintStyle: TextStyle(
                                          color: Color(0xff848482).withOpacity(
                                              0.5)
                                      )
                                  ),
                                ),
                                TextFormField(
                                  controller: date,
                                  style: GoogleFonts.acme(),
                                  decoration: InputDecoration(
                                      hintText: "Date: 10/10/2021",
                                      hintStyle: TextStyle(
                                          color: Color(0xff848482).withOpacity(
                                              0.5)
                                      )
                                  ),
                                ),
                                TextFormField(
                                  controller: time,
                                  style: GoogleFonts.acme(),
                                  decoration: InputDecoration(
                                      hintText: "time: 3.00 hrs",
                                      hintStyle: TextStyle(
                                          color: Color(0xff848482).withOpacity(
                                              0.5)
                                      )
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text("WaterMark",
                                      style: GoogleFonts.balsamiqSans(),).text
                                        .color(Colors.white).size(16).make(),
                                  ),
                                  color: Color(0xff344FA1),
                                ),
                                TextFormField(
                                  controller: controller,
                                  style: GoogleFonts.acme(),
                                  decoration: InputDecoration(
                                      hintText: "GRM School (Optional)",
                                      hintStyle: TextStyle(
                                          color: Color(0xff848482).withOpacity(
                                              0.5)
                                      )
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text("Footer",
                                      style: GoogleFonts.balsamiqSans(),).text
                                        .color(Colors.white).size(16).make(),
                                  ),
                                  color: Color(0xff344FA1),
                                ),
                                TextFormField(
                                  controller: footer,
                                  style: GoogleFonts.acme(),
                                  decoration: InputDecoration(
                                      hintText: "All the best (Optional)",
                                      hintStyle: TextStyle(
                                          color: Color(0xff848482).withOpacity(
                                              0.5)
                                      )
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text("Include Answers ?",
                                      style: GoogleFonts.balsamiqSans(),).text
                                        .color(Colors.white).size(16).make(),
                                  ),
                                  color: Color(0xff344FA1),
                                ),
                                TextFormField(
                                  controller: ans,
                                  style: GoogleFonts.acme(),
                                  decoration: InputDecoration(
                                      hintText: "yes or no",
                                      hintStyle: TextStyle(
                                          color: Color(0xff848482).withOpacity(
                                              0.5)
                                      )
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text("PDF Name",
                                      style: GoogleFonts.balsamiqSans(),).text
                                        .color(Colors.white).size(16).make(),
                                  ),
                                  color: Color(0xff344FA1),
                                ),
                                TextFormField(
                                  controller: pdf,
                                  style: GoogleFonts.acme(),
                                  decoration: InputDecoration(
                                      hintText: "pdf name",
                                      hintStyle: TextStyle(
                                          color: Color(0xff848482).withOpacity(
                                              0.5)
                                      )
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Cancel", style: GoogleFonts.acme(),).text
                                    .color(Color(0xff344FA1)).make()),

                            FlatButton(
                                onPressed: () async {
                                  func();
                                  await make();
                                  final pdfFile = await PdfApii
                                      .generateCenteredText(
                                      list: list,
                                      list2: listTotal,
                                     answer: answers,
                                      school: schoolName,
                                      watermark: watermark,
                                      classSub: className,
                                      unitTest: testName,
                                      marks: marksName,
                                      dateNow: dateName,
                                      show: ansname=="yes" || ansname=="Yes" || ansname=="YES"?true:false,
                                      totalTime: timeName,
                                      footer: footerName,
                                      pdfname: pdfname
                                  );
                                  // print(list.length);
                                  // print(listTotal);




                                  PdfApi.openFile(pdfFile);
                                //  Erase();
                                },
                                child: Text(" Create PDF",
                                  style: GoogleFonts.acme(),).text.color(
                                    Color(0xff344FA1)).make())
                          ],
                        )
                      ],
                    ),
                  ),

                );
              });
        },
      ),
    );
  }
}
