import 'package:sembast/sembast.dart';
import 'package:wm_com_ivanna/src/global/store/sembast_database.dart';
import 'package:wm_com_ivanna/src/models/restaurant/table_restaurant_model.dart';

class TableRestaurantStore {
  static final TableRestaurantStore _singleton =
      TableRestaurantStore._internal();
  factory TableRestaurantStore() {
    return _singleton;
  }
  TableRestaurantStore._internal();

  static const String tableName = 'table-restaurants';
  final store = intMapStoreFactory.store(tableName);
  Future<Database> get _db async => await SembastDataBase.instance.database;

  /// Get the favorites available in the device
  Future<List<TableRestaurantModel>> getAllData() async {
    var data = await store.find(await _db);
    List<TableRestaurantModel> dataList = [];
    for (var snapshot in data) {
      final TableRestaurantModel dataItem =
          TableRestaurantModel.fromJson(snapshot.value);
      dataList.add(dataItem);
    }
    return dataList;
  }

  Future<TableRestaurantModel> getOneData(int id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    var data = await store.findFirst(await _db, finder: finder);
    late TableRestaurantModel dataItem =
        TableRestaurantModel.fromJson(data!.value);
    return dataItem;
  }

  Future<int> insertData(TableRestaurantModel dataItem) async {
    var dataList = await getAllData();
    int key =
        await store.add(await _db, dataItem.toJson(id: dataList.length + 1));
    return key;
  }

  Future<int> updateData(TableRestaurantModel entity) async {
    final finder = Finder(filter: Filter.equals('id', entity.id));
    var key = await store.update(await _db, entity.toJson(id: entity.id!),
        finder: finder);
    return key;
  }

  deleteData(int id) async {
    await store.delete(await _db,
        finder: Finder(filter: Filter.equals('id', id)));
  }

  deleteDataAll() async {
    await store.delete(await _db);
  }
 

}
