/// <summary>
/// Unknown BusinessManager.
/// </summary>
namespace BusinessManager.BusinessManager;

page 80101 "My Header"
{
    ApplicationArea = All;
    Caption = 'My Header';
    PageType = CardPart;

    layout
    {
        area(Content)
        {
            field("Header"; 'Welcome Abdulla Manager')
            {
                ApplicationArea = All;
                Editable = false;
                Style = StrongAccent;
            }
        }
    }
}
