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
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Contact RESULT result.
    METHODS validatename FOR VALIDATE ON SAVE
      IMPORTING keys FOR contact~validatename.
    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE contact.
    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE contact.

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

  METHOD get_instance_features.
    "Read Instance
    READ ENTITIES OF zyb_i_contact_m IN LOCAL MODE
    ENTITY Contact ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_contact).

    "    result  = VALUE #(
    "   FOR ls_contact IN lt_contact (
    "  %tky = ls_contact-%tky
    " %field-FirstName = COND #( WHEN ls_contact-Active = abap_true THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
    "%field-MiddleName = COND #( WHEN ls_contact-Active = abap_true THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
    "%field-LastName = COND #( WHEN ls_contact-Active = abap_true THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
    "%update = COND #( WHEN ls_contact-Active = abap_true THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled ) " Enable/Disble Edit button on Object(Details Page)
    ")).

  ENDMETHOD.

  METHOD validateName.

    READ ENTITIES OF zyb_i_contact_m IN LOCAL MODE
    ENTITY Contact ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_names).

    LOOP AT lt_names INTO DATA(ls_names).

      IF ls_names-FirstName IS INITIAL.
        APPEND VALUE #( %tky = ls_names-%tky ) TO failed-contact.

        APPEND VALUE #(
        %tky = ls_names-%tky
        %element-FirstName = if_abap_behv=>mk-on
        %msg = NEW_message_with_text(
         severity = if_abap_behv_message=>severity-error
         text = 'First Name is Mandatory'
        )
         ) TO reported-contact.

      ENDIF.

      IF ls_names-LastName IS INITIAL.
        APPEND VALUE #( %tky = ls_names-%tky ) TO failed-contact.

        APPEND VALUE #(
        %tky = ls_names-%tky
        %element-LastName = if_abap_behv=>mk-on
        %msg = NEW_message_with_text(
         severity = if_abap_behv_message=>severity-error
         text = 'Last Name is Mandatory'
        )
         ) TO reported-contact.

      ENDIF.

    ENDLOOP.


  ENDMETHOD.

  METHOD precheck_update.

    LOOP AT entities INTO DATA(ls_Contact).

      "cheched field values changed or not, if checked then ls_Contact-%control-FirstName will mark as on
      CHECK: ls_Contact-%control-FirstName = if_abap_behv=>mk-on OR
            ls_Contact-%control-MiddleName = if_abap_behv=>mk-on OR
            ls_Contact-%control-LastName = if_abap_behv=>mk-on OR
            ls_Contact-%control-Gender = if_abap_behv=>mk-on OR
            ls_Contact-%control-dob = if_abap_behv=>mk-on OR
            ls_Contact-%control-Telephone = if_abap_behv=>mk-on OR
            ls_Contact-%control-Email = if_abap_behv=>mk-on OR
            ls_Contact-%control-Active = if_abap_behv=>mk-on.

      IF ls_Contact-%control-FirstName = if_abap_behv=>mk-on.

        IF ls_Contact-FirstName IS INITIAL.
          IF ls_Contact-FirstName IS INITIAL.
            APPEND VALUE #( %tky = ls_Contact-%tky ) TO failed-contact.   " In Create %CID need to pass(%tky is not exist for new record) and in Update %tky need to pass

            APPEND VALUE #(
            %tky = ls_Contact-%tky
            %element-FirstName = if_abap_behv=>mk-on
            %msg = NEW_message_with_text(
             severity = if_abap_behv_message=>severity-error
             text = 'First Name is Mandatory'
            )
             ) TO reported-contact.

          ENDIF.
        ENDIF.
      ENDIF.

      IF ls_Contact-%control-LastName = if_abap_behv=>mk-on.

        IF ls_Contact-LastName IS INITIAL.
          IF ls_Contact-LastName IS INITIAL.
            APPEND VALUE #( %tky = ls_Contact-%tky ) TO failed-contact.

            APPEND VALUE #(
            %tky = ls_Contact-%tky
            %element-LastName = if_abap_behv=>mk-on
            %msg = NEW_message_with_text(
             severity = if_abap_behv_message=>severity-error
             text = 'Last Name is Mandatory'
            )
             ) TO reported-contact.

          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD precheck_create.

     LOOP AT entities INTO DATA(ls_Contact).

      "cheched field values changed or not, if checked then ls_Contact-%control-FirstName will mark as on
      CHECK: ls_Contact-%control-FirstName = if_abap_behv=>mk-on OR
            ls_Contact-%control-MiddleName = if_abap_behv=>mk-on OR
            ls_Contact-%control-LastName = if_abap_behv=>mk-on OR
            ls_Contact-%control-Gender = if_abap_behv=>mk-on OR
            ls_Contact-%control-dob = if_abap_behv=>mk-on OR
            ls_Contact-%control-Telephone = if_abap_behv=>mk-on OR
            ls_Contact-%control-Email = if_abap_behv=>mk-on OR
            ls_Contact-%control-Active = if_abap_behv=>mk-on.

      IF ls_Contact-%control-FirstName = if_abap_behv=>mk-on.

        IF ls_Contact-FirstName IS INITIAL.
          IF ls_Contact-FirstName IS INITIAL.
            APPEND VALUE #( %cid = ls_Contact-%cid ) TO failed-contact.    " In Create %CID need to pass(%tky is not exist for new record) and in Update %tky need to pass
            APPEND VALUE #(
            %cid = ls_Contact-%cid
            %element-FirstName = if_abap_behv=>mk-on
            %msg = NEW_message_with_text(
             severity = if_abap_behv_message=>severity-error
             text = 'First Name is Mandatory'
            )
             ) TO reported-contact.

          ENDIF.
        ENDIF.
      ENDIF.

      IF ls_Contact-%control-LastName = if_abap_behv=>mk-on.

        IF ls_Contact-LastName IS INITIAL.
          IF ls_Contact-LastName IS INITIAL.
            APPEND VALUE #( %cid = ls_Contact-%cid ) TO failed-contact.

            APPEND VALUE #(
            %cid = ls_Contact-%cid
            %element-LastName = if_abap_behv=>mk-on
            %msg = NEW_message_with_text(
             severity = if_abap_behv_message=>severity-error
             text = 'Last Name is Mandatory'
            )
             ) TO reported-contact.

          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
