import '../model/model_element.dart';

class Service {
  Service(){
    _list = [];
  }
  late List<ModelElement> _list;

  Future<List<ModelElement>> getList() async {
    return _list;
  }
  Future<void> addElement() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _list.add(ModelElement("Item ${_list.length}"));
    if(_list.length == 5){
      throw Exception("Emulated exception");
    }
  }

  Future<void> removeElement() async {
    _list.removeLast();
  }
}
