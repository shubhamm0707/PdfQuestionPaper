import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';


class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff344FA1),
      body: Stack(
        children: [
          Container(height: double.infinity,),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 80,width: 40,),
                Row(
                  children: [
                    SizedBox(width: 40,),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset("assets/img.png"),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                ListTile(
                  onTap: (){
                    VxToast.show(context, msg: "Help Clicked");
                  },
                  hoverColor: Color(0xffFF4C29),

                  leading: Icon(Icons.help,color: Colors.white,),
                  title: Text("HELP",style: GoogleFonts.acme(fontStyle: FontStyle.normal),).text.bold.white.make(),
                ),
                ListTile(
                  onTap: (){
                    VxToast.show(context, msg: "App Price Clicked");
                  },
                  leading: Icon(Icons.monetization_on,color: Colors.white,),
                  title: Text("App Price",style: GoogleFonts.acme(),).text.bold.white.make(),
                ),
                ListTile(
                  onTap: (){
                    VxToast.show(context, msg: "More Apps Clicked");
                  },
                  leading: Icon(Icons.app_registration,color: Colors.white,),
                  title: Text("More Apps",style: GoogleFonts.acme(),).text.bold.white.make(),
                ),
                ListTile(
                  onTap: (){
                    VxToast.show(context, msg: "Add To Wallet Clicked");
                  },
                  leading: Icon(Icons.wallet_giftcard,color: Colors.white,),
                  title: Text("Add To Wallet",style: GoogleFonts.acme(),).text.bold.white.make(),
                ),
                Divider(color: Colors.grey,height: 10,thickness: 1,),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Text("Communicate").text.gray300.bold.make(),
                  ],
                ),
                ListTile(
                  onTap: (){
                    VxToast.show(context, msg: "Share Clicked");
                  },
                  leading: Icon(Icons.share,color: Colors.white,),
                  title: Text("SHARE",style: GoogleFonts.acme(),).text.bold.white.make(),
                ),
                ListTile(
                  onTap: (){
                    VxToast.show(context, msg: "Rate Us Clicked");
                  },
                  leading: Icon(Icons.star_rate_sharp,color: Colors.white,),
                  title: Text("Rate Us",style: GoogleFonts.acme(),).text.bold.white.make(),
                ),
                ListTile(
                  onTap: (){
                    VxToast.show(context, msg: "Contact Us Clicked");
                  },
                  leading: Icon(Icons.contact_phone,color: Colors.white,),
                  title: Text("Contact Us",style: GoogleFonts.acme(),).text.bold.white.make(),
                ),
                ListTile(
                  onTap: (){
                    VxToast.show(context, msg: "Add To Wallet Clicked");
                  },
                  leading: Icon(Icons.wallet_giftcard,color: Colors.white,),
                  title: Text("Add To Wallet",style: GoogleFonts.acme(),).text.bold.white.make(),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: Row(
              children: [
                SizedBox(width: 40,),
                InkWell(
                  onTap: (){
                    VxToast.show(context, msg: "LogOut");
                  },
                  child: PhysicalModel(
                    color: Color(0xffF0EBCC),
                    elevation: 10,
                    shadowColor: Color(0xffF0EBCC),
                    shape: BoxShape.circle,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.logout,color: Color(0xff3D84B8),),
                    ),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
