/// <summary>
/// Codeunit Customer Print (ID 80100).
/// </summary>
codeunit 80138 CustomerPrint
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Print Statements', false, false)]
    local procedure UpdatePostingGroupOnStatementsChange(var Rec: Record Customer)
    var
        CustPostingGroup: Record "Customer Posting Group";
    begin
        if CustPostingGroup.Get(Rec."Customer Posting Group") then begin
            CustPostingGroup."Email Statements" := Rec."Print Statements";
            CustPostingGroup.Modify();
        end;
    end;
}
