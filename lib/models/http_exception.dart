class HttpException implements Exception{
  //implements means you are forced to implement all the functions this class has
  final message;

  HttpException(this.message);

  @override
  String toString() {
    
    return message;
    // return super.toString(); //instance of httpException
  }

}