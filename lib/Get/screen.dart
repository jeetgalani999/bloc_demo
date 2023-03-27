import 'package:bloc_demo/Get/getBloc.dart';
import 'package:bloc_demo/Get/getmodal.dart';
import 'package:flutter/material.dart';

import '../comman.dart';

class getscreen extends StatefulWidget {
  const getscreen({Key? key}) : super(key: key);

  @override
  State<getscreen> createState() => _getscreenState();
}

class _getscreenState extends State<getscreen> {
  @override
  void initState() {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    categoryBloc.getCategory(1, pl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get'),
      ),
      body: StreamBuilder<GetModal>(
          stream: categoryBloc.getstream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return Center(
                      child: SizedBox(
                        height: 100,
                        child: Card(
                          child: ListTile(
                              leading: Image(
                                  image: NetworkImage(snapshot
                                      .data!.data![index].avatar
                                      .toString())),
                              title: Text(snapshot.data!.data![index].firstName
                                  .toString())),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: snapshot.data!.data!.length);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
