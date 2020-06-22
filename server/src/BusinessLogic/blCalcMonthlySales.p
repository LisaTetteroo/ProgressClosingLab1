
/*------------------------------------------------------------------------
    File        : blCalcMonthlySales.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : lisa
    Created     : Mon Jun 22 13:41:28 CEST 2020
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

{include/ttSales.i}

DEFINE INPUT PARAMETER piYear AS INTEGER NO-UNDO.
DEFINE INPUT PARAMETER pcSalesRep AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER TABLE FOR ttSales.

DEFINE VARIABLE iTotalOrder AS DECIMAL NO-UNDO. 

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
FOR FIRST salesrep WHERE Salesrep.SalesRep = pcSalesRep,
    EACH order WHERE Order.SalesRep = Salesrep.SalesRep AND year(order.orderdate) = piYear, 
        EACH orderline WHERE Order.Ordernum = OrderLine.Ordernum
        BREAK BY MONTH(order.orderdate):
        
        ASSIGN iTotalOrder = iTotalOrder + OrderLine.ExtendedPrice.
        
    IF LAST-OF(MONTH(Order.OrderDate)) THEN 
    DO:
        CREATE ttSales.
        ASSIGN  
            ttsales.Salesrep   = Order.SalesRep
            ttSales.SalesName  = Salesrep.RepName
            ttSales.MONTH      = MONTH(Order.OrderDate)
            ttSales.TotalSales = itotalOrder.
        ASSIGN 
            itotalOrder = 0.
    END.
END.


/*
FOR EACH order WHERE YEAR(order.orderdate) = piYear:
    IF AVAILABLE order THEN DO:
        FIND FIRST salesrep WHERE Salesrep.SalesRep = pcSalesRep.
        FOR EACH order WHERE Order.SalesRep = pcSalesRep:
            FOR EACH orderline WHERE order.Ordernum = orderline.ordernum:
                ASSIGN iTotalOrder = iTotalOrder + OrderLine.ExtendedPrice.
            END.
        END.
        CREATE ttSales.
        ASSIGN
            ttSales.Salesrep = Order.SalesRep
            ttsales.SalesName = Salesrep.RepName
            ttSalesMonth = 
            .  
        ASSIGN iTotalOrder = 0.
    END.
END. 
*/