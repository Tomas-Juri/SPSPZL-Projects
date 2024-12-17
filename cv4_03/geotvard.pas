unit GeoTvarD;

interface

type tucGeoTvar =^cGeoTvar;
     cGeoTvar = OBJECT
                  public
                    constructor init;
                    function urciObvod :real;  VIRTUAL;
                    destructor done; viRTUAL;
                end;

implementation

uses crt;

const _infoy : byte = 19;

procedure ChybaInfo(Info :string);
var xold, yold :byte;
begin
  xold :=WhereX;
  yold :=WhereY;
  inc(_infoy);
  GotoXY(1, _infoy);
  Write(info);
  GotoXY(xold, yold)
end;

function cGeoTvar.urciObvod :real;
begin
  urciObvod :=0;
  ChybaInfo('Ja jsem abstraktni metoda cGeoTvar.urciObvod');
end;

constructor cGeoTvar.init;
begin
  ChybaInfo('Ja jsem abstraktni metoda cGeoTvar.init')
end;

destructor cGeoTvar.done;
begin
  ChybaInfo('Ja jsem abstraktni metoda cGeoTvar.done')
end;

begin
  ClrScr;
  GotoXY(1, _infoy);
  TextColor(Yellow);
  Write('Chybova hlaseni: ');
  TextColor(White);
  GotoXY(1, 1)
end.

