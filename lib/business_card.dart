import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:business_card/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BusinessCard extends StatefulWidget {
  const BusinessCard({Key? key}) : super(key: key);

  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {

  final isOpenDialog = ValueNotifier(false);
  final Color _mainColor = const Color(0xFF545454);
  final linkedInUrl = 'https://www.linkedin.com/in/sami-rajichi/';
  final githubUrl = 'https://github.com/sami-rajichi';
  final facebookUrl = 'https://www.facebook.com/rajichi.sami.5/';
  final hackerrankUrl = 'https://www.hackerrank.com/samirajichi2016';
  final tel = 'tel:+21627944801';
  final sms = 'sms:27944801';
  final mail = 'mailto:semi.rajichi@gmail.com?subject=Welcome !!';

  Widget listTile(Icon icon, String string, Color textColor) {
    // To avoid repetition, I had to define the list tile widget 
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: ListTile(
          leading: icon,
          title: Text(
            string,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          textColor: textColor,
        ),
      ),
    );
  }

  Widget fab(Color color){
    // I wanted a customized fab (floating action button);
    // that displays all my accounts like a speed dial;
    // that's why, I used the flutter_speed_dial pkd for this purpose
    // as well as the flutter_awesome_fonts pkg for the icons.
    return SpeedDial(
      icon: Icons.share,
      backgroundColor: color,
      overlayColor: color,
      overlayOpacity: 0.7,
      childrenButtonSize: const Size(65, 65),
      spacing: 2,
      spaceBetweenChildren: 8,
      openCloseDial: isOpenDialog,
      children: [
        SpeedDialChild(
          child: const Icon(FontAwesomeIcons.linkedin),
          label: 'LinkedIn',
          onTap: (){
            UrlServices.urlLaunch(linkedInUrl);
          }
        ),
        SpeedDialChild(
          child: const Icon(FontAwesomeIcons.github),
          label: 'Github',
          onTap: (){
            UrlServices.urlLaunch(githubUrl);
          }
        ),
        SpeedDialChild(
          child: const Icon(FontAwesomeIcons.facebook),
          label: 'Facebook',
          onTap: (){
            UrlServices.urlLaunch(facebookUrl);
          }
        ),
        SpeedDialChild(
          child: const Icon(FontAwesomeIcons.hackerrank),
          label: 'Hackerrank',
          onTap: (){
            UrlServices.urlLaunch(hackerrankUrl);
          }
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async {
        // This function is to manage the back-button functionality
        if (isOpenDialog.value){
          // To close the speed dialog in case it's opened
          isOpenDialog.value = false;
          return false;
        }
        // To exit the application in case the back-button is taped
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'images/sr_bg.png',
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: _mainColor,
                    radius: 85,
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        'images/sam.jpg',
                      ),
                      radius: 82,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Sami RAJICHI',
                    style: TextStyle(
                        color: _mainColor,
                        fontSize: 32,
                        fontFamily: 'Cinzel Decorative',
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: 25,
                    child: DefaultTextStyle(
                      style: TextStyle(fontSize: 20.0, color: _mainColor),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        pause: const Duration(milliseconds: 500),
                        animatedTexts: [
                          ScaleAnimatedText(
                            'Computer Science Graduate',
                            duration: const Duration(milliseconds: 3000),
                          ),
                          ScaleAnimatedText(
                            'Flutter Developer',
                            duration: const Duration(milliseconds: 3000),
                          ),
                          ScaleAnimatedText(
                            'Data Science Enthusiast',
                            duration: const Duration(milliseconds: 3000),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: _mainColor,
                    indent: 50,
                    endIndent: 50,
                    height: 20,
                  ),
                  Dismissible(
                    key: UniqueKey(),
                    secondaryBackground: Card(
                      color: _mainColor,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.sms_rounded,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    background: Card(
                      color: _mainColor,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.phone_forwarded,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    onDismissed: (direction){
                      switch (direction) {
                        case DismissDirection.startToEnd:
                          UrlServices.phoneCallLaunch(tel);
                          break;
                        case DismissDirection.endToStart:
                          UrlServices.smsLaunch(sms);
                          break;
                        default: UrlServices.phoneCallLaunch(tel);
                      }
                      Navigator.pushReplacement(context, 
                      MaterialPageRoute(builder: (_) => const BusinessCard()));
                    },
                    child: listTile(
                      const Icon(Icons.phone, size: 25),
                      '(+216) 27 944 801',
                      _mainColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      UrlServices.emailLaunch(mail);
                    },
                    child: listTile(
                      const Icon(Icons.email, size: 25),
                      'semi.rajichi@gmail.com',
                      _mainColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      UrlServices.geolocLaunch('https://www.google.com/maps/@35.5199875,11.0410825,16z');
                    },
                    child: listTile(
                      const Icon(Icons.location_on, size: 25),
                      'Mahdia, Tunisia',
                      _mainColor,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        floatingActionButton: fab(_mainColor),
      ),
    );
  }
}
