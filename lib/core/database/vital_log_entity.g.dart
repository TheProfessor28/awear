// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vital_log_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVitalLogEntityCollection on Isar {
  IsarCollection<VitalLogEntity> get vitalLogEntitys => this.collection();
}

const VitalLogEntitySchema = CollectionSchema(
  name: r'VitalLogEntity',
  id: -4840517382401800229,
  properties: {
    r'hr': PropertySchema(
      id: 0,
      name: r'hr',
      type: IsarType.double,
    ),
    r'motion': PropertySchema(
      id: 1,
      name: r'motion',
      type: IsarType.bool,
    ),
    r'oxy': PropertySchema(
      id: 2,
      name: r'oxy',
      type: IsarType.double,
    ),
    r'rr': PropertySchema(
      id: 3,
      name: r'rr',
      type: IsarType.double,
    ),
    r'stress': PropertySchema(
      id: 4,
      name: r'stress',
      type: IsarType.double,
    ),
    r'temp': PropertySchema(
      id: 5,
      name: r'temp',
      type: IsarType.double,
    ),
    r'timestamp': PropertySchema(
      id: 6,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 7,
      name: r'userId',
      type: IsarType.long,
    )
  },
  estimateSize: _vitalLogEntityEstimateSize,
  serialize: _vitalLogEntitySerialize,
  deserialize: _vitalLogEntityDeserialize,
  deserializeProp: _vitalLogEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'timestamp': IndexSchema(
      id: 1852253767416892198,
      name: r'timestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'timestamp',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _vitalLogEntityGetId,
  getLinks: _vitalLogEntityGetLinks,
  attach: _vitalLogEntityAttach,
  version: '3.1.0+1',
);

int _vitalLogEntityEstimateSize(
  VitalLogEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _vitalLogEntitySerialize(
  VitalLogEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.hr);
  writer.writeBool(offsets[1], object.motion);
  writer.writeDouble(offsets[2], object.oxy);
  writer.writeDouble(offsets[3], object.rr);
  writer.writeDouble(offsets[4], object.stress);
  writer.writeDouble(offsets[5], object.temp);
  writer.writeDateTime(offsets[6], object.timestamp);
  writer.writeLong(offsets[7], object.userId);
}

VitalLogEntity _vitalLogEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VitalLogEntity();
  object.hr = reader.readDoubleOrNull(offsets[0]);
  object.id = id;
  object.motion = reader.readBoolOrNull(offsets[1]);
  object.oxy = reader.readDoubleOrNull(offsets[2]);
  object.rr = reader.readDoubleOrNull(offsets[3]);
  object.stress = reader.readDoubleOrNull(offsets[4]);
  object.temp = reader.readDoubleOrNull(offsets[5]);
  object.timestamp = reader.readDateTime(offsets[6]);
  object.userId = reader.readLong(offsets[7]);
  return object;
}

P _vitalLogEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _vitalLogEntityGetId(VitalLogEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _vitalLogEntityGetLinks(VitalLogEntity object) {
  return [];
}

void _vitalLogEntityAttach(
    IsarCollection<dynamic> col, Id id, VitalLogEntity object) {
  object.id = id;
}

extension VitalLogEntityQueryWhereSort
    on QueryBuilder<VitalLogEntity, VitalLogEntity, QWhere> {
  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhere> anyUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'userId'),
      );
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhere> anyTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'timestamp'),
      );
    });
  }
}

extension VitalLogEntityQueryWhere
    on QueryBuilder<VitalLogEntity, VitalLogEntity, QWhereClause> {
  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause> idBetween(
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

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause> userIdEqualTo(
      int userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause>
      userIdNotEqualTo(int userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause>
      userIdGreaterThan(
    int userId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [userId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause>
      userIdLessThan(
    int userId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [],
        upper: [userId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause> userIdBetween(
    int lowerUserId,
    int upperUserId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [lowerUserId],
        includeLower: includeLower,
        upper: [upperUserId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause>
      timestampEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'timestamp',
        value: [timestamp],
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause>
      timestampNotEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [],
              upper: [timestamp],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [timestamp],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [timestamp],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [],
              upper: [timestamp],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause>
      timestampGreaterThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [timestamp],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause>
      timestampLessThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [],
        upper: [timestamp],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterWhereClause>
      timestampBetween(
    DateTime lowerTimestamp,
    DateTime upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [lowerTimestamp],
        includeLower: includeLower,
        upper: [upperTimestamp],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VitalLogEntityQueryFilter
    on QueryBuilder<VitalLogEntity, VitalLogEntity, QFilterCondition> {
  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      hrIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hr',
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      hrIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hr',
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition> hrEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hr',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      hrGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hr',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      hrLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hr',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition> hrBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      motionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motion',
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      motionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motion',
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      motionEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motion',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      oxyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'oxy',
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      oxyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'oxy',
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      oxyEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'oxy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      oxyGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'oxy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      oxyLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'oxy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      oxyBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'oxy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      rrIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rr',
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      rrIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rr',
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition> rrEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rr',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      rrGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rr',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      rrLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rr',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition> rrBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      stressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stress',
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      stressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stress',
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      stressEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      stressGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      stressLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      stressBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      tempIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'temp',
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      tempIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'temp',
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      tempEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'temp',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      tempGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'temp',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      tempLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'temp',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      tempBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'temp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      userIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      userIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      userIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterFilterCondition>
      userIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VitalLogEntityQueryObject
    on QueryBuilder<VitalLogEntity, VitalLogEntity, QFilterCondition> {}

extension VitalLogEntityQueryLinks
    on QueryBuilder<VitalLogEntity, VitalLogEntity, QFilterCondition> {}

extension VitalLogEntityQuerySortBy
    on QueryBuilder<VitalLogEntity, VitalLogEntity, QSortBy> {
  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> sortByHr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hr', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> sortByHrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hr', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> sortByMotion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motion', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy>
      sortByMotionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motion', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> sortByOxy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oxy', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> sortByOxyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oxy', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> sortByRr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rr', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> sortByRrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rr', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> sortByStress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stress', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy>
      sortByStressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stress', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> sortByTemp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temp', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> sortByTempDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temp', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension VitalLogEntityQuerySortThenBy
    on QueryBuilder<VitalLogEntity, VitalLogEntity, QSortThenBy> {
  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByHr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hr', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByHrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hr', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByMotion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motion', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy>
      thenByMotionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motion', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByOxy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oxy', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByOxyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oxy', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByRr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rr', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByRrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rr', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByStress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stress', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy>
      thenByStressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stress', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByTemp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temp', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByTempDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temp', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension VitalLogEntityQueryWhereDistinct
    on QueryBuilder<VitalLogEntity, VitalLogEntity, QDistinct> {
  QueryBuilder<VitalLogEntity, VitalLogEntity, QDistinct> distinctByHr() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hr');
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QDistinct> distinctByMotion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motion');
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QDistinct> distinctByOxy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'oxy');
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QDistinct> distinctByRr() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rr');
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QDistinct> distinctByStress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stress');
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QDistinct> distinctByTemp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'temp');
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<VitalLogEntity, VitalLogEntity, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }
}

extension VitalLogEntityQueryProperty
    on QueryBuilder<VitalLogEntity, VitalLogEntity, QQueryProperty> {
  QueryBuilder<VitalLogEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VitalLogEntity, double?, QQueryOperations> hrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hr');
    });
  }

  QueryBuilder<VitalLogEntity, bool?, QQueryOperations> motionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motion');
    });
  }

  QueryBuilder<VitalLogEntity, double?, QQueryOperations> oxyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'oxy');
    });
  }

  QueryBuilder<VitalLogEntity, double?, QQueryOperations> rrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rr');
    });
  }

  QueryBuilder<VitalLogEntity, double?, QQueryOperations> stressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stress');
    });
  }

  QueryBuilder<VitalLogEntity, double?, QQueryOperations> tempProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'temp');
    });
  }

  QueryBuilder<VitalLogEntity, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<VitalLogEntity, int, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
