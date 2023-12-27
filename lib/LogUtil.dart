

import 'package:logger/logger.dart';

var _logger = Logger();


void logI(String tag,String msg){
  _logger.log(Level.info,msg);
}

void logE(String tag,String msg){
  _logger.log(Level.error,msg);
}

void logD(String tag,String msg){
  _logger.log(Level.debug, msg);
}



class LogUtil{

}