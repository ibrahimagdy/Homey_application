import 'package:flutter/material.dart';
import 'package:homey/core/widgets/about_us_item.dart';
import 'package:homey/core/widgets/custom_divider.dart';

class AboutUsScreen extends StatelessWidget {
  static const String routeName = "about";

  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xff0A1128),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 36,
            color: Color(0xffC6FAFF),
          ),
        ),
        title: Text("About Us",
            style: theme.textTheme.titleMedium!.copyWith(
              color: const Color(0xffC6FAFF),
            )),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AboutUsItem(
                aboutUsImage: "assets/images/about.jpeg",
                headTitle: "Our Mission",
                desc:
                    "At Homey, our mission is to make life easier for expatriate students by providing convenient and affordable housing solutions near universities. We understand the challenges faced by students who move to new cities or countries for their education, and we strive to alleviate their stress by offering comfortable living spaces that are close to their academic institutions.",
              ),
              AboutUsItem(
                aboutUsImage: "assets/images/about_2.jpg",
                headTitle: "Our Vision",
                desc:
                    "Our vision is to become the leading provider of student accommodation, recognized for our commitment to quality, affordability, and exceptional customer service. We aim to expand our network of properties across various cities and countries, ensuring that every expatriate student has access to safe and convenient housing options during their academic journey.",
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  'Contact Us',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomDivider(),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: 25,
                      color: Color(0xff0096A4),
                    ),
                    SizedBox(width: 30),
                    Text(
                      'contact@homey.com',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffC6FAFF),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 25,
                      color: Color(0xff0096A4),
                    ),
                    SizedBox(width: 30),
                    Text(
                      '+201140461855',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffC6FAFF),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
