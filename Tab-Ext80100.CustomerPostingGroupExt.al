/// <summary>
/// TableExtension Customer Posting Group Ext (ID 80100) extends Record Customer Posting Group.
/// </summary>
tableextension 80138 "Customer Posting Group Ext" extends "Customer Posting Group"
{
    fields
    {
        field(80100; "Email Statements"; Boolean)
        {
            Caption = 'Email Statements';
            DataClassification = CustomerContent;
        }

    }
}
