CLASS lhc_ZI_Tracks DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ZI_Tracks RESULT result.
    METHODS validate_artist_bad FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_Tracks~validate_artist_bad.

    METHODS validate_artist_good FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_Tracks~validate_artist_good.

ENDCLASS.

CLASS lhc_ZI_Tracks IMPLEMENTATION.

  METHOD get_global_authorizations.
    result-%create = result-%delete = result-%update = if_abap_behv=>auth-allowed.
  ENDMETHOD.

  METHOD validate_artist_bad.
    READ ENTITIES OF zi_tracks IN LOCAL MODE
      ENTITY ZI_Tracks FROM CORRESPONDING #( keys )
      RESULT FINAL(tracks).

    LOOP AT tracks INTO DATA(track).
      SELECT SINGLE * FROM zartists INTO @DATA(artist)
        WHERE entity_key = @track-ArtistKey.

      IF sy-subrc <> 0.
        INSERT VALUE #( %key = track-%key ) INTO TABLE failed-zi_tracks.
        "BREAK-POINT.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validate_artist_good.

    READ ENTITIES OF zi_tracks IN LOCAL MODE
     ENTITY ZI_Tracks FROM CORRESPONDING #( keys )
     RESULT FINAL(tracks).

    LOOP AT tracks INTO DATA(track).

      READ ENTITIES OF ZI_Artists
        ENTITY ZI_Artists FROM VALUE #( ( entitykey = track-ArtistKey ) )
        RESULT FINAL(artist).

      IF artist IS NOT INITIAL.
        "BREAK-POINT.
      ELSE.
        INSERT VALUE #( %key = track-%key ) INTO TABLE failed-zi_tracks.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
