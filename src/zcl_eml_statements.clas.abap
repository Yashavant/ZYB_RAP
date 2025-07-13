CLASS zcl_eml_statements DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_eml_statements IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*Short Form with selected field list
    READ ENTITY ZSAC_I_BillHeader   "Behavior Definition Name
    FROM VALUE #( (
    %tky-BillId = '1000000004'    " Filter values
    %control = VALUE #( BillDate = if_abap_behv=>mk-on   "Get data of this field only
                        BillType = if_abap_behv=>mk-on
                        Currency = if_abap_behv=>mk-on )
    ) )
      RESULT DATA(lt_result_read)  " Read data
      FAILED DATA(lt_failed_read). " Error in Read then failed data will get
    IF lt_failed_read IS NOT INITIAL.
      out->write( 'Error while reading' ).
    ELSE.
      "out->write( lt_result_read ).
    ENDIF.

*Short Form with All field list
    READ ENTITY ZSAC_I_BillHeader   "Behavior Definition Name
    ALL FIELDS                       " Which field data needs to read
    WITH VALUE #( (
             %tky-BillId = '1000000004'    " Filter values
             ) )
       RESULT lt_result_read  " Read data
       FAILED lt_failed_read. " Error in Read then failed data will get
    IF lt_failed_read IS NOT INITIAL.
      out->write( 'Error while reading' ).
    ELSE.
      "out->write( lt_result_read ).
    ENDIF.

*Long Form with All field list

    READ ENTITIES OF zi_sales_header       "Behavior Definition Name
    ENTITY ZiSalesHeader                    "Entity Name
    ALL FIELDS                              " Which field data needs to read
    WITH VALUE #( ( %tky-sales_order_id = '1' ) ) " Filter values
    RESULT DATA(lt_result_read_SO)  " Read data

    ENTITY  ZiSalesHeader BY \_Salesitem     "Get Item Data in same read by Association reference
    ALL FIELDS WITH VALUE #( ( %tky-sales_order_id = '1' ) )
    RESULT DATA(lt_result_read_item).  " Read data

*Read by Association

    READ ENTITIES OF zi_sales_header
    ENTITY ZiSalesHeader BY \_Salesitem
    ALL FIELDS
    WITH VALUE #( ( %key-sales_order_id = '1' ) )
    RESULT lt_result_read_item  " Read data
    LINK DATA(lt_linked_So).


** Long Form with all Field list
    READ ENTITIES OF ZSAC_I_BillHeader   "Behavior Definition Name
             ENTITY ZSAC_I_BillHeader   " Entity Alias name from Behavior Definition
             ALL FIELDS                 " Which field data needs to read
             WITH VALUE #( (
             %tky-BillId = '1000000004'    " Filter values
             ) )
             RESULT lt_result_read  " Read data
             FAILED lt_failed_read. " Error in Read then failed data will get
    IF lt_failed_read IS NOT INITIAL.
      out->write( 'Error while reading' ).
    ELSE.
      "out->write( lt_result_read ).
    ENDIF.


*******************************************************************************************
    "MOdify -Create


*    MODIFY ENTITIES OF zi_sales_header            "Behavior Definition Name
*    ENTITY ZiSalesHeader
*    CREATE FROM VALUE #( (
*    %cid = 'Cont-001'                             "Temp Valued need to pass
*       %data = VALUE #( sales_order_id = '2' "Field valued that need update/Create
*                        order_created_date = sy-datum
*                        order_created_user = sy-uname
*                        category = 'Cat'
*                        description = 'Modify'
*                        customer_id = '100'
*                        created_by = sy-uname
*                        created_at = sy-datum )
*       %control = VALUE #( sales_order_id = if_abap_behv=>mk-on  " Flag for passed value to update/Create in table if not passed then values will not update in table
*                            order_created_date = if_abap_behv=>mk-on
*                            order_created_user = if_abap_behv=>mk-on
*                            category  = if_abap_behv=>mk-on
*                            description = if_abap_behv=>mk-on
*                            customer_id = if_abap_behv=>mk-on
*                            created_by = if_abap_behv=>mk-on
*                            created_at = if_abap_behv=>mk-on
*                         )
*         ) )
*    MAPPED DATA(lt_mapped)
*    FAILED DATA(lt_faild)
*    REPORTED DATA(lt_reported).
*    if lt_mapped is not initial.
*      "Success
*    COMMIT ENTITIES.
*    else.
*      " Error
*    endif.
*    IF sy-subrc EQ 0.
*    ELSE.
*    ENDIF.

*
**    " Modify- Create By Association
*
*    MODIFY ENTITIES OF zi_sales_header            "Behavior Definition Name
*    ENTITY ZiSalesHeader                          "Enity alise Name
*    CREATE FROM VALUE #( (
*    %cid = 'Cont-002'                             "Temp Valued need to pass
*    %data = VALUE #( sales_order_id = '3' "Field valued that need update/Create
*                     order_created_date = sy-datum
*                     order_created_user = sy-uname
*                     category = 'Cat'
*                     description = 'Modify'
*                     customer_id = '100'
*                     created_by = sy-uname
*                     created_at = sy-datum )
*    %control = VALUE #( sales_order_id = if_abap_behv=>mk-on  " Flag for passed value to update/Create in table if not passed then values will not update in table
*                        order_created_date = if_abap_behv=>mk-on
*                        order_created_user = if_abap_behv=>mk-on
*                        category  = if_abap_behv=>mk-on
*                        description = if_abap_behv=>mk-on
*                        customer_id = if_abap_behv=>mk-on
*                        created_by = if_abap_behv=>mk-on
*                        created_at = if_abap_behv=>mk-on
*                         )
*     ) )
*
*     CREATE BY \_Salesitem
*     FROM VALUE #( (
*     %cid_ref = 'Cont-002'
*     %target = VALUE #(
*     (
*     %cid = 'Cont-002-001'
*     %data = VALUE #(
** sales_order_id = '' "Field valued that need update/Create
*                      item_number = '001'
*                      material_id = '1101'
*                      material_description = 'PEN'
*                      quantity = '10'
*                      uom  = 'EA'
*                      price = '100'
*                      currency = 'INR' )
*    %control = VALUE #(
**sales_order_id = if_abap_behv=>mk-on  " Flag for passed value to update/Create in table if not passed then values will not update in table
*                        item_number = if_abap_behv=>mk-on
*                        material_id = if_abap_behv=>mk-on
*                        material_description = if_abap_behv=>mk-on
*                        quantity = if_abap_behv=>mk-on
*                        uom  = if_abap_behv=>mk-on
*                        price = if_abap_behv=>mk-on
*                        currency = if_abap_behv=>mk-on
*                         )
*     )
*     (
*     %cid = 'Cont-002-002'
*     %data = VALUE #(
**sales_order_id = '' "Field valued that need update/Create
*                      item_number = '002'
*                      material_id = '1102'
*                      material_description = 'BOOK'
*                      quantity = '10'
*                      uom  = 'EA'
*                      price = '200'
*                      currency = 'INR' )
*    %control = VALUE #(
**sales_order_id = if_abap_behv=>mk-on  " Flag for passed value to update/Create in table if not passed then values will not update in table
*                        item_number = if_abap_behv=>mk-on
*                        material_id = if_abap_behv=>mk-on
*                        material_description = if_abap_behv=>mk-on
*                        quantity = if_abap_behv=>mk-on
*                        uom  = if_abap_behv=>mk-on
*                        price = if_abap_behv=>mk-on
*                        currency = if_abap_behv=>mk-on
*                         )
*     )
*
*)
*     ) )
*    MAPPED DATA(lt_mapped)
*    FAILED DATA(lt_faild)
*    REPORTED DATA(lt_reported).
*    if lt_mapped is not initial.
*      "Success
*    COMMIT ENTITIES.
*    else.
*      " Error
*    endif.
*    IF sy-subrc EQ 0.
*    ELSE.
*    ENDIF.


******************************************************************************************************
* MODIFY - UPDATE

*    MODIFY ENTITIES OF zi_sales_header            "Behavior Definition Name
*    ENTITY ZiSalesHeader                          "Enity alise Name
*    UPDATE FIELDS ( description )
*    with VALUE #( (
*     %data = VALUE #(
*     sales_order_id = '3' "Field valued that need update/Create
*     description = 'Update'
*       )
*) )
*REPORTED DATA(lt_reportred)
*MAPPED DATA(lt_mapped)
*FAILED DATA(lt_failed).
*
*    IF lt_failed IS INITIAL.
*      "Success
*      COMMIT ENTITIES.
*    ELSE.
*      " Error
*    ENDIF.
*    IF sy-subrc EQ 0.
*    ELSE.
*    ENDIF.


******************************************************************************************************
* MODIFY - DELETE

*Main Table entry
*    MODIFY ENTITIES OF zi_sales_header            "Behavior Definition Name
*    ENTITY ZiSalesHeader                          "Enity alise Name
*    DELETE FROM
*    VALUE #( (
*    %pky-sales_order_id = '3'
*) )
*REPORTED DATA(lt_reportred)
*MAPPED DATA(lt_mapped)
*FAILED DATA(lt_failed).
*
*    IF lt_failed IS INITIAL.
*      "Success
*      COMMIT ENTITIES.
*    ELSE.
*      " Error
*    ENDIF.
*    IF sy-subrc EQ 0.
*    ELSE.
*    ENDIF.

*    MODIFY ENTITIES OF zi_sales_header            "Behavior Definition Name
*    ENTITY ZiSalesItem                         "Enity alise Name
*    DELETE FROM
*    VALUE #( (
*    %pky-sales_order_id = '3'
*    %pky-item_number = '001'
*) )
*REPORTED DATA(lt_reportred)
*MAPPED DATA(lt_mapped)
*FAILED DATA(lt_failed).
*
*    IF lt_failed IS INITIAL.
*      "Success
*      COMMIT ENTITIES.
*    ELSE.
*      " Error
*    ENDIF.
*    IF sy-subrc EQ 0.
*    ELSE.
*    ENDIF.


*********************************************************************************************
* EXECUTE






  ENDMETHOD.
ENDCLASS.
