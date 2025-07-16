CLASS lhc_address DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateAddress FOR VALIDATE ON SAVE
      IMPORTING keys FOR Address~validateAddress.

ENDCLASS.

CLASS lhc_address IMPLEMENTATION.

  METHOD validateAddress.

    READ ENTITIES OF zyb_i_contact_m IN LOCAL MODE
   ENTITY Address ALL FIELDS WITH CORRESPONDING #( keys )
   RESULT DATA(lt_address).

    LOOP AT lt_address INTO DATA(ls_address).

      IF ls_address-City IS INITIAL.
        APPEND VALUE #( %tky = ls_address-%tky ) TO failed-address.

        APPEND VALUE #(
        %tky = ls_address-%tky
        %element-City = if_abap_behv=>mk-on
        %msg = NEW_message_with_text(
         severity = if_abap_behv_message=>severity-error
         text = 'City is Mandatory'
        )
         ) TO reported-address.

      ENDIF.


    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
