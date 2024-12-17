unit PlochaD;

interface

uses GeoTvarD,LinearniSeznam;

const MAX = 10;

type tPole = array [1..MAX] of tucGeoTvar;
     tucplocha = ^Cplocha;
     cPlocha = OBJECT
               private
                 pocet :word;
                 utvary :Tseznam;
               public
                 constructor init;
                 procedure pridej(utvar :tucGeoTvar);
                 function urciObvody :real;
                 destructor done;
             end;

implementation

constructor cPlocha.init;
begin
  utvary.InitS();
end;

procedure cPlocha.pridej(utvar :tucGeoTvar);
begin
  inc(pocet);
  utvary.AddS(utvar);
end;

function cPlocha.urciObvody :real;
var o :real;
    i :word;
begin
  o :=0;
  for i :=1 to pocet do
    begin
     o :=o + utvary.CopyS^.urciObvod;
     utvary.SuccS();
    end;
  urciObvody :=o
end;

destructor cPlocha.done;
var i :1..MAX;
begin
  utvary.SetFirst();
  for i :=1 to pocet do
    begin
     dispose(utvary.CopyS());
     utvary.DeleteS();
    end;
  pocet :=0
end;

end.

