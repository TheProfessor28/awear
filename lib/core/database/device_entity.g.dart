// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDeviceEntityCollection on Isar {
  IsarCollection<DeviceEntity> get deviceEntitys => this.collection();
}

const DeviceEntitySchema = CollectionSchema(
  name: r'DeviceEntity',
  id: 6626679775157521336,
  properties: {
    r'isPaired': PropertySchema(
      id: 0,
      name: r'isPaired',
      type: IsarType.bool,
    ),
    r'lastSeen': PropertySchema(
      id: 1,
      name: r'lastSeen',
      type: IsarType.dateTime,
    ),
    r'macAddress': PropertySchema(
      id: 2,
      name: r'macAddress',
      type: IsarType.string,
    )
  },
  estimateSize: _deviceEntityEstimateSize,
  serialize: _deviceEntitySerialize,
  deserialize: _deviceEntityDeserialize,
  deserializeProp: _deviceEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'macAddress': IndexSchema(
      id: 3845434121710544094,
      name: r'macAddress',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'macAddress',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _deviceEntityGetId,
  getLinks: _deviceEntityGetLinks,
  attach: _deviceEntityAttach,
  version: '3.1.0+1',
);

int _deviceEntityEstimateSize(
  DeviceEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.macAddress.length * 3;
  return bytesCount;
}

void _deviceEntitySerialize(
  DeviceEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isPaired);
  writer.writeDateTime(offsets[1], object.lastSeen);
  writer.writeString(offsets[2], object.macAddress);
}

DeviceEntity _deviceEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DeviceEntity();
  object.id = id;
  object.isPaired = reader.readBool(offsets[0]);
  object.lastSeen = reader.readDateTime(offsets[1]);
  object.macAddress = reader.readString(offsets[2]);
  return object;
}

P _deviceEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _deviceEntityGetId(DeviceEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _deviceEntityGetLinks(DeviceEntity object) {
  return [];
}

void _deviceEntityAttach(
    IsarCollection<dynamic> col, Id id, DeviceEntity object) {
  object.id = id;
}

extension DeviceEntityByIndex on IsarCollection<DeviceEntity> {
  Future<DeviceEntity?> getByMacAddress(String macAddress) {
    return getByIndex(r'macAddress', [macAddress]);
  }

  DeviceEntity? getByMacAddressSync(String macAddress) {
    return getByIndexSync(r'macAddress', [macAddress]);
  }

  Future<bool> deleteByMacAddress(String macAddress) {
    return deleteByIndex(r'macAddress', [macAddress]);
  }

  bool deleteByMacAddressSync(String macAddress) {
    return deleteByIndexSync(r'macAddress', [macAddress]);
  }

  Future<List<DeviceEntity?>> getAllByMacAddress(
      List<String> macAddressValues) {
    final values = macAddressValues.map((e) => [e]).toList();
    return getAllByIndex(r'macAddress', values);
  }

  List<DeviceEntity?> getAllByMacAddressSync(List<String> macAddressValues) {
    final values = macAddressValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'macAddress', values);
  }

  Future<int> deleteAllByMacAddress(List<String> macAddressValues) {
    final values = macAddressValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'macAddress', values);
  }

  int deleteAllByMacAddressSync(List<String> macAddressValues) {
    final values = macAddressValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'macAddress', values);
  }

  Future<Id> putByMacAddress(DeviceEntity object) {
    return putByIndex(r'macAddress', object);
  }

  Id putByMacAddressSync(DeviceEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'macAddress', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMacAddress(List<DeviceEntity> objects) {
    return putAllByIndex(r'macAddress', objects);
  }

  List<Id> putAllByMacAddressSync(List<DeviceEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'macAddress', objects, saveLinks: saveLinks);
  }
}

extension DeviceEntityQueryWhereSort
    on QueryBuilder<DeviceEntity, DeviceEntity, QWhere> {
  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DeviceEntityQueryWhere
    on QueryBuilder<DeviceEntity, DeviceEntity, QWhereClause> {
  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> macAddressEqualTo(
      String macAddress) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'macAddress',
        value: [macAddress],
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause>
      macAddressNotEqualTo(String macAddress) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'macAddress',
              lower: [],
              upper: [macAddress],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'macAddress',
              lower: [macAddress],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'macAddress',
              lower: [macAddress],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'macAddress',
              lower: [],
              upper: [macAddress],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DeviceEntityQueryFilter
    on QueryBuilder<DeviceEntity, DeviceEntity, QFilterCondition> {
  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      isPairedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPaired',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      lastSeenEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSeen',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      lastSeenGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSeen',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      lastSeenLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSeen',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      lastSeenBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSeen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      macAddressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'macAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      macAddressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'macAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      macAddressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'macAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      macAddressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'macAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      macAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'macAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      macAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'macAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      macAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'macAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      macAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'macAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      macAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'macAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
      macAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'macAddress',
        value: '',
      ));
    });
  }
}

extension DeviceEntityQueryObject
    on QueryBuilder<DeviceEntity, DeviceEntity, QFilterCondition> {}

extension DeviceEntityQueryLinks
    on QueryBuilder<DeviceEntity, DeviceEntity, QFilterCondition> {}

extension DeviceEntityQuerySortBy
    on QueryBuilder<DeviceEntity, DeviceEntity, QSortBy> {
  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> sortByIsPaired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaired', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> sortByIsPairedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaired', Sort.desc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> sortByLastSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeen', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> sortByLastSeenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeen', Sort.desc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> sortByMacAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'macAddress', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy>
      sortByMacAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'macAddress', Sort.desc);
    });
  }
}

extension DeviceEntityQuerySortThenBy
    on QueryBuilder<DeviceEntity, DeviceEntity, QSortThenBy> {
  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByIsPaired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaired', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByIsPairedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaired', Sort.desc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByLastSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeen', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByLastSeenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeen', Sort.desc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByMacAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'macAddress', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy>
      thenByMacAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'macAddress', Sort.desc);
    });
  }
}

extension DeviceEntityQueryWhereDistinct
    on QueryBuilder<DeviceEntity, DeviceEntity, QDistinct> {
  QueryBuilder<DeviceEntity, DeviceEntity, QDistinct> distinctByIsPaired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPaired');
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QDistinct> distinctByLastSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSeen');
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QDistinct> distinctByMacAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'macAddress', caseSensitive: caseSensitive);
    });
  }
}

extension DeviceEntityQueryProperty
    on QueryBuilder<DeviceEntity, DeviceEntity, QQueryProperty> {
  QueryBuilder<DeviceEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DeviceEntity, bool, QQueryOperations> isPairedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPaired');
    });
  }

  QueryBuilder<DeviceEntity, DateTime, QQueryOperations> lastSeenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSeen');
    });
  }

  QueryBuilder<DeviceEntity, String, QQueryOperations> macAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'macAddress');
    });
  }
}
