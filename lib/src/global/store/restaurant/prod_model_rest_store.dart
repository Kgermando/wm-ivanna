import 'package:sembast/sembast.dart';
import 'package:wm_com_ivanna/src/global/store/sembast_database.dart';
import 'package:wm_com_ivanna/src/models/commercial/prod_model.dart';

class ProdModelRestStore {
  static final ProdModelRestStore _singleton = ProdModelRestStore._internal();
  factory ProdModelRestStore() {
    return _singleton;
  }
  ProdModelRestStore._internal();

  static const String tableName = 'produit-models-rest';
  final store = intMapStoreFactory.store(tableName);
  Future<Database> get _db async => await SembastDataBase.instance.database;

  /// Get the favorites available in the device
  Future<List<ProductModel>> getAllData() async {
    var data = await store.find(await _db);
    List<ProductModel> dataList = [];
    for (var snapshot in data) {
      final ProductModel dataItem = ProductModel.fromJson(snapshot.value);
      dataList.add(dataItem);
    }
    return dataList;
  }

  Future<ProductModel> getOneData(int id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    var data = await store.findFirst(await _db, finder: finder);
    late ProductModel dataItem = ProductModel.fromJson(data!.value);
    return dataItem;
  }

  Future<int> insertData(ProductModel dataItem) async {
    var dataList = await getAllData();
    int key =
        await store.add(await _db, dataItem.toJson(id: dataList.length + 1));
    return key;
  }

  Future<int> updateData(ProductModel entity) async {
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
