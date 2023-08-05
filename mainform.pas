unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, BitGridEngine;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  Grid1 : TBitGrid;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Grid1.Init(10,10);
  Form1.Memo1.Append('10x10 grid created');
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  x,y : integer;
  s : string;
begin
  if Checkbox1.Checked then
    Grid1.Cells[3,7].input := $0f
  else
    Grid1.Cells[3,7].input := 00;

  memo1.Append('Program Dump: ');
  for y := 0 to Grid1.Height-1 do
  begin
    s := IntToStr(Y)+': ';
    for x := 0 to Grid1.Width-1 do
      s := s + IntToHex(Grid1.Cells[x,y].lookup,16) + ' ';
    memo1.Append(s);
  end;

  memo1.Append('inputs: ');
  for y := 0 to Grid1.Height-1 do
  begin
    s := '  ' + IntToStr(Y)+': ';
    for x := 0 to Grid1.Width-1 do
      s := s + IntToHex(Grid1.Cells[x,y].input,1) + ' ';
    memo1.Append(s);
  end;

  memo1.Append('outputs: ');
  for y := 0 to Grid1.Height-1 do
  begin
    s := '  ' + IntToStr(Y)+': ';
    for x := 0 to Grid1.Width-1 do
      s := s + IntToHex(Grid1.Cells[x,y].output,1) + ' ';
    memo1.Append(s);
  end;

  memo1.Append('Allbits = '+IntToHex(AllBits,16));
  memo1.Append(' '+IntToStr(Grid1.CycleCount) + ' cycles executed');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if Checkbox1.Checked then
    Grid1.Cells[3,7].input := $0f
  else
    Grid1.Cells[3,7].input := 00;

  Grid1.DoClock;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  x,y : integer;
begin
  for y := 0 to Grid1.Height-1 do
    for x := 0 to Grid1.Width-1 do
      Grid1.Cells[x,y].lookup :=  Passthrough;

  Grid1.Cells[Grid1.Width-1,0].lookup:= $0000000088888888;
  For x := 0 to Grid1.Width-2 do
    Grid1.Cells[x,0].lookup := $FF08FF0877807780;

  For x := 0 to Grid1.Width-1 do
    Grid1.Cells[x,Grid1.Height-1].lookup := $4444000044440000;  // reflect down, otherwise 0

end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Grid1.Done;
  Form1.Memo1.Append('grid done');
end;

begin

end.

