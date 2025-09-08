/// <summary>
/// TableExtension Fixed Asset Ext (ID 80101) extends Record Fixed Asset.
/// </summary>
tableextension 80139 "Fixed Asset Ext" extends "Fixed Asset"
{
    fields
    {
        field(80100; "Harvesting Status"; Code[30])
        {
            Caption = 'Harvesting Status';
            DataClassification = CustomerContent;
            TableRelation = "Harvesting Status".Code;
        }
        field(80101; "Harvest Quantity"; Decimal)
        {
            Caption = 'Harvest Quantity';
            DataClassification = CustomerContent;
        }
    }
}
