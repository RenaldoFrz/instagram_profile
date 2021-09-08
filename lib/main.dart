
import 'package:flutter/material.dart';
import 'package:instagram_profile/theme/colors.dart';
import 'package:instagram_profile/util/account_images_json.dart';
import 'package:instagram_profile/util/constant.dart';
import 'package:instagram_profile/util/highlight_json.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootApp(),
    );
  }
}
class RootApp extends StatefulWidget {
  const RootApp({ Key? key }) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getAppbar(),
      body: getBody(size),
      bottomNavigationBar: getbottomNavBar(),
    );
  }

  PreferredSizeWidget getAppbar(){
    return PreferredSize(
      preferredSize: Size.fromHeight(55),
      child: SafeArea(
        child:Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.lock, size: 18,),
                  SizedBox(width: 10,),
                  Text(
                    username,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.add_outlined),
                    splashRadius: 18,
                  ),
                  IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.menu),
                    splashRadius: 18,
                  ),
                ], 
              )
            ],
          ),
        ),
      ), 
    );
  }

  Widget getBody(size){
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: (size.width - 20) * 0.3,
                    child: Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: bgGrey),
                            image: DecorationImage(
                              image: AssetImage('assets/images/profile.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 15,
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primary,
                              border: Border.all(width: 1, color: bgWhite),
                            ),
                            child: Center(
                              child: Icon(Icons.add, color: bgWhite),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: (size.width - 20) * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "4",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Posts",
                              style: TextStyle(fontSize: 16, height: 1.5),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "601",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(fontSize: 16, height: 1.5),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "1,043",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Following",
                              style: TextStyle(fontSize: 16, height: 1.5),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(instagramName, style: TextStyle(fontWeight: FontWeight.w600, height: 1.5)),
              Text(instagramBio1, style: TextStyle(color: bgGrey, fontWeight: FontWeight.w400, height: 1.5)),
              Text(instagramBio2, style: TextStyle(color: primary, fontWeight: FontWeight.w400, height: 1.5)),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: (size.width - 20),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: bgGrey),
                      borderRadius: BorderRadius.circular(5),
                      color: bgLightGrey,
                    ),
                    child: Center(
                      child: Text("Edit Profile"),
                    ), 
                  )
                ],
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(stories.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: 80,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: bgGrey,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: bgWhite),
                              image: DecorationImage(
                                image: NetworkImage(stories[index]['imageUrl']?.toString() ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        stories[index]['title']?.toString() ?? '',
                        style: TextStyle(height: 1.5, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            })
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              Container(
                width: (size.width * 0.5),
                child: IconButton(
                  splashRadius: 20,
                  icon: Image.asset('assets/images/grid.png', color: selectedIndex == 0 ? textBlack : textBlack.withOpacity(0.3)),
                  onPressed: (){
                    setState(() {
                      selectedIndex=0;
                    });
                  },
                ),
              ),
              Container(
                width: (size.width * 0.5),
                child: IconButton(
                  splashRadius: 20,
                  icon: Image.asset('assets/images/tag.png', color: selectedIndex == 1 ? textBlack : textBlack.withOpacity(0.3)),
                  onPressed: (){
                    setState(() {
                      selectedIndex=1;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Container(
                  height: 1,
                  width: (size.width * 0.5),
                  decoration: BoxDecoration(color: selectedIndex == 0 ? textBlack : textBlack.withOpacity(0.3)),
                ),
                Container(
                  height: 1,
                  width: (size.width * 0.5),
                  decoration: BoxDecoration(color: selectedIndex == 1 ? textBlack : textBlack.withOpacity(0.3)),
                ),
              ],
            ),
            Container(
              height: 0.5,
              width: size.width,
              decoration: BoxDecoration(color: textBlack.withOpacity(0.8)),
            ),
          ],
        ),
        SizedBox(height: 3),
        IndexedStack(
          index: selectedIndex,
          children: [
            getImages(size),
            getImageswithTag(size),
          ],
        ),
           
      ],
    );
  }

  Widget getImages(size){
    return Wrap(
      direction: Axis.horizontal,
      spacing: 3,
      runSpacing: 3,
      children: List.generate(images.length, (index) {
        return Container(
          height: (size.width - 6) / 3,
          width: (size.width - 6) / 3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(images[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      })
    );
  }

  Widget getImageswithTag(size){
    return Wrap(
      direction: Axis.horizontal,
      spacing: 3,
      runSpacing: 3,
      children: List.generate(imageWithTags.length, (index) {
        return Container(
          height: (size.width - 6) / 3,
          width: (size.width - 6) / 3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageWithTags[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      })
    );
  }

  Widget getbottomNavBar(){
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: bgLightGrey,
        border: Border(top: BorderSide(width: 1, color: bgDark.withOpacity(0.3))),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: (){}, 
              icon: Image.asset('assets/images/home.png', width: 25, height: 25),
            ),
             IconButton(
              onPressed: (){}, 
              icon: Image.asset('assets/images/search.png', width: 25, height: 25),
            ),
             IconButton(
              onPressed: (){}, 
              icon: Image.asset('assets/images/add.png', width: 25, height: 25),
            ),
             IconButton(
              onPressed: (){}, 
              icon: Image.asset('assets/images/heart.png', width: 25, height: 25),
            ),
             IconButton(
              onPressed: (){}, 
              icon: Image.asset('assets/images/account_active.png', width: 25, height: 25),
            ),
          ],
        ),
      ),
    );
  }
}