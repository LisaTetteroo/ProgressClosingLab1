            /*------------------------------------------------------------------------
    File        : blCalcMonthlySales.p
    Purpose     : Week 1 Closing Lab 1

    Syntax      :

    Description : Sales rep series calculation

    Author(s)   : M.Squintani
    Created     : Tue Dec 20 08:30:51 UTC 2016
    Notes       : In sports2000 database:
                  - All orders are from years 1997 and 1998 only
                  - SalesReps: BBB, DKP, DOS, GPE, HXM, JAL, KIK, RDR, SLS 
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

//{Labs\Include\ttSales.i}
/* ********************  Preprocessor Definitions  ******************** */

/* ***************************  Main Block  *************************** */
DEFINE INPUT PARAMETER  piYear AS INTEGER NO-UNDO.
DEFINE INPUT PARAMETER  pcSalesRep AS CHAR NO-UNDO.
//define output parameter TABLE for ttSales.
DEFINE OUTPUT PARAMETER pcStatus AS LOGICAL NO-UNDO.

DEFINE VARIABLE totalOrder AS DECIMAL NO-UNDO INIT 0.

pcStatus = TRUE.
//EMPTY TEMP-TABLE ttSales.

// Preliminary check on existence of an Order for the input year
FIND FIRST Order WHERE YEAR(Order.OrderDate) = piYear NO-LOCK NO-ERROR.
IF NOT AVAILABLE (Order) THEN 
DO:
    pcStatus = FALSE.
    RETURN ERROR "No Orders for fiscal year " + string(piYear).
END.
// Preliminary check on existence of a Salerep for the input Salesrep
FIND FIRST Salesrep WHERE Salesrep.SalesRep = pcSalesRep NO-LOCK NO-ERROR.
IF NOT AVAILABLE (Salesrep) THEN 
DO:
    pcStatus = FALSE.
    RETURN ERROR "No Salesrep for sales rep " + string(pcSalesRep).
END.  
// Preliminary check on existence of an Order for the input Salesrep
FIND FIRST Order WHERE Order.SalesRep = pcSalesRep NO-LOCK NO-ERROR.
IF NOT AVAILABLE (Order) THEN 
DO:
    pcStatus = FALSE.
    RETURN ERROR "No Order for sales rep " + string(pcSalesRep) +
                 "for fiscal year " + string(piYear) .
END.  

FOR FIRST Salesrep WHERE Salesrep.SalesRep = pcSalesRep NO-LOCK,                      
    EACH Order OF Salesrep WHERE YEAR(Order.OrderDate) = piYear NO-LOCK,
        EACH OrderLine OF Order NO-LOCK
        BREAK BY MONTH(Order.OrderDate) :
    
        ASSIGN 
            totalOrder = totalOrder + OrderLine.ExtendedPrice no-error.
        IF ERROR-STATUS:ERROR THEN 
        DO:
            pcStatus = FALSE.
            RETURN ERROR "Extended Price for Order " + string(Order.Ordernum) + "does not contain decimal values!".  
        END.    
    
        IF LAST-OF(MONTH(Order.OrderDate)) THEN 
        //DO:
          //  CREATE ttSales.
            //ASSIGN  
                //ttsales.Salesrep   = Order.SalesRep
              //  ttSales.SalesName  = Salesrep.RepName
               // ttSales.MONTH      = MONTH(Order.OrderDate)
                //ttSales.TotalSales = totalOrder.
            //ASSIGN 
              //  totalOrder = 0.
        //END.
    END.

