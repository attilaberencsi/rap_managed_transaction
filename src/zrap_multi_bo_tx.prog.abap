*&---------------------------------------------------------------------*
*& Report zrap_multi_bo_tx
*&---------------------------------------------------------------------*
*& Multiple BO Updates in 1 Tx using the transactional buffer of RAP.
*& Validations defined in the Behavior are executed on statement
*& COMMIT ENTITIES.
*& Note:
*& Inside a behavior implementation You cannot issue COMMIT ENTITIES
*& it is an illegal operation.
*&---------------------------------------------------------------------*
REPORT zrap_multi_bo_tx.

DATA:
  g_artists TYPE TABLE FOR CREATE ZI_Artists\\ZI_Artists,
  g_tracks  TYPE TABLE FOR CREATE ZI_Tracks\\ZI_Tracks.

PARAMETERS:
  p_wipe RADIOBUTTON GROUP r1,
  p_load RADIOBUTTON GROUP r1.

START-OF-SELECTION.
  CASE abap_true.
    WHEN p_wipe.

    WHEN p_load.

      g_artists = VALUE #( ( %cid          = 'cid_001'
                             name          = 'Party Heroes'
                             %control-Name = if_abap_behv=>mk-on ) ).

      MODIFY ENTITIES OF ZI_Artists
             ENTITY ZI_Artists CREATE FROM g_artists
             MAPPED   DATA(artists_mapped)
             FAILED   DATA(artists_failed)
             REPORTED DATA(artists_reported).

      g_tracks = VALUE #( ( %cid               = 'cid_002'
                            title              = '5am'
                            ArtistKey          = artists_mapped-zi_artists[ 1 ]-EntityKey
                            %control-Title     = if_abap_behv=>mk-on
                            %control-ArtistKey = if_abap_behv=>mk-on ) ).

      MODIFY ENTITIES OF ZI_Tracks
             ENTITY ZI_Tracks CREATE FROM g_tracks
             MAPPED   DATA(tracks_mapped)
             FAILED   DATA(tracks_failed)
             REPORTED DATA(tracks_reported).

  ENDCASE.

  "Atomicity: In case of failure in any Behavior Implementation Validations, nothing is persisted!
  COMMIT ENTITIES RESPONSES
         FAILED FINAL(failed).

  BREAK-POINT.
