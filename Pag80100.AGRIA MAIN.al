/// <summary>
/// Page AGRIA MAIN Role Center (ID 80100).
/// </summary>
namespace Microsoft.Finance.RoleCenters;

using Microsoft.Bank.BankAccount;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Foundation.Period;
using Microsoft.Finance.VAT.Ledger;
using BusinessManager.BusinessManager;
using Microsoft.Bank.Deposit;
using Microsoft.Bank.DirectDebit;
using Microsoft.Bank.Payment;
using Microsoft.Bank.Reconciliation;
using Microsoft.Bank.Setup;
using Microsoft.Bank.Statement;
using Microsoft.CashFlow.Account;
using Microsoft.CashFlow.Forecast;
using Microsoft.CashFlow.Setup;
using Microsoft.EServices.EDocument;
using Microsoft.Finance.AllocationAccount;
using Microsoft.Finance.Currency;
using Microsoft.Finance.Dimension;
using Microsoft.Finance.FinancialReports;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Budget;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.SalesTax;
using Microsoft.Finance.VAT.Reporting;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Foundation.Navigate;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Task;
using Microsoft.HumanResources.Employee;
using Microsoft.Integration.Entity;
using Microsoft.Intercompany;
using Microsoft.Inventory.Analysis;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Analysis;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Payables;
using Microsoft.Purchases.Vendor;
using Microsoft.RoleCenters;
using Microsoft.Sales.Analysis;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.FinanceCharge;
using Microsoft.Sales.History;
using Microsoft.Sales.Reminder;
using System.Automation;
using System.Email;
using System.Environment;
using System.Integration.PowerBI;
using System.Threading;
using System.Visualization;

page 80100 "AGRIA MAIN Role Center"
{
    // CurrPage."Help And Setup List".ShowFeatured;
    Caption = 'AGRIA MAIN';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control139; "Headline RC Business Manager")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control16; "O365 Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                ApplicationArea = Basic, Suite;
            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = Suite;
            }
            part("Job Queue Tasks Activities"; "Job Queue Tasks Activities")
            {
                ApplicationArea = Suite;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            part("Intercompany Activities"; "Intercompany Activities")
            {
                ApplicationArea = Intercompany;
            }
            part(Control46; "Team Member Activities No Msgs")
            {
                ApplicationArea = Suite;
            }
            part(Control55; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
                Caption = '';
            }
            part("Favorite Accounts"; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Favorite Accounts';
            }
            part(Control9; "Trial Balance")
            {
                AccessByPermission = TableData "G/L Entry" = R;
                ApplicationArea = Basic, Suite;
            }
            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                AccessByPermission = TableData "Power BI Context Settings" = I;
                ApplicationArea = Basic, Suite;
            }
            part("My Job Queue"; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control96; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Suite;
            }
            part(PowerBIEmbeddedReportPart2; "Power BI Embedded Report Part")
            {
                AccessByPermission = TableData "Power BI Context Settings" = I;
                ApplicationArea = Basic, Suite;
                SubPageView = where(Context = const('Power BI Part II'));
                Visible = false;
            }
            part(PowerBIEmbeddedReportPart3; "Power BI Embedded Report Part")
            {
                AccessByPermission = TableData "Power BI Context Settings" = I;
                ApplicationArea = Basic, Suite;
                SubPageView = where(Context = const('Power BI Part III'));
                Visible = false;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Sales Quote")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Quote';
                Image = NewSalesQuote;
                RunObject = Page "Sales Quote";
                RunPageMode = Create;
                ToolTip = 'Offer items or services to a customer.';
            }
            action("Sales Order")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Order';
                Image = NewOrder;
                RunObject = Page "Sales Order";
                RunPageMode = Create;
                ToolTip = 'Create a new sales order for items or services.';
            }
            action("Sales Invoice")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice';
                Image = NewSalesInvoice;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
            }
            action("Purchase Quote")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Suite;
                Caption = 'Purchase Quote';
                Image = NewSalesQuote;
                RunObject = Page "Purchase Quote";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase quote.';
            }
            action("<Page Purchase Order>")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Suite;
                Caption = 'Purchase Order';
                Image = NewOrder;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase order.';
            }
            action("Purchase Invoice")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoice';
                Image = NewPurchaseInvoice;
                RunObject = Page "Purchase Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a purchase invoice to mirror a sales document sent by a vendor.';
            }
        }
        area(processing)
        {
            action("Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                RunObject = Page Navigate;
                ShortCutKey = 'Ctrl+Alt+Q';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
            }
            group(New)
            {
                Caption = 'New';
                Image = New;
                action(Customer)
                {
                    AccessByPermission = TableData Customer = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Image = Customer;
                    RunObject = Page "Customer Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new customer.';
                }
                action(Vendor)
                {
                    AccessByPermission = TableData Vendor = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new vendor.';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                action("Payment Reconciliation Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reconcile Imported Payments';
                    Image = ApplyEntries;
                    RunObject = Codeunit "Pmt. Rec. Journals Launcher";
                    ToolTip = 'Reconcile your bank account by importing transactions and applying them, automatically or manually, to open customer ledger entries, open vendor ledger entries, or open bank account ledger entries.';
                }
                action("Import Bank Transactions")
                {
                    AccessByPermission = TableData "Bank Export/Import Setup" = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Bank Transactions...';
                    Image = Import;
                    RunObject = Codeunit "Pmt. Rec. Jnl. Import Trans.";
                    ToolTip = 'To start the process of reconciling new payments, import a bank feed or electronic file containing the related bank transactions.';
                }
                action("Register Customer Payments")
                {
                    AccessByPermission = TableData "Payment Registration Setup" = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Register Customer Payments';
                    Image = Payment;
                    RunObject = Page "Payment Registration";
                    ToolTip = 'Process your customer payments by matching amounts received on your bank account with the related unpaid sales invoices, and then post the payments.';
                }
                action("Create Vendor Payments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Vendor Payments';
                    Image = SuggestVendorPayments;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageView = where("Document Type" = filter(Invoice),
                                        "Remaining Amount" = filter(< 0),
                                        "Applies-to ID" = filter(''));
                    ToolTip = 'Opens vendor ledger entries for all vendors with invoices that have not been paid yet.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group("Financial Statements")
                {
                    Caption = 'Financial Statements';
                    Image = ReferenceData;
                    action("Balance Sheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        RunObject = Report "Balance Sheet";
                        ToolTip = 'View your company''s assets, liabilities, and equity.';
                    }
                    action("Income Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";
                        RunObject = Report "Income Statement";
                        ToolTip = 'View your company''s income and expenses.';
                    }
                    action("Statement of Cash Flows")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Cash Flows';
                        Image = "Report";
                        RunObject = Report "Statement of Cashflows";
                        ToolTip = 'View a financial statement that shows how changes in balance sheet accounts and income affect the company''s cash holdings, displayed for operating, investing, and financing activities respectively.';
                    }
                    action("Statement of Retained Earnings")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Retained Earnings';
                        Image = "Report";
                        RunObject = Report "Retained Earnings Statement";
                        ToolTip = 'View a report that shows your company''s changes in retained earnings for a specified period by reconciling the beginning and ending retained earnings for the period, using information such as net income from the other financial statements.';
                    }
                    action("Sales Taxes Collected")
                    {
                        ApplicationArea = SalesTax;
                        Caption = 'Sales Taxes Collected';
                        Image = "Report";
                        RunObject = Report "Sales Taxes Collected";
                        ToolTip = 'View a report that shows the sales taxes that have been collected on behalf of the authorities.';
                    }
                }
            }
        }
        area(reporting)
        {
            group("Excel Reports")
            {
                Caption = 'Excel Reports';
                Image = Excel;
                action(ExcelTemplatesBalanceSheet)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Sheet';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Balance Sheet";
                    ToolTip = 'Open a spreadsheet that shows your company''s assets, liabilities, and equity.';
                }
                action(ExcelTemplateIncomeStmt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Income Statement';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Income Stmt.";
                    ToolTip = 'Open a spreadsheet that shows your company''s income and expenses.';
                }
                action(ExcelTemplateCashFlowStmt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Statement';
                    Image = "Report";
                    RunObject = Codeunit "Run Template CashFlow Stmt.";
                    ToolTip = 'Open a spreadsheet that shows how changes in balance sheet accounts and income affect the company''s cash holdings.';
                }
                action(ExcelTemplateRetainedEarn)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Retained Earnings Statement';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Retained Earn.";
                    ToolTip = 'Open a spreadsheet that shows your company''s changes in retained earnings based on net income from the other financial statements.';
                }
#if not CLEAN25
                action(ExcelTemplateTrialBalance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Trial Balance";
                    ToolTip = 'Open a spreadsheet that shows a summary trial balance by account.';
                    ObsoleteReason = 'Functionality replaced by "EXR Trial Balance Excel". Extend this report object with Excel layout instead.';
                    ObsoleteState = Pending;
                    ObsoleteTag = '25.0';
                }
                action(ExcelTemplateAgedAccPay)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Payable';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Aged Acc. Pay.";
                    ToolTip = 'Open a spreadsheet that shows a list of aged remaining balances for each vendor by period.';
                    ObsoleteReason = 'Functionality replaced by "EXR Aged Acc Payable Excel". Extend this report object with Excel layout instead.';
                    ObsoleteState = Pending;
                    ObsoleteTag = '25.0';
                }
                action(ExcelTemplateAgedAccRec)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Receivable';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Aged Acc. Rec.";
                    ToolTip = 'Open a spreadsheet that shows when customer payments are due or overdue by period.';
                    ObsoleteReason = 'Functionality replaced by  "EXR Aged Accounts Rec Excel". Extend this report object with Excel layout instead.';
                    ObsoleteState = Pending;
                    ObsoleteTag = '25.0';
                }
#endif
            }
        }
        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, trial balance, and favorite customers.';
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action(Vendors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendors';
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items';
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action("Bank Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action("Chart of Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
            }
        }
        area(sections)
        {
            group(Action39)
            {
                Caption = 'Accounts Receivable';
                Image = Journals;
                ToolTip = 'Accounts Receivable';
                action(CustomerList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    Image = Customer;
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
            }
            group("Accounts Payable")
            {
                Caption = 'Accounts Payable';
                ToolTip = 'Accounts Payable';
                action("Vendor List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    RunObject = Page "Vendor List";
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
            }
            group(Action40)
            {
                Caption = 'Fixed Assets';
                Image = Sales;
                ToolTip = 'Fixed Assets';
                action("Fixed Asset List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Fixed Asset';
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Fixed Asset List';
                }
            }
            group(Action41)
            {
                Caption = 'Inventory';
                Image = List;
                ToolTip = 'Inventory';
                action(ItemList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
                }
            }
            group(Action42)
            {
                Caption = 'VAT';
                Image = List;
                ToolTip = 'VAT';
                action("VAT Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'VAT Entries';
                    RunObject = Page "VAT Entries";
                    ToolTip = 'View VAT Entries Page';
                }
            }
            group(Action43)
            {
                Caption = 'Reports';
                Image = List;
                ToolTip = 'Reports';
                action("Trail Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trail Balance';
                    RunObject = Page "Trial Balance";
                    ToolTip = 'View Trial Balance';
                }
            }
            group(Action44)
            {
                Caption = 'Approvals';
                Image = List;
                ToolTip = 'Approvals';
                action("Approvals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals Entries';
                    RunObject = Page "Approval Entries";
                    ToolTip = 'View Approval Entries Page';
                }
            }
            group(Action45)
            {
                Caption = 'Administration';
                Image = List;
                ToolTip = 'Administration';
                action("Accounting Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Accounting Periods';
                    RunObject = Page "Accounting Periods";
                    ToolTip = 'View Accounting Periods';
                }
            }
            group(Action46)
            {
                Caption = 'Set Up';
                Image = List;
                ToolTip = 'Set Up';
                action("General Ledger Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Ledger Setup';
                    RunObject = Page "General Ledger Setup";
                    ToolTip = 'View General Ledger Setup';
                }
            }
        }
    }
   
}

