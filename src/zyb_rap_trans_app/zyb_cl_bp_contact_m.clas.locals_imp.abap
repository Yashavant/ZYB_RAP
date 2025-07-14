CLASS lhc_Contact DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Contact RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Contact RESULT result.
    METHODS SetStatus FOR MODIFY
      IMPORTING keys FOR ACTION Contact~SetStatus RESULT result.
    METHODS copyContact FOR MODIFY
      IMPORTING keys FOR ACTION Contact~copyContact.
    METHODS createContact FOR MODIFY
      IMPORTING keys FOR ACTION Contact~createContact.
    METHODS calculateAge FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Contact~calculateAge.
    METHODS validateDob FOR VALIDATE ON SAVE
      IMPORTING keys FOR Contact~validateDob.

    METHODS validateEntry FOR VALIDATE ON SAVE
      IMPORTING keys FOR Contact~validateEntry.
    METHODS validateTel FOR VALIDATE ON SAVE
      IMPORTING keys FOR Contact~validateTel.

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

  METHOD copyContact.
    "Read Selected Instance
    READ ENTITIES OF zyb_i_contact_m IN LOCAL MODE ENTITY Contact
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_selected_contact).

    "Copy as new Instance

    MODIFY ENTITIES OF zyb_i_contact_m IN LOCAL MODE ENTITY Contact
    CREATE FIELDS ( FirstName MiddleName LastName Gender Dob Telephone Email Active )
    WITH VALUE #( FOR ls_sel_contact IN lt_selected_contact (
    %cid = keys[ KEY entity %key =  ls_sel_contact-%key ]-%cid
    %data = CORRESPONDING #( ls_sel_contact EXCEPT ContactId )
     ) )
    MAPPED DATA(lt_mapped).

    "pass Data back to front-end
    mapped-contact = lt_mapped-contact.

  ENDMETHOD.

  METHOD createContact.
    "Create An instance of Entity with default Values

    MODIFY ENTITIES OF zyb_i_contact_m IN LOCAL MODE
    ENTITY Contact CREATE
    FROM VALUE #(
    FOR ls_instance IN keys (
    %cid = ls_instance-%cid
    %data = VALUE #( FirstName = 'FNm' Gender = 'U' Active = abap_true  )
    %control = VALUE #( FirstName = if_abap_behv=>mk-on
                        Gender = if_abap_behv=>mk-on
                        Active = if_abap_behv=>mk-on )
    )
    )

    MAPPED mapped FAILED failed REPORTED reported.


  ENDMETHOD.

  METHOD calculateAge.
    "Get Todays Date
    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).


    READ ENTITIES OF zyb_i_contact_m IN LOCAL MODE
    ENTITY Contact FIELDS ( Dob ) WITH CORRESPONDING #( keys )
    RESULT DATA(lt_dob).

    LOOP AT lt_dob INTO DATA(ls_dob).
      DATA(lv_age) = COND #( WHEN ls_dob IS INITIAL THEN 0
                            ELSE  lv_date(4) - ls_dob-Dob(4) ).
      IF lv_date(4) < ls_dob-Dob(4) .
        lv_age -= 1.
      ENDIF.

      "Update to front-end

      MODIFY ENTITIES OF zyb_i_contact_m IN LOCAL MODE
      ENTITY Contact UPDATE FIELDS ( Age )
      WITH VALUE #( (
                %tky = ls_dob-%tky
                %data-Age = lv_age
                %control-Age = if_abap_behv=>mk-on
       ) ).

    ENDLOOP.


  ENDMETHOD.

  METHOD validateDob.


  ENDMETHOD.

  METHOD validateEntry.


  ENDMETHOD.

  METHOD validateTel.
    DATA:lv_tele TYPE c LENGTH 10.
    READ ENTITIES OF zyb_i_contact_m IN LOCAL MODE
    ENTITY Contact
    FIELDS ( Telephone )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_telephone).

    LOOP AT lt_telephone INTO DATA(ls_telephone).
      "Validate Telephone
      IF ls_telephone-Telephone IS NOT INITIAL.
        lv_tele = ls_telephone-Telephone.
        lv_tele = |{  lv_tele ALPHA = OUT }|.
        DATA(lv_len) = strlen( lv_tele ).
        IF lv_len <> 10.
          " error Validation
          APPEND VALUE #( %tky = ls_telephone-%tky ) TO failed-contact.
          APPEND VALUE #( %tky = ls_telephone-%tky
                          %element-telephone = if_abap_behv=>mk-on
                          %msg = new_message_with_text(
                          severity = if_abap_behv_message=>severity-error
                          text = 'Telephone Number Must be 10 Char'

                          )

           ) TO reported-contact.


        ENDIF.

      ENDIF.

    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
