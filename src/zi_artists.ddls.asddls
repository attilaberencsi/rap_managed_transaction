@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Artists'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_Artists
  as select from zartists

{
  key entity_key            as EntityKey,
      name                  as Name,

      @Semantics.user.createdBy: true
      created_by            as CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,

      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
