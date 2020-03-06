unit PinYinDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    btn1: TButton;
    lbl1: TLabel;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  HzSpell;

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  lbl1.Caption :=  HzSpell.THzSpell.PyOfHz(edt1.Text);
end;

end.
