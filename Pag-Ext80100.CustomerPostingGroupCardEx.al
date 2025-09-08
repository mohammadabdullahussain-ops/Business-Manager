/// <summary>
/// PageExtension Customer Posting Group Card Ex (ID 80100) extends Record Customer Posting Group Card.
/// </summary>
pageextension 80138 "Customer Posting Group Card Ex" extends "Customer Posting Group Card"
{
    layout
    {
        addafter("Receivables Account")
        {
            field("Email Statements";Rec."Email Statements")
            {
                ApplicationArea = All;
                Caption = 'Email Statements';
                ToolTip = 'Email Statements';
            }
        }
    }
}
