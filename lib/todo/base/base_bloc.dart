import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:todosqlite/todo/base/base_event.dart';

abstract class BaseBloc{
  StreamController<BaseEvent> _eventStreamController = StreamController<BaseEvent>();
  Sink<BaseEvent> get event => _eventStreamController.sink;

  BaseBloc(){
    _eventStreamController.stream.listen((event){
      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent event);

  @mustCallSuper
  void dispose(){
    _eventStreamController.close();
  }

}