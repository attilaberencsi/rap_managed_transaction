@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Tracks'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_Tracks
  as select from ztracks

{
  key entity_key            as EntityKey,
      title                 as Title,
      artist_key            as ArtistKey,

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
