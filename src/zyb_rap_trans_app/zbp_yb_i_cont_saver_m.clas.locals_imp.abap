CLASS lsc_ZYB_I_CONTACT_M DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZYB_I_CONTACT_M IMPLEMENTATION.

  METHOD save_modified.
    IF create-contact IS NOT INITIAL.

    ENDIF.

    IF update-contact IS NOT INITIAL.

    ENDIF.
    IF delete-contact IS NOT INITIAL.

    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
