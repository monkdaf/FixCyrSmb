unit uFixCyrSmb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  SmbTblRec=record
    p1:string;
    p2:string;
  end;

  TfFixCyrSmb = class(TForm)
    OpenDialogPLC: TOpenDialog;
    bOpenPLC: TButton;
    Memo1: TMemo;
    bClose: TBitBtn;
    Memo2: TMemo;
    Memo3: TMemo;
    bCyrToLat: TButton;
    bTranslit: TButton;
    bSaveSmblTbl: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    mmoLog: TMemo;
    procedure bOpenPLCClick(Sender: TObject);
    procedure bTranslitClick(Sender: TObject);
    procedure bCyrToLatClick(Sender: TObject);
    procedure bSaveSmblTblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
// ����� ������������ �������� � ��������� ����������
    function FindCyrSmb(s: string): boolean;
// ����� � ���������� ����� �� ������� ��������
    procedure FindSmb();
// ������������ ������� ������������� � "�������" ��������� �������
//'ABCEHKMOPTXaceoxy', -- ������������e ����� ������� �������� ��� ���������e
//'ABCEHKMOPTXaceoxy'  -- ���������e ����� ������� �������� ��� ������������e
    function SmbCyrToLat(s: string): string;
// ����������������� ������������ ������� � ��������� �������
    function SmbTranslit(s: string): string;

const
  Cyr: array [1..17] of Char=('�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�');
  Lat: array [1..17] of Char=('A','B','C','E','H','K','M','O','P','T','X','a','c','e','o','x','y');

  TranslCyr: array [1..33] of Char=('�','�','�','�','�','�','�','�','�','�','�','�',
  '�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�');
  TranslLat: array [1..33] of String=('a','b','v','g','d','e','jo','zh','z','i','j','k',
  'l','m','n','o','p','r','s','t','u','f','kh','c','ch','sh','shh','','y','','eh','yu','ya');

var
  fFixCyrSmb: TfFixCyrSmb;
  SmbTbl: array[0..10000] of SmbTblRec;
  CntStr: Integer;
  priCyrSmb: Boolean=False; // � ����� ���� �� ����� ���������� ������������ ������������ �������
implementation

{$R *.dfm}
// ����� ������������ �������� � ��������� ����������
function FindCyrSmb(s: string): boolean;
var
  i:Integer;
begin
  for i := 1 to Length(s) do
  if s[i] in ['�'..'�', '�', '�'] then
  begin
//    MessageDlg('��� ������� � ����� ����� ���������� ("'+ s+'") ���������� ������������ �������.'#13#10'�� ��������� ���������� ������ ������������� ��������� ����� ����������.'#13#10'��� �������� �������, � �������,������� �������� <���_���������>', mtError, [mbOk], 0);
    FindCyrSmb:=True;
    Exit;
  end;
  FindCyrSmb:=False;
end;

procedure TfFixCyrSmb.bOpenPLCClick(Sender: TObject);
begin
// ��������� ���������� ����� � Memo1
 if OpenDialogPLC.Execute then
 begin
   Memo1.Clear;
   Memo2.Clear;
   Memo1.Lines.LoadFromFile(OpenDialogPLC.FileName);
// ���������� �������������
   FindSmb();
   bSaveSmblTbl.Enabled:=False;
 end;
   bCyrToLat.Enabled:=priCyrSmb;
   bTranslit.Enabled:=priCyrSmb;
   lbl1.Enabled:=priCyrSmb;
end;

// ����� � ���������� ����� �� ������� ��������
procedure FindSmb();
var
  i, k: Integer;
  s: string;
begin
 with fFixCyrSmb do
 begin
 CntStr:=Memo1.Lines.Count;
 priCyrSmb:=False;
 for i:=0 to Memo1.Lines.Count-1 do
  begin
    s:=Memo1.Lines[i];
    if (Pos('","', s)<>0) then
    begin
      // ���������� ��� ����������
      k:=Pos('","', s);
      SmbTbl[i].p1:=copy(s,1,k);
      SmbTbl[i].p2:=copy(s,k+1,Length(s));
//      if FindCyrSmb(SmbTbl[i].p1) then Memo2.Lines.Add(SmbTbl[i].p1+SmbTbl[i].p2);
      if not priCyrSmb then priCyrSmb:=FindCyrSmb(SmbTbl[i].p1);
    end;
  end;

  if not priCyrSmb then
   MessageDlg('� ������ ���������� ���������� �������� �� ����������', mtInformation, [mbOk], 0)
  else
   MessageDlg('� ������ ���������� ���������� �������� ����������.'#13#10'���������� ���������.', mtWarning, [mbOk], 0);

 end;

end;

// ����������������� ������������ ������� � ��������� �������
function SmbTranslit(s: string): string;
var
  MyTxt: string;
  i,j: Integer;
  priCyr:Boolean;
begin
  priCyr:=False;
  MyTxt:=s;
  for i := Length(MyTxt) downto 1 do
    for j := 1 to 33 do begin
      if MyTxt[i]=TranslCyr[j] then begin
        if not priCyr then fFixCyrSmb.mmoLog.Lines.Add('���������� ������ � '+MyTxt+':');
        priCyr:=True;
        MyTxt:=copy(MyTxt,1,i-1)+TranslLat[j]+copy(MyTxt,i+1,Length(MyTxt)-i);
        fFixCyrSmb.mmoLog.Lines.Add('- Cyr('+TranslCyr[j]+') => Lat('+TranslLat[j]+')');
      end
      else if MyTxt[i]=AnsiUpperCase(TranslCyr[j]) then begin
        if not priCyr then fFixCyrSmb.mmoLog.Lines.Add('���������� ������ � '+MyTxt+':');
        priCyr:=True;
        MyTxt:=copy(MyTxt,1,i-1)+AnsiUpperCase(TranslLat[j])+copy(MyTxt,i+1,Length(MyTxt)-i);
        fFixCyrSmb.mmoLog.Lines.Add('- Cyr('+AnsiUpperCase(TranslCyr[j])+') => Lat('+AnsiUpperCase(TranslLat[j])+')');
      end;
    end;
  SmbTranslit:=MyTxt;
end;

// ������������ ������� ������������� � "�������" ��������� �������
//'ABCEHKMOPTXaceoxy', -- ������������e ����� ������� �������� ��� ���������e
//'ABCEHKMOPTXaceoxy'  -- ���������e ����� ������� �������� ��� ������������e
function SmbCyrToLat(s: string): string;
var
  MyTxt: string;
  i,j: Integer;
  priCyr:Boolean;
begin
  priCyr:=False;
  MyTxt:=s;
  for i := Length(MyTxt) downto 1 do
    for j := 1 to 17 do begin
      if MyTxt[i]=Cyr[j] then begin
        if not priCyr then fFixCyrSmb.mmoLog.Lines.Add('���������� ������ � '+MyTxt+':');
        priCyr:=True;
        MyTxt:=copy(MyTxt,1,i-1)+Lat[j]+copy(MyTxt,i+1,Length(MyTxt)-i);
        fFixCyrSmb.mmoLog.Lines.Add('- Cyr('+MyTxt[i]+') => Lat('+Lat[j]+')');
      end;
    end;
//  if priCyr then
//  fFixCyrSmb.mmoLog.Lines.Add(MyTxt);
  SmbCyrToLat:=MyTxt;
end;

procedure TfFixCyrSmb.bTranslitClick(Sender: TObject);
var
  i:Integer;
begin
  Memo2.Lines.Clear;
  mmoLog.Lines.Clear;
  Memo2.Visible:=False;
  fFixCyrSmb.mmoLog.Lines.Add('���������� �������������� ������������ �������� � ��������� �������.');
  for i:=0 to CntStr-1 do
  begin
//    SmbTbl[i].p1:=SmbTranslit(SmbTbl[i].p1);
    Memo2.Lines.Add(SmbTranslit(SmbTbl[i].p1)+SmbTbl[i].p2);
  end;
  Memo2.Visible:=True;
  bSaveSmblTbl.Enabled:=True;
end;

procedure TfFixCyrSmb.bCyrToLatClick(Sender: TObject);
var
  i:Integer;
begin
  Memo2.Lines.Clear;
  mmoLog.Lines.Clear;
  Memo2.Visible:=False;
  fFixCyrSmb.mmoLog.Lines.Add('���������� ������ ������������ �������� �� "�������" ��������� �������.');
  for i:=0 to CntStr-1 do
  begin
//    SmbTbl[i].p1:=SmbCyrToLat(SmbTbl[i].p1);
    Memo2.Lines.Add(SmbCyrToLat(SmbTbl[i].p1)+SmbTbl[i].p2);
  end;
  Memo2.Visible:=True;
  bSaveSmblTbl.Enabled:=True;
end;

procedure TfFixCyrSmb.bSaveSmblTblClick(Sender: TObject);
var
  s:string;
  n:Integer;
begin
  s:=OpenDialogPLC.FileName;
  n:=Pos('.sdf',LowerCase(s));
  s:=Copy(s,1,n-1);
  Memo2.Lines.SaveToFile(s+'_out.sdf');
  mmoLog.Lines.SaveToFile(s+'_out_sdf.log');
  MessageDlg('����  "'+ s+'_out.sdf" �������', mtInformation	, [mbOk], 0);
end;

end.
