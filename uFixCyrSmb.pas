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
// Поиск кирилических символов в названиях переменных
    function FindCyrSmb(s: string): boolean;
// Поиск и разделение строк из таблицы символов
    procedure FindSmb();
// Кирилические символы преобразовать в "похожие" латинские символы
//'ABCEHKMOPTXaceoxy', -- кириллическиe буквы которые выглядят как английскиe
//'ABCEHKMOPTXaceoxy'  -- английскиe буквы которые выглядят как кириллическиe
    function SmbCyrToLat(s: string): string;
// Транслитирировать кирилические символы в латинские символы
    function SmbTranslit(s: string): string;

const
  Cyr: array [1..17] of Char=('А','В','С','Е','Н','К','М','О','Р','Т','Х','а','с','е','о','х','у');
  Lat: array [1..17] of Char=('A','B','C','E','H','K','M','O','P','T','X','a','c','e','o','x','y');

  TranslCyr: array [1..33] of Char=('а','б','в','г','д','е','ё','ж','з','и','й','к',
  'л','м','н','о','п','р','с','т','у','ф','х','ц','ч','ш','щ','ь','ы','ъ','э','ю','я');
  TranslLat: array [1..33] of String=('a','b','v','g','d','e','jo','zh','z','i','j','k',
  'l','m','n','o','p','r','s','t','u','f','kh','c','ch','sh','shh','','y','','eh','yu','ya');

var
  fFixCyrSmb: TfFixCyrSmb;
  SmbTbl: array[0..10000] of SmbTblRec;
  CntStr: Integer;
  priCyrSmb: Boolean=False; // В имени хотя бы одной переменной присутствуют кирилические символы
implementation

{$R *.dfm}
// Поиск кирилических символов в названиях переменных
function FindCyrSmb(s: string): boolean;
var
  i:Integer;
begin
  for i := 1 to Length(s) do
  if s[i] in ['А'..'я', 'ё', 'Ё'] then
  begin
//    MessageDlg('Как минимум в имени одной переменной ("'+ s+'") содержатся кирилические символы.'#13#10'Во избежание дальнейших ошибок рекомендуется исправить имена переменных.'#13#10'Это возможно сделать, к примеру,внешней утилитой <ИМЯ_ПРОГРАММЫ>', mtError, [mbOk], 0);
    FindCyrSmb:=True;
    Exit;
  end;
  FindCyrSmb:=False;
end;

procedure TfFixCyrSmb.bOpenPLCClick(Sender: TObject);
begin
// Загружаем содержимое файла в Memo1
 if OpenDialogPLC.Execute then
 begin
   Memo1.Clear;
   Memo2.Clear;
   Memo1.Lines.LoadFromFile(OpenDialogPLC.FileName);
// Производим инициализацию
   FindSmb();
   bSaveSmblTbl.Enabled:=False;
 end;
   bCyrToLat.Enabled:=priCyrSmb;
   bTranslit.Enabled:=priCyrSmb;
   lbl1.Enabled:=priCyrSmb;
end;

// Поиск и разделение строк из таблицы символов
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
      // Определяем имя переменной
      k:=Pos('","', s);
      SmbTbl[i].p1:=copy(s,1,k);
      SmbTbl[i].p2:=copy(s,k+1,Length(s));
//      if FindCyrSmb(SmbTbl[i].p1) then Memo2.Lines.Add(SmbTbl[i].p1+SmbTbl[i].p2);
      if not priCyrSmb then priCyrSmb:=FindCyrSmb(SmbTbl[i].p1);
    end;
  end;

  if not priCyrSmb then
   MessageDlg('В именах символьных переменных кирилица не обнаружена', mtInformation, [mbOk], 0)
  else
   MessageDlg('В именах символьных переменных кирилица обнаружена.'#13#10'Необходима обработка.', mtWarning, [mbOk], 0);

 end;

end;

// Транслитирировать кирилические символы в латинские символы
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
        if not priCyr then fFixCyrSmb.mmoLog.Lines.Add('Производим замену в '+MyTxt+':');
        priCyr:=True;
        MyTxt:=copy(MyTxt,1,i-1)+TranslLat[j]+copy(MyTxt,i+1,Length(MyTxt)-i);
        fFixCyrSmb.mmoLog.Lines.Add('- Cyr('+TranslCyr[j]+') => Lat('+TranslLat[j]+')');
      end
      else if MyTxt[i]=AnsiUpperCase(TranslCyr[j]) then begin
        if not priCyr then fFixCyrSmb.mmoLog.Lines.Add('Производим замену в '+MyTxt+':');
        priCyr:=True;
        MyTxt:=copy(MyTxt,1,i-1)+AnsiUpperCase(TranslLat[j])+copy(MyTxt,i+1,Length(MyTxt)-i);
        fFixCyrSmb.mmoLog.Lines.Add('- Cyr('+AnsiUpperCase(TranslCyr[j])+') => Lat('+AnsiUpperCase(TranslLat[j])+')');
      end;
    end;
  SmbTranslit:=MyTxt;
end;

// Кирилические символы преобразовать в "похожие" латинские символы
//'ABCEHKMOPTXaceoxy', -- кириллическиe буквы которые выглядят как английскиe
//'ABCEHKMOPTXaceoxy'  -- английскиe буквы которые выглядят как кириллическиe
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
        if not priCyr then fFixCyrSmb.mmoLog.Lines.Add('Производим замену в '+MyTxt+':');
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
  fFixCyrSmb.mmoLog.Lines.Add('Производим транслитирацию кирилических символов в латинские символы.');
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
  fFixCyrSmb.mmoLog.Lines.Add('Производим замену кирилических символов на "похожие" латинские символы.');
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
  MessageDlg('Файл  "'+ s+'_out.sdf" сохранён', mtInformation	, [mbOk], 0);
end;

end.
