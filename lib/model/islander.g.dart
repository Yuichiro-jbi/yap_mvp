// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'islander.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IslanderImpl _$$IslanderImplFromJson(Map<String, dynamic> json) =>
    _$IslanderImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      experience: (json['experience'] as num).toInt(),
      sats: (json['sats'] as num).toInt(),
      completedLessonIds: (json['completedLessonIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$IslanderImplToJson(_$IslanderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'experience': instance.experience,
      'sats': instance.sats,
      'completedLessonIds': instance.completedLessonIds,
    };
