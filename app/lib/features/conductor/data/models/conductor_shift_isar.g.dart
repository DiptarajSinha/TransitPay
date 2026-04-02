// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conductor_shift_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetConductorShiftIsarCollection on Isar {
  IsarCollection<ConductorShiftIsar> get conductorShiftIsars =>
      this.collection();
}

const ConductorShiftIsarSchema = CollectionSchema(
  name: r'ConductorShiftIsar',
  id: 2766660180620835305,
  properties: {
    r'busImageUrl': PropertySchema(
      id: 0,
      name: r'busImageUrl',
      type: IsarType.string,
    ),
    r'conductorId': PropertySchema(
      id: 1,
      name: r'conductorId',
      type: IsarType.string,
    ),
    r'isActive': PropertySchema(
      id: 2,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'remoteId': PropertySchema(
      id: 3,
      name: r'remoteId',
      type: IsarType.long,
    ),
    r'routeNo': PropertySchema(
      id: 4,
      name: r'routeNo',
      type: IsarType.long,
    ),
    r'startedAt': PropertySchema(
      id: 5,
      name: r'startedAt',
      type: IsarType.dateTime,
    ),
    r'vehicleNo': PropertySchema(
      id: 6,
      name: r'vehicleNo',
      type: IsarType.string,
    )
  },
  estimateSize: _conductorShiftIsarEstimateSize,
  serialize: _conductorShiftIsarSerialize,
  deserialize: _conductorShiftIsarDeserialize,
  deserializeProp: _conductorShiftIsarDeserializeProp,
  idName: r'id',
  indexes: {
    r'remoteId': IndexSchema(
      id: 6301175856541681032,
      name: r'remoteId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'remoteId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _conductorShiftIsarGetId,
  getLinks: _conductorShiftIsarGetLinks,
  attach: _conductorShiftIsarAttach,
  version: '3.1.0+1',
);

int _conductorShiftIsarEstimateSize(
  ConductorShiftIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.busImageUrl.length * 3;
  bytesCount += 3 + object.conductorId.length * 3;
  bytesCount += 3 + object.vehicleNo.length * 3;
  return bytesCount;
}

void _conductorShiftIsarSerialize(
  ConductorShiftIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.busImageUrl);
  writer.writeString(offsets[1], object.conductorId);
  writer.writeBool(offsets[2], object.isActive);
  writer.writeLong(offsets[3], object.remoteId);
  writer.writeLong(offsets[4], object.routeNo);
  writer.writeDateTime(offsets[5], object.startedAt);
  writer.writeString(offsets[6], object.vehicleNo);
}

ConductorShiftIsar _conductorShiftIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ConductorShiftIsar();
  object.busImageUrl = reader.readString(offsets[0]);
  object.conductorId = reader.readString(offsets[1]);
  object.id = id;
  object.isActive = reader.readBool(offsets[2]);
  object.remoteId = reader.readLongOrNull(offsets[3]);
  object.routeNo = reader.readLong(offsets[4]);
  object.startedAt = reader.readDateTime(offsets[5]);
  object.vehicleNo = reader.readString(offsets[6]);
  return object;
}

P _conductorShiftIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _conductorShiftIsarGetId(ConductorShiftIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _conductorShiftIsarGetLinks(
    ConductorShiftIsar object) {
  return [];
}

void _conductorShiftIsarAttach(
    IsarCollection<dynamic> col, Id id, ConductorShiftIsar object) {
  object.id = id;
}

extension ConductorShiftIsarByIndex on IsarCollection<ConductorShiftIsar> {
  Future<ConductorShiftIsar?> getByRemoteId(int? remoteId) {
    return getByIndex(r'remoteId', [remoteId]);
  }

  ConductorShiftIsar? getByRemoteIdSync(int? remoteId) {
    return getByIndexSync(r'remoteId', [remoteId]);
  }

  Future<bool> deleteByRemoteId(int? remoteId) {
    return deleteByIndex(r'remoteId', [remoteId]);
  }

  bool deleteByRemoteIdSync(int? remoteId) {
    return deleteByIndexSync(r'remoteId', [remoteId]);
  }

  Future<List<ConductorShiftIsar?>> getAllByRemoteId(
      List<int?> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteId', values);
  }

  List<ConductorShiftIsar?> getAllByRemoteIdSync(List<int?> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'remoteId', values);
  }

  Future<int> deleteAllByRemoteId(List<int?> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'remoteId', values);
  }

  int deleteAllByRemoteIdSync(List<int?> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'remoteId', values);
  }

  Future<Id> putByRemoteId(ConductorShiftIsar object) {
    return putByIndex(r'remoteId', object);
  }

  Id putByRemoteIdSync(ConductorShiftIsar object, {bool saveLinks = true}) {
    return putByIndexSync(r'remoteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteId(List<ConductorShiftIsar> objects) {
    return putAllByIndex(r'remoteId', objects);
  }

  List<Id> putAllByRemoteIdSync(List<ConductorShiftIsar> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'remoteId', objects, saveLinks: saveLinks);
  }
}

extension ConductorShiftIsarQueryWhereSort
    on QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QWhere> {
  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhere>
      anyRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'remoteId'),
      );
    });
  }
}

extension ConductorShiftIsarQueryWhere
    on QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QWhereClause> {
  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhereClause>
      remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'remoteId',
        value: [null],
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhereClause>
      remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'remoteId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhereClause>
      remoteIdEqualTo(int? remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'remoteId',
        value: [remoteId],
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhereClause>
      remoteIdNotEqualTo(int? remoteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [],
              upper: [remoteId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [remoteId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [remoteId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [],
              upper: [remoteId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhereClause>
      remoteIdGreaterThan(
    int? remoteId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'remoteId',
        lower: [remoteId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhereClause>
      remoteIdLessThan(
    int? remoteId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'remoteId',
        lower: [],
        upper: [remoteId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterWhereClause>
      remoteIdBetween(
    int? lowerRemoteId,
    int? upperRemoteId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'remoteId',
        lower: [lowerRemoteId],
        includeLower: includeLower,
        upper: [upperRemoteId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ConductorShiftIsarQueryFilter
    on QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QFilterCondition> {
  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      busImageUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'busImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      busImageUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'busImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      busImageUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'busImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      busImageUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'busImageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      busImageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'busImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      busImageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'busImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      busImageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'busImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      busImageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'busImageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      busImageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'busImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      busImageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'busImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      conductorIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conductorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      conductorIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conductorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      conductorIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conductorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      conductorIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conductorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      conductorIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'conductorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      conductorIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'conductorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      conductorIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'conductorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      conductorIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'conductorId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      conductorIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conductorId',
        value: '',
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      conductorIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'conductorId',
        value: '',
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
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

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
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

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remoteId',
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remoteId',
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      remoteIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      remoteIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      remoteIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteId',
        value: value,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      remoteIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      routeNoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeNo',
        value: value,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      routeNoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routeNo',
        value: value,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      routeNoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routeNo',
        value: value,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      routeNoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routeNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      startedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      startedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      startedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      startedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      vehicleNoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      vehicleNoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicleNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      vehicleNoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicleNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      vehicleNoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicleNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      vehicleNoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicleNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      vehicleNoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicleNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      vehicleNoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      vehicleNoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleNo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      vehicleNoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleNo',
        value: '',
      ));
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterFilterCondition>
      vehicleNoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleNo',
        value: '',
      ));
    });
  }
}

extension ConductorShiftIsarQueryObject
    on QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QFilterCondition> {}

extension ConductorShiftIsarQueryLinks
    on QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QFilterCondition> {}

extension ConductorShiftIsarQuerySortBy
    on QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QSortBy> {
  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByBusImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'busImageUrl', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByBusImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'busImageUrl', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByConductorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conductorId', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByConductorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conductorId', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByRouteNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeNo', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByRouteNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeNo', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByVehicleNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNo', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      sortByVehicleNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNo', Sort.desc);
    });
  }
}

extension ConductorShiftIsarQuerySortThenBy
    on QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QSortThenBy> {
  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByBusImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'busImageUrl', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByBusImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'busImageUrl', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByConductorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conductorId', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByConductorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conductorId', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByRouteNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeNo', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByRouteNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeNo', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByVehicleNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNo', Sort.asc);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QAfterSortBy>
      thenByVehicleNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNo', Sort.desc);
    });
  }
}

extension ConductorShiftIsarQueryWhereDistinct
    on QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QDistinct> {
  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QDistinct>
      distinctByBusImageUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'busImageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QDistinct>
      distinctByConductorId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conductorId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QDistinct>
      distinctByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId');
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QDistinct>
      distinctByRouteNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routeNo');
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QDistinct>
      distinctByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startedAt');
    });
  }

  QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QDistinct>
      distinctByVehicleNo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleNo', caseSensitive: caseSensitive);
    });
  }
}

extension ConductorShiftIsarQueryProperty
    on QueryBuilder<ConductorShiftIsar, ConductorShiftIsar, QQueryProperty> {
  QueryBuilder<ConductorShiftIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ConductorShiftIsar, String, QQueryOperations>
      busImageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'busImageUrl');
    });
  }

  QueryBuilder<ConductorShiftIsar, String, QQueryOperations>
      conductorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conductorId');
    });
  }

  QueryBuilder<ConductorShiftIsar, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<ConductorShiftIsar, int?, QQueryOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<ConductorShiftIsar, int, QQueryOperations> routeNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routeNo');
    });
  }

  QueryBuilder<ConductorShiftIsar, DateTime, QQueryOperations>
      startedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startedAt');
    });
  }

  QueryBuilder<ConductorShiftIsar, String, QQueryOperations>
      vehicleNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleNo');
    });
  }
}
