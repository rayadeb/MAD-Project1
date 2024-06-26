// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMealPlanCollection on Isar {
  IsarCollection<MealPlan> get mealPlans => this.collection();
}

const MealPlanSchema = CollectionSchema(
  name: r'MealPlan',
  id: 6858060180785015955,
  properties: {
    r'breakfastId': PropertySchema(
      id: 0,
      name: r'breakfastId',
      type: IsarType.long,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'dinnerId': PropertySchema(
      id: 2,
      name: r'dinnerId',
      type: IsarType.long,
    ),
    r'lunchId': PropertySchema(
      id: 3,
      name: r'lunchId',
      type: IsarType.long,
    )
  },
  estimateSize: _mealPlanEstimateSize,
  serialize: _mealPlanSerialize,
  deserialize: _mealPlanDeserialize,
  deserializeProp: _mealPlanDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _mealPlanGetId,
  getLinks: _mealPlanGetLinks,
  attach: _mealPlanAttach,
  version: '3.1.0+1',
);

int _mealPlanEstimateSize(
  MealPlan object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _mealPlanSerialize(
  MealPlan object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.breakfastId);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeLong(offsets[2], object.dinnerId);
  writer.writeLong(offsets[3], object.lunchId);
}

MealPlan _mealPlanDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MealPlan(
    breakfastId: reader.readLongOrNull(offsets[0]),
    date: reader.readDateTimeOrNull(offsets[1]),
    dinnerId: reader.readLongOrNull(offsets[2]),
    id: id,
    lunchId: reader.readLongOrNull(offsets[3]),
  );
  return object;
}

P _mealPlanDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mealPlanGetId(MealPlan object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _mealPlanGetLinks(MealPlan object) {
  return [];
}

void _mealPlanAttach(IsarCollection<dynamic> col, Id id, MealPlan object) {
  object.id = id;
}

extension MealPlanQueryWhereSort on QueryBuilder<MealPlan, MealPlan, QWhere> {
  QueryBuilder<MealPlan, MealPlan, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MealPlanQueryWhere on QueryBuilder<MealPlan, MealPlan, QWhereClause> {
  QueryBuilder<MealPlan, MealPlan, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<MealPlan, MealPlan, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterWhereClause> idBetween(
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
}

extension MealPlanQueryFilter
    on QueryBuilder<MealPlan, MealPlan, QFilterCondition> {
  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> breakfastIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'breakfastId',
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition>
      breakfastIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'breakfastId',
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> breakfastIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breakfastId',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition>
      breakfastIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'breakfastId',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> breakfastIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'breakfastId',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> breakfastIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'breakfastId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> dateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> dateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> dateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> dateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> dinnerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dinnerId',
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> dinnerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dinnerId',
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> dinnerIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dinnerId',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> dinnerIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dinnerId',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> dinnerIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dinnerId',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> dinnerIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dinnerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> idGreaterThan(
    Id? value, {
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

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> idLessThan(
    Id? value, {
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

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> lunchIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lunchId',
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> lunchIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lunchId',
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> lunchIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lunchId',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> lunchIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lunchId',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> lunchIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lunchId',
        value: value,
      ));
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterFilterCondition> lunchIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lunchId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MealPlanQueryObject
    on QueryBuilder<MealPlan, MealPlan, QFilterCondition> {}

extension MealPlanQueryLinks
    on QueryBuilder<MealPlan, MealPlan, QFilterCondition> {}

extension MealPlanQuerySortBy on QueryBuilder<MealPlan, MealPlan, QSortBy> {
  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> sortByBreakfastId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakfastId', Sort.asc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> sortByBreakfastIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakfastId', Sort.desc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> sortByDinnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dinnerId', Sort.asc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> sortByDinnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dinnerId', Sort.desc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> sortByLunchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lunchId', Sort.asc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> sortByLunchIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lunchId', Sort.desc);
    });
  }
}

extension MealPlanQuerySortThenBy
    on QueryBuilder<MealPlan, MealPlan, QSortThenBy> {
  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> thenByBreakfastId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakfastId', Sort.asc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> thenByBreakfastIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakfastId', Sort.desc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> thenByDinnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dinnerId', Sort.asc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> thenByDinnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dinnerId', Sort.desc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> thenByLunchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lunchId', Sort.asc);
    });
  }

  QueryBuilder<MealPlan, MealPlan, QAfterSortBy> thenByLunchIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lunchId', Sort.desc);
    });
  }
}

extension MealPlanQueryWhereDistinct
    on QueryBuilder<MealPlan, MealPlan, QDistinct> {
  QueryBuilder<MealPlan, MealPlan, QDistinct> distinctByBreakfastId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breakfastId');
    });
  }

  QueryBuilder<MealPlan, MealPlan, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<MealPlan, MealPlan, QDistinct> distinctByDinnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dinnerId');
    });
  }

  QueryBuilder<MealPlan, MealPlan, QDistinct> distinctByLunchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lunchId');
    });
  }
}

extension MealPlanQueryProperty
    on QueryBuilder<MealPlan, MealPlan, QQueryProperty> {
  QueryBuilder<MealPlan, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MealPlan, int?, QQueryOperations> breakfastIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breakfastId');
    });
  }

  QueryBuilder<MealPlan, DateTime?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<MealPlan, int?, QQueryOperations> dinnerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dinnerId');
    });
  }

  QueryBuilder<MealPlan, int?, QQueryOperations> lunchIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lunchId');
    });
  }
}
