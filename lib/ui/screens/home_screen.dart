import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/bottom_navigation_bar.dart';
import '../shared/curve_background.dart';
import '../shared/project_card.dart';
import 'check_in_screen.dart';
import 'master_data_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CurveBackground(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 20 + MediaQuery.of(context).padding.top, 20, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi Calvine",
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Friday, 5 August 2021",
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: Colors.white,
                                    ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 10,
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://uploads.toptal.io/user/photo/418751/large_fa100e141cc15e44be9e72fa81f468e6.jpeg"),
                          radius: 25,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CheckInScreen(),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.blue[300],
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.near_me,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Check In/Out',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 1),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => MasterDataScreen(),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.blue[300],
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_location,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'New Location',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Attendance History",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.event_available),
                                        SizedBox(width: 3),
                                        Text(
                                          "5 August 2021, 08.30 AM",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                        "Neo Soho Podomoro City Unit 37.10 Jalan Letjen S. Parman Kav. 28",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              Icon(
                                Icons.chevron_right,
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.event_available),
                                        SizedBox(width: 3),
                                        Text(
                                          "4 August 2021, 07.15 AM",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        "Neo Soho Podomoro City Unit 37.10 Jalan Letjen S. Parman Kav. 28"),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              Icon(
                                Icons.chevron_right,
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.event_available),
                                        SizedBox(width: 3),
                                        Text(
                                          "3 August 2021, 08.22 AM",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        "Neo Soho Podomoro City Unit 37.10 Jalan Letjen S. Parman Kav. 28"),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              Icon(
                                Icons.chevron_right,
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Projects",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        ProjectCard(
                          title: "EQUIP UI V2",
                          description: "UI Update V2 - Introducing Neumorphism",
                          progress: 0.6,
                          milestone: 2,
                          sprint: 4,
                        ),
                        Divider(),
                        ProjectCard(
                          title: "PERTAMINA ERP Data Migration",
                          description: "Data migration from old DB service",
                          progress: 0.2,
                          milestone: 1,
                          sprint: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
