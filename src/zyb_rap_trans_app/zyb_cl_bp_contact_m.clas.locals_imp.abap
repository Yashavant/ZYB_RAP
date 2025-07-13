CLASS lhc_Contact DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Contact RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Contact RESULT result.
    METHODS SetStatus FOR MODIFY
      IMPORTING keys FOR ACTION Contact~SetStatus RESULT result.

ENDCLASS.

CLASS lhc_Contact IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD SetStatus.

*Read Entity
    READ ENTITIES OF zyb_i_contact_m IN LOCAL MODE
    ENTITY Contact ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_contact).

*Modify Entity

    MODIFY ENTITIES OF zyb_i_contact_m IN LOCAL MODE
    ENTITY Contact
    UPDATE FIELDS ( Active  ) WITH VALUE #(
    FOR ls_contact IN lt_contact (
    %tky = ls_contact-%tky
    Active = COND #( WHEN  ls_contact-Active = abap_true THEN abap_false ELSE abap_true )
    ) )
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).

    "Pass Changed instance to back to front-end

    result = VALUE #(
    FOR ls_contact IN lt_contact (
    %tky = ls_contact-%tky
    %param = ls_contact
    )
    ).

  ENDMETHOD.

ENDCLASS.
