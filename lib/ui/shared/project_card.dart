import 'package:flutter/material.dart';

import 'pill_badge.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String? description;
  final double progress;
  final int milestone;
  final int sprint;

  const ProjectCard({
    Key? key,
    required this.title,
    this.description,
    this.progress = 0.0,
    this.milestone = 0,
    this.sprint = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          if (description != null)
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                description!,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          SizedBox(height: 10),
          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                color: Colors.black12,
              ),
              Container(
                height: 8,
                width: MediaQuery.of(context).size.width * progress,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 6,
            children: [
              PillBadge(
                icon: Icon(
                  Icons.emoji_flags,
                  size: 18,
                ),
                label: "Milestone",
                value: milestone.toString(),
              ),
              PillBadge(
                icon: Icon(
                  Icons.directions_run,
                  size: 18,
                ),
                label: "Sprint",
                value: sprint.toString(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
