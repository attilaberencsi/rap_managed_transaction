CLASS lhc_ZI_Artists DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ZI_Artists RESULT result.

ENDCLASS.

CLASS lhc_ZI_Artists IMPLEMENTATION.

  METHOD get_global_authorizations.
    result-%create = result-%delete = result-%update = if_abap_behv=>auth-allowed.
  ENDMETHOD.

ENDCLASS.
