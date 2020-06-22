/*------------------------------------------------------------------------
    File        : blCalcMonthlySales.p
    Purpose     : Calculate sales series for each sales rep

    Syntax      :

    Description : Sales rep series calculation

    Author(s)   : M.Squintani
    Created     : Tue Dec 20 08:30:51 UTC 2016
    Notes       : In sports2000 database:
                  - All orders are from years 1997 and 1998 only
                  - SalesReps: BBB, DKP, DOS, GPE, HXM, JAL, KIK, RDR, SLS  
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.
    
define temp-table ttSales no-undo
    field SalesRep as character label "Sales Rep"
    field Month    as integer   label "Month"
    field Sales    as decimal   label "Tot. Sales"         
    index idx1 is unique SalesRep Month             
    .  

define input  parameter piYear     as integer no-undo.
define input  parameter pcSalesRep as character no-undo.
define output parameter table for ttSales by-value.

define variable totalOrder as decimal no-undo.
/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
if pcSalesRep = ? then pcSalesRep = "".
empty temp-table ttSales.                     
for each Order 
    where year(OrderDate) = piYear
    and (pcSalesRep = "" or Order.Salesrep = pcSalesRep) no-lock:
    assign 
        totalOrder = 0.
    for each OrderLine of Order no-lock:
        totalOrder = totalOrder + OrderLine.ExtendedPrice.
    end.
            
    find ttSales where ttSales.SalesRep = Order.SalesRep 
        and ttSales.Month    = MONTH(Order.OrderDate) no-error.
    if not available ttSales then 
    do:
        create ttSales.            
        assign 
            ttSales.SalesRep = Order.SalesRep
            ttSales.Month    = month(Order.OrderDate)
            ttSales.Sales    = totalOrder. 
    end.           
end.        