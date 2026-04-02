// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTicketIsarCollection on Isar {
  IsarCollection<TicketIsar> get ticketIsars => this.collection();
}

const TicketIsarSchema = CollectionSchema(
  name: r'TicketIsar',
  id: -7340702449652380843,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'destination': PropertySchema(
      id: 1,
      name: r'destination',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 2,
      name: r'id',
      type: IsarType.string,
    ),
    r'passengerCount': PropertySchema(
      id: 3,
      name: r'passengerCount',
      type: IsarType.long,
    ),
    r'pin': PropertySchema(
      id: 4,
      name: r'pin',
      type: IsarType.string,
    ),
    r'qrCode': PropertySchema(
      id: 5,
      name: r'qrCode',
      type: IsarType.string,
    ),
    r'routeNo': PropertySchema(
      id: 6,
      name: r'routeNo',
      type: IsarType.string,
    ),
    r'source': PropertySchema(
      id: 7,
      name: r'source',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 8,
      name: r'status',
      type: IsarType.string,
    ),
    r'totalPrice': PropertySchema(
      id: 9,
      name: r'totalPrice',
      type: IsarType.double,
    ),
    r'userId': PropertySchema(
      id: 10,
      name: r'userId',
      type: IsarType.string,
    ),
    r'vehicleNo': PropertySchema(
      id: 11,
      name: r'vehicleNo',
      type: IsarType.string,
    ),
    r'verified': PropertySchema(
      id: 12,
      name: r'verified',
      type: IsarType.bool,
    ),
    r'verifiedAt': PropertySchema(
      id: 13,
      name: r'verifiedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _ticketIsarEstimateSize,
  serialize: _ticketIsarSerialize,
  deserialize: _ticketIsarDeserialize,
  deserializeProp: _ticketIsarDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _ticketIsarGetId,
  getLinks: _ticketIsarGetLinks,
  attach: _ticketIsarAttach,
  version: '3.1.0+1',
);

int _ticketIsarEstimateSize(
  TicketIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.destination.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.pin.length * 3;
  bytesCount += 3 + object.qrCode.length * 3;
  {
    final value = object.routeNo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.source.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  {
    final value = object.vehicleNo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _ticketIsarSerialize(
  TicketIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.destination);
  writer.writeString(offsets[2], object.id);
  writer.writeLong(offsets[3], object.passengerCount);
  writer.writeString(offsets[4], object.pin);
  writer.writeString(offsets[5], object.qrCode);
  writer.writeString(offsets[6], object.routeNo);
  writer.writeString(offsets[7], object.source);
  writer.writeString(offsets[8], object.status);
  writer.writeDouble(offsets[9], object.totalPrice);
  writer.writeString(offsets[10], object.userId);
  writer.writeString(offsets[11], object.vehicleNo);
  writer.writeBool(offsets[12], object.verified);
  writer.writeDateTime(offsets[13], object.verifiedAt);
}

TicketIsar _ticketIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TicketIsar();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.destination = reader.readString(offsets[1]);
  object.id = reader.readString(offsets[2]);
  object.isarId = id;
  object.passengerCount = reader.readLong(offsets[3]);
  object.pin = reader.readString(offsets[4]);
  object.qrCode = reader.readString(offsets[5]);
  object.routeNo = reader.readStringOrNull(offsets[6]);
  object.source = reader.readString(offsets[7]);
  object.status = reader.readString(offsets[8]);
  object.totalPrice = reader.readDouble(offsets[9]);
  object.userId = reader.readString(offsets[10]);
  object.vehicleNo = reader.readStringOrNull(offsets[11]);
  object.verified = reader.readBool(offsets[12]);
  object.verifiedAt = reader.readDateTimeOrNull(offsets[13]);
  return object;
}

P _ticketIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _ticketIsarGetId(TicketIsar object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _ticketIsarGetLinks(TicketIsar object) {
  return [];
}

void _ticketIsarAttach(IsarCollection<dynamic> col, Id id, TicketIsar object) {
  object.isarId = id;
}

extension TicketIsarByIndex on IsarCollection<TicketIsar> {
  Future<TicketIsar?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  TicketIsar? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<TicketIsar?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<TicketIsar?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(TicketIsar object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(TicketIsar object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<TicketIsar> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<TicketIsar> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension TicketIsarQueryWhereSort
    on QueryBuilder<TicketIsar, TicketIsar, QWhere> {
  QueryBuilder<TicketIsar, TicketIsar, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TicketIsarQueryWhere
    on QueryBuilder<TicketIsar, TicketIsar, QWhereClause> {
  QueryBuilder<TicketIsar, TicketIsar, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterWhereClause> idNotEqualTo(
      String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TicketIsarQueryFilter
    on QueryBuilder<TicketIsar, TicketIsar, QFilterCondition> {
  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      destinationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'destination',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      destinationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'destination',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      destinationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'destination',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      destinationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'destination',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      destinationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'destination',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      destinationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'destination',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      destinationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'destination',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      destinationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'destination',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      destinationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'destination',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      destinationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'destination',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      passengerCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'passengerCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      passengerCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'passengerCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      passengerCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'passengerCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      passengerCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'passengerCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> pinEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> pinGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> pinLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> pinBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> pinStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> pinEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> pinContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> pinMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pin',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> pinIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pin',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> pinIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pin',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> qrCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qrCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> qrCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qrCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> qrCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qrCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> qrCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qrCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> qrCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'qrCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> qrCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'qrCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> qrCodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'qrCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> qrCodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'qrCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> qrCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qrCode',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      qrCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'qrCode',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> routeNoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'routeNo',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      routeNoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'routeNo',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> routeNoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      routeNoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routeNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> routeNoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routeNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> routeNoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routeNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> routeNoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'routeNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> routeNoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'routeNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> routeNoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'routeNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> routeNoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'routeNo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> routeNoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeNo',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      routeNoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'routeNo',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> sourceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> sourceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> sourceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> sourceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> sourceContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> sourceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'source',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> totalPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      totalPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      totalPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> totalPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> userIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      vehicleNoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vehicleNo',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      vehicleNoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vehicleNo',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> vehicleNoEqualTo(
    String? value, {
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

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      vehicleNoGreaterThan(
    String? value, {
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

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> vehicleNoLessThan(
    String? value, {
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

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> vehicleNoBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
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

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> vehicleNoEndsWith(
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

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> vehicleNoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> vehicleNoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleNo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      vehicleNoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleNo',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      vehicleNoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleNo',
        value: '',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> verifiedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verified',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      verifiedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'verifiedAt',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      verifiedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'verifiedAt',
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> verifiedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifiedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      verifiedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verifiedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition>
      verifiedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verifiedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterFilterCondition> verifiedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verifiedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TicketIsarQueryObject
    on QueryBuilder<TicketIsar, TicketIsar, QFilterCondition> {}

extension TicketIsarQueryLinks
    on QueryBuilder<TicketIsar, TicketIsar, QFilterCondition> {}

extension TicketIsarQuerySortBy
    on QueryBuilder<TicketIsar, TicketIsar, QSortBy> {
  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByDestination() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destination', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByDestinationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destination', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByPassengerCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passengerCount', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy>
      sortByPassengerCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passengerCount', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByPin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pin', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByPinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pin', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByQrCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCode', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByQrCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCode', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByRouteNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeNo', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByRouteNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeNo', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByTotalPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByTotalPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByVehicleNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNo', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByVehicleNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNo', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verified', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByVerifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verified', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByVerifiedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedAt', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> sortByVerifiedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedAt', Sort.desc);
    });
  }
}

extension TicketIsarQuerySortThenBy
    on QueryBuilder<TicketIsar, TicketIsar, QSortThenBy> {
  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByDestination() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destination', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByDestinationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destination', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByPassengerCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passengerCount', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy>
      thenByPassengerCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passengerCount', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByPin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pin', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByPinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pin', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByQrCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCode', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByQrCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCode', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByRouteNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeNo', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByRouteNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeNo', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByTotalPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByTotalPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByVehicleNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNo', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByVehicleNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleNo', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verified', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByVerifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verified', Sort.desc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByVerifiedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedAt', Sort.asc);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QAfterSortBy> thenByVerifiedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedAt', Sort.desc);
    });
  }
}

extension TicketIsarQueryWhereDistinct
    on QueryBuilder<TicketIsar, TicketIsar, QDistinct> {
  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctByDestination(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'destination', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctByPassengerCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'passengerCount');
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctByPin(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pin', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctByQrCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qrCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctByRouteNo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routeNo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctBySource(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctByTotalPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalPrice');
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctByVehicleNo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleNo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctByVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verified');
    });
  }

  QueryBuilder<TicketIsar, TicketIsar, QDistinct> distinctByVerifiedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verifiedAt');
    });
  }
}

extension TicketIsarQueryProperty
    on QueryBuilder<TicketIsar, TicketIsar, QQueryProperty> {
  QueryBuilder<TicketIsar, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<TicketIsar, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<TicketIsar, String, QQueryOperations> destinationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'destination');
    });
  }

  QueryBuilder<TicketIsar, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TicketIsar, int, QQueryOperations> passengerCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'passengerCount');
    });
  }

  QueryBuilder<TicketIsar, String, QQueryOperations> pinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pin');
    });
  }

  QueryBuilder<TicketIsar, String, QQueryOperations> qrCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrCode');
    });
  }

  QueryBuilder<TicketIsar, String?, QQueryOperations> routeNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routeNo');
    });
  }

  QueryBuilder<TicketIsar, String, QQueryOperations> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<TicketIsar, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<TicketIsar, double, QQueryOperations> totalPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalPrice');
    });
  }

  QueryBuilder<TicketIsar, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<TicketIsar, String?, QQueryOperations> vehicleNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleNo');
    });
  }

  QueryBuilder<TicketIsar, bool, QQueryOperations> verifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verified');
    });
  }

  QueryBuilder<TicketIsar, DateTime?, QQueryOperations> verifiedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verifiedAt');
    });
  }
}
