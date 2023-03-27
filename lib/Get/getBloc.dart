import 'dart:async';
import 'dart:developer';

import 'package:bloc_demo/Get/getmodal.dart';
import 'package:flutter/cupertino.dart';

import '../Api/api.dart';
import '../comman.dart';

class GetBloc {
  final getcontroller = StreamController<GetModal>.broadcast();

  Stream<GetModal> get getstream => getcontroller.stream;
  GetModal? getModal;
  int page = 1;
  bool isBusy = false;

  getCategory(int page, ProgressLoader pl) async {
    if (getModal == null) {
      getModal = await api.getdata(page, pl);
      getcontroller.sink.add(getModal!);
    } else {
      getcontroller.sink.add(getModal!);
    }
  }

  paginatedData(BuildContext context, int accId, ProgressLoader pl) async {
    if (isBusy == false) {
      isBusy = true;

        page++;

        GetModal? temp = await api.getdata(accId, pl);

        if (temp != null) {
          print(temp.data);
          try {
            getModal!.data!.addAll(temp.data!);
          } catch (error) {
            print(error);
          }
        }
        getcontroller.sink.add(getModal!);
      isBusy = false;
    }
  }

  reload(int accId, ProgressLoader pl) async {
    getModal = await api.getdata(accId, pl);
    getcontroller.sink.add(getModal!);
  }

  clear(int accId) async {
    getModal = null;
  }
}

GetBloc categoryBloc = GetBloc();
