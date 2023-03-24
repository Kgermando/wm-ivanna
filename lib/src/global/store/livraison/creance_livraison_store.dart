import 'package:sembast/sembast.dart';
import 'package:wm_com_ivanna/src/global/store/sembast_database.dart';
import 'package:wm_com_ivanna/src/models/restaurant/creance_restaurant_model.dart';

class CreanceLivraisonStore {
  static final CreanceLivraisonStore _singleton =
      CreanceLivraisonStore._internal();
  factory CreanceLivraisonStore() {
    return _singleton;
  }
  CreanceLivraisonStore._internal();

  static const String tableName = 'creance-livraisons';
  final store = intMapStoreFactory.store(tableName);
  Future<Database> get _db async => await SembastDataBase.instance.database;

  /// Get the favorites available in the device
  Future<List<CreanceRestaurantModel>> getAllData() async {
    var data = await store.find(await _db);
    List<CreanceRestaurantModel> dataList = [];
    for (var snapshot in data) {
      final CreanceRestaurantModel dataItem =
          CreanceRestaurantModel.fromJson(snapshot.value);
      dataList.add(dataItem);
    }
    return dataList;
  }

  Future<CreanceRestaurantModel> getOneData(int id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    var data = await store.findFirst(await _db, finder: finder);
    late CreanceRestaurantModel dataItem =
        CreanceRestaurantModel.fromJson(data!.value);
    return dataItem;
  }

  Future<int> insertData(CreanceRestaurantModel dataItem) async {
    var dataList = await getAllData();
    int key =
        await store.add(await _db, dataItem.toJson(id: dataList.length + 1));
    return key;
  }

  Future<int> updateData(CreanceRestaurantModel entity) async {
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

  Future<int> getCount() async {
    var dataList = await getAllData();
    int count = dataList.length;
    return count;
  }
}
