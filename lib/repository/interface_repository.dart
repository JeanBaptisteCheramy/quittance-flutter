abstract class InterfaceRepository<T> {
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<int> save(T data);
  Future<int> delete(int id);
}