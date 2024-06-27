// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGroceryItemCollection on Isar {
  IsarCollection<GroceryItem> get groceryItems => this.collection();
}

const GroceryItemSchema = CollectionSchema(
  name: r'GroceryItem',
  id: 3831243317278027651,
  properties: {
    r'checked': PropertySchema(
      id: 0,
      name: r'checked',
      type: IsarType.bool,
    ),
    r'item': PropertySchema(
      id: 1,
      name: r'item',
      type: IsarType.string,
    )
  },
  estimateSize: _groceryItemEstimateSize,
  serialize: _groceryItemSerialize,
  deserialize: _groceryItemDeserialize,
  deserializeProp: _groceryItemDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _groceryItemGetId,
  getLinks: _groceryItemGetLinks,
  attach: _groceryItemAttach,
  version: '3.1.0+1',
);

int _groceryItemEstimateSize(
  GroceryItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.item;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _groceryItemSerialize(
  GroceryItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.checked);
  writer.writeString(offsets[1], object.item);
}

GroceryItem _groceryItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GroceryItem(
    checked: reader.readBoolOrNull(offsets[0]) ?? false,
    id: id,
    item: reader.readStringOrNull(offsets[1]),
  );
  return object;
}

P _groceryItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _groceryItemGetId(GroceryItem object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _groceryItemGetLinks(GroceryItem object) {
  return [];
}

void _groceryItemAttach(
    IsarCollection<dynamic> col, Id id, GroceryItem object) {
  object.id = id;
}

extension GroceryItemQueryWhereSort
    on QueryBuilder<GroceryItem, GroceryItem, QWhere> {
  QueryBuilder<GroceryItem, GroceryItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GroceryItemQueryWhere
    on QueryBuilder<GroceryItem, GroceryItem, QWhereClause> {
  QueryBuilder<GroceryItem, GroceryItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<GroceryItem, GroceryItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterWhereClause> idBetween(
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

extension GroceryItemQueryFilter
    on QueryBuilder<GroceryItem, GroceryItem, QFilterCondition> {
  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> checkedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checked',
        value: value,
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> idBetween(
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

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> itemIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'item',
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition>
      itemIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'item',
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> itemEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'item',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> itemGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'item',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> itemLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'item',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> itemBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'item',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> itemStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'item',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> itemEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'item',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> itemContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'item',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> itemMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'item',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition> itemIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'item',
        value: '',
      ));
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterFilterCondition>
      itemIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'item',
        value: '',
      ));
    });
  }
}

extension GroceryItemQueryObject
    on QueryBuilder<GroceryItem, GroceryItem, QFilterCondition> {}

extension GroceryItemQueryLinks
    on QueryBuilder<GroceryItem, GroceryItem, QFilterCondition> {}

extension GroceryItemQuerySortBy
    on QueryBuilder<GroceryItem, GroceryItem, QSortBy> {
  QueryBuilder<GroceryItem, GroceryItem, QAfterSortBy> sortByChecked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checked', Sort.asc);
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterSortBy> sortByCheckedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checked', Sort.desc);
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterSortBy> sortByItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'item', Sort.asc);
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterSortBy> sortByItemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'item', Sort.desc);
    });
  }
}

extension GroceryItemQuerySortThenBy
    on QueryBuilder<GroceryItem, GroceryItem, QSortThenBy> {
  QueryBuilder<GroceryItem, GroceryItem, QAfterSortBy> thenByChecked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checked', Sort.asc);
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterSortBy> thenByCheckedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checked', Sort.desc);
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterSortBy> thenByItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'item', Sort.asc);
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QAfterSortBy> thenByItemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'item', Sort.desc);
    });
  }
}

extension GroceryItemQueryWhereDistinct
    on QueryBuilder<GroceryItem, GroceryItem, QDistinct> {
  QueryBuilder<GroceryItem, GroceryItem, QDistinct> distinctByChecked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'checked');
    });
  }

  QueryBuilder<GroceryItem, GroceryItem, QDistinct> distinctByItem(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'item', caseSensitive: caseSensitive);
    });
  }
}

extension GroceryItemQueryProperty
    on QueryBuilder<GroceryItem, GroceryItem, QQueryProperty> {
  QueryBuilder<GroceryItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GroceryItem, bool, QQueryOperations> checkedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checked');
    });
  }

  QueryBuilder<GroceryItem, String?, QQueryOperations> itemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'item');
    });
  }
}
