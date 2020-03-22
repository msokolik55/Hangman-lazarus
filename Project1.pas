program Project1;
uses crt;

var f_slova: text;
    poleRiadky: array [1..50] of string;
    i, pocetRiadkov, pocetChyb: integer;
    riadok, hladaneSlovo, zadaneSlovo: string;
    ch: char;
    jeVyskyt: boolean;

procedure vypisZadanehoSlova(slovo: string);
var i: integer;
begin
  gotoxy(35, 13);
  for i := 1 to length(slovo) do
    if(slovo[i] = ' ') then write('- ')
    else write(slovo[i], ' ');
  writeln();
end;

procedure vypisChyb(pocet: integer);
begin
  gotoxy(1, 1);
  writeln('Pocet chyb: ', pocet);
end;
       
procedure inicializaciaHry();
begin
  hladaneSlovo := poleRiadky[random(pocetRiadkov) + 1];

  zadaneSlovo := '';
  for i := 1 to length(hladaneSlovo) do
  begin
    if(hladaneSlovo[i] = ' ') then zadaneSlovo := zadaneSlovo + ' '
    else zadaneSlovo := zadaneSlovo + '_';
  end;

  pocetChyb := 0;
  vypisZadanehoSlova(zadaneSlovo);
  vypisChyb(pocetChyb);
end;

function vlozZnak(slovo: string; ch: char; poz: integer): string;
begin
  vlozZnak := copy(slovo, 1, poz - 1) + ch +
    copy(slovo, poz + 1, length(slovo) - poz);
end;

begin
  randomize;
  assign(f_slova, 'slova.txt');

  // uloha 1
  reset(f_slova);

  pocetRiadkov := 0;
  while not EOF(f_slova) do
  begin       
    pocetRiadkov := pocetRiadkov + 1;

    readln(f_slova, riadok);
    poleRiadky[pocetRiadkov] := riadok;
  end;

  inicializaciaHry();

  // game loop
  repeat
    ch := readkey;

    if(ch >= 'a') and (ch <= 'z') then
    begin
      jeVyskyt := False;
      for i := 1 to length(hladaneSlovo) do
        if(hladaneSlovo[i] = ch) then
        begin
          zadaneSlovo := vlozZnak(zadaneSlovo, ch, i);
          jeVyskyt := True;
        end;

      if(jeVyskyt = False) then pocetChyb := pocetChyb + 1;

      vypisZadanehoSlova(zadaneSlovo);
      vypisChyb(pocetChyb);
    end;

  until (zadaneSlovo = hladaneSlovo) or (pocetChyb = 9);

  writeln();
  writeln();
  if(pocetChyb = 9) then writeln('Prehral si :(, zadane slovo bolo: ', hladaneSlovo)
  else writeln('Uhadol si :)');

  readln();
end.

