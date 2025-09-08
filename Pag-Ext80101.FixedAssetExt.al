/// <summary>
/// PageExtension FA Card Ext (ID 80140) extends Record Fixed Asset Card.
/// </summary>
pageextension 80140 "FA Card Ext" extends "Fixed Asset Card"
{
    layout
    {
        addlast(General)
        {
            group("Harvesting")
            {
                ShowCaption = false;
                field("Harvesting Status"; Rec."Harvesting Status")
                {
                    ApplicationArea = All;
                }

                field("Harvest Quantity"; Rec."Harvest Quantity")
                {
                    ApplicationArea = All;
                }
            }

            group("Additional Dimensions")
            {
                field("Shortcut Dimension 3"; ShortcutDim3Value)
                {
                    ApplicationArea = All;
                    Visible = ShowDim3;
                }
                field("Shortcut Dimension 4"; ShortcutDim4Value)
                {
                    ApplicationArea = All;
                    Visible = ShowDim4;
                }
                field("Shortcut Dimension 5"; ShortcutDim5Value)
                {
                    ApplicationArea = All;
                    Visible = ShowDim5;
                }
                field("Shortcut Dimension 6"; ShortcutDim6Value)
                {
                    ApplicationArea = All;
                    Visible = ShowDim6;
                }
                field("Shortcut Dimension 7"; ShortcutDim7Value)
                {
                    ApplicationArea = All;
                    Visible = ShowDim7;
                }
                field("Shortcut Dimension 8"; ShortcutDim8Value)
                {
                    ApplicationArea = All;
                    Visible = ShowDim8;
                }
            }
        }
    }

    var
        ShortcutDim3Value: Code[20];
        ShortcutDim4Value: Code[20];
        ShortcutDim5Value: Code[20];
        ShortcutDim6Value: Code[20];
        ShortcutDim7Value: Code[20];
        ShortcutDim8Value: Code[20];

        ShowDim3: Boolean;
        ShowDim4: Boolean;
        ShowDim5: Boolean;
        ShowDim6: Boolean;
        ShowDim7: Boolean;
        ShowDim8: Boolean;

        GLSetup: Record "General Ledger Setup";
        DefaultDim: Record "Default Dimension";

    trigger OnAfterGetRecord()
    begin
        LoadShortcutDimValues();
    end;

    trigger OnOpenPage()
    begin
        SetVisibleDims();
    end;

    local procedure LoadShortcutDimValues()
    begin
        Clear(ShortcutDim3Value);
        Clear(ShortcutDim4Value);
        Clear(ShortcutDim5Value);
        Clear(ShortcutDim6Value);
        Clear(ShortcutDim7Value);
        Clear(ShortcutDim8Value);
        if DefaultDim.Get(DATABASE::"Fixed Asset", Rec."No.", GLSetup."Shortcut Dimension 3 Code") then
            ShortcutDim3Value := DefaultDim."Dimension Value Code";
        if DefaultDim.Get(DATABASE::"Fixed Asset", Rec."No.", GLSetup."Shortcut Dimension 4 Code") then
            ShortcutDim4Value := DefaultDim."Dimension Value Code";
        if DefaultDim.Get(DATABASE::"Fixed Asset", Rec."No.", GLSetup."Shortcut Dimension 5 Code") then
            ShortcutDim5Value := DefaultDim."Dimension Value Code";
        if DefaultDim.Get(DATABASE::"Fixed Asset", Rec."No.", GLSetup."Shortcut Dimension 6 Code") then
            ShortcutDim6Value := DefaultDim."Dimension Value Code";
        if DefaultDim.Get(DATABASE::"Fixed Asset", Rec."No.", GLSetup."Shortcut Dimension 7 Code") then
            ShortcutDim7Value := DefaultDim."Dimension Value Code";
        if DefaultDim.Get(DATABASE::"Fixed Asset", Rec."No.", GLSetup."Shortcut Dimension 8 Code") then
            ShortcutDim8Value := DefaultDim."Dimension Value Code";
    end;
    local procedure SetVisibleDims()
    begin
        if GLSetup.Get() then begin
            ShowDim3 := GLSetup."Shortcut Dimension 3 Code" <> '';
            ShowDim4 := GLSetup."Shortcut Dimension 4 Code" <> '';
            ShowDim5 := GLSetup."Shortcut Dimension 5 Code" <> '';
            ShowDim6 := GLSetup."Shortcut Dimension 6 Code" <> '';
            ShowDim7 := GLSetup."Shortcut Dimension 7 Code" <> '';
            ShowDim8 := GLSetup."Shortcut Dimension 8 Code" <> '';
        end;
    end;
}