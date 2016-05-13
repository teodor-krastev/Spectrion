unit FitEngU;

interface

uses ProcU;

CONST
  nptmax = 2000;
  mma = 3;

type
  glmma = ARRAY [1 .. mma] OF real;
  glnparam = glmma;
  gllista = ARRAY [1 .. mma] OF integer;
  glcovar = ARRAY [1 .. mma, 1 .. mma] OF real;
  glnalbynal = glcovar;
  glncabynca = glcovar;
  glndata = ARRAY [1 .. nptmax] OF real;

  tFuncs = PROCEDURE(x: real; a: glnparam; VAR y: real; VAR dyda: glnparam;
    na: integer);
  tNextInOut = procedure(var xa: glmma; nx: integer; var Msr: double;
    var StopFlag: boolean) of object;

VAR
  funcs: tFuncs;
  NextInOut: tNextInOut;
PROCEDURE mrqmin(x, y, sig: glndata; ndata: integer; VAR a: glmma; mma: integer;
  lista: gllista; mfit: integer; VAR covar, alpha: glncabynca; nca: integer;
  VAR chisq, alamda: real);

procedure Delay(DTime: LongInt); { delay DTime miliseconds }
procedure findsimplex(CDs: array of tCDScan; nCD: integer; var NewPos: glmma);
procedure SimplexNR(CDs: array of tCDScan; nCD: integer; var NewPos: glmma);

implementation

uses Dialogs, Windows, Forms, AutotuneU, AboutU;

type
  glnpbynp = glcovar;
  glnpbymp = glcovar;
  glnp = ARRAY [1 .. nptmax] OF integer; // was "np"

var
  glochisq: real;
  glbeta: glmma;

LABEL 1;
{ ModFile
  TYPE double = real; char12 = string[12];
  FUNCTION sngl(x:real):real; BEGIN sngl := x END;
  PROCEDURE glopen(VAR infile:text; filename:char12);
  BEGIN assign(infile,filename); reset(infile) END; }

PROCEDURE covsrt(VAR covar: glcovar; ncvm: integer; ma: integer; lista: gllista;
  mfit: integer);
(* Programs using routine COVSRT must define the types
  TYPE
  glcovar = ARRAY [1..ncvm,1..ncvm] OF real;
  gllista = ARRAY [1..mfit] OF integer;
  in the calling program. *)
VAR
  j, i: integer;
  swap: real;
BEGIN
  FOR j := 1 TO ma - 1 DO
  BEGIN
    FOR i := j + 1 TO ma DO
    BEGIN
      covar[i, j] := 0.0
    END
  END;
  FOR i := 1 TO mfit - 1 DO
  BEGIN
    FOR j := i + 1 TO mfit DO
    BEGIN
      IF (lista[j] > lista[i]) THEN
      BEGIN
        covar[lista[j], lista[i]] := covar[i, j]
      END
      ELSE
      BEGIN
        covar[lista[i], lista[j]] := covar[i, j]
      END
    END
  END;
  swap := covar[1, 1];
  FOR j := 1 TO ma DO
  BEGIN
    covar[1, j] := covar[j, j];
    covar[j, j] := 0.0
  END;
  covar[lista[1], lista[1]] := swap;
  FOR j := 2 TO mfit DO
  BEGIN
    covar[lista[j], lista[j]] := covar[1, j]
  END;
  FOR j := 2 TO ma DO
  BEGIN
    FOR i := 1 TO j - 1 DO
    BEGIN
      covar[i, j] := covar[j, i]
    END
  END
END; { covsrt }

PROCEDURE gaussj(VAR a: glnpbynp; n, np: integer; VAR b: glnpbymp;
  m, mp: integer);
(* Programs using GAUSSJ must define the types
  TYPE
  glnpbynp = ARRAY [1..np,1..np] OF real;
  glnpbymp = ARRAY [1..np,1..mp] OF real;
  glnp = ARRAY [1..np] OF integer;
  in the main routine. *)
VAR
  big, dum, pivinv: real;
  i, icol, irow, j, k, l, ll: integer;
  indxc, indxr, ipiv: glnp;
BEGIN
  FOR j := 1 TO n DO
  BEGIN
    ipiv[j] := 0
  END;
  FOR i := 1 TO n DO
  BEGIN
    big := 0.0;
    FOR j := 1 TO n DO
    BEGIN
      IF (ipiv[j] <> 1) THEN
      BEGIN
        FOR k := 1 TO n DO
        BEGIN
          IF (ipiv[k] = 0) THEN
          BEGIN
            IF (abs(a[j, k]) >= big) THEN
            BEGIN
              big := abs(a[j, k]);
              irow := j;
              icol := k
            END
          END
          ELSE IF (ipiv[k] > 1) THEN
          BEGIN
            ErrorMsg('pause 1 in GAUSSJ - singular matrix');
            exit;
          END
        END
      END
    END;
    ipiv[icol] := ipiv[icol] + 1;
    IF (irow <> icol) THEN
    BEGIN
      FOR l := 1 TO n DO
      BEGIN
        dum := a[irow, l];
        a[irow, l] := a[icol, l];
        a[icol, l] := dum
      END;
      FOR l := 1 TO m DO
      BEGIN
        dum := b[irow, l];
        b[irow, l] := b[icol, l];
        b[icol, l] := dum
      END
    END;
    indxr[i] := irow;
    indxc[i] := icol;
    IF (a[icol, icol] = 0.0) THEN
    BEGIN
      ErrorMsg('pause 2 in GAUSSJ - singular matrix');
      exit;
    END;
    pivinv := 1.0 / a[icol, icol];
    a[icol, icol] := 1.0;
    FOR l := 1 TO n DO
    BEGIN
      a[icol, l] := a[icol, l] * pivinv
    END;
    FOR l := 1 TO m DO
    BEGIN
      b[icol, l] := b[icol, l] * pivinv
    END;
    FOR ll := 1 TO n DO
    BEGIN
      IF (ll <> icol) THEN
      BEGIN
        dum := a[ll, icol];
        a[ll, icol] := 0.0;
        FOR l := 1 TO n DO
        BEGIN
          a[ll, l] := a[ll, l] - a[icol, l] * dum
        END;
        FOR l := 1 TO m DO
        BEGIN
          b[ll, l] := b[ll, l] - b[icol, l] * dum
        END
      END
    END
  END;
  FOR l := n DOWNTO 1 DO
  BEGIN
    IF (indxr[l] <> indxc[l]) THEN
    BEGIN
      FOR k := 1 TO n DO
      BEGIN
        dum := a[k, indxr[l]];
        a[k, indxr[l]] := a[k, indxc[l]];
        a[k, indxc[l]] := dum
      END
    END
  END
END; { gaussj }

PROCEDURE mrqcof(x, y, sig: glndata; ndata: integer; VAR a: glmma; mma: integer;
  lista: gllista; mfit: integer; VAR alpha: glnalbynal; VAR beta: glmma;
  nalp: integer; VAR chisq: real);
(* Programs using routine MRQMIN must provide a
  PROCEDURE funcs(xx:real; a:glmma; yfit:real; dyda:glmma; mma:integer);
  that evaluates the fitting function yfit and its derivatives dyda
  with respect to the parameters a at point xx.  Also they
  must define the types
  TYPE
  glndata = ARRAY [1..ndata] OF real;
  glmma = ARRAY [1..mma] OF real;
  gllista = ARRAY [1..mma] OF integer;
  glnalbynal = ARRAY [1..nalp,1..nalp] OF real;
  in the main routine *)
VAR
  k, j, i: integer;
  ymod, wt, sig2i, dy: real;
  dyda: glmma;
BEGIN
  FOR j := 1 TO mfit DO
  BEGIN
    FOR k := 1 TO j DO
    BEGIN
      alpha[j, k] := 0.0
    END;
    beta[j] := 0.0
  END;
  chisq := 0.0;
  FOR i := 1 TO ndata DO
  BEGIN
    funcs(x[i], a, ymod, dyda, mma);
    sig2i := 1.0 / (sig[i] * sig[i]);
    dy := y[i] - ymod;
    FOR j := 1 TO mfit DO
    BEGIN
      wt := dyda[lista[j]] * sig2i;
      FOR k := 1 TO j DO
      BEGIN
        alpha[j, k] := alpha[j, k] + wt * dyda[lista[k]]
      END;
      beta[j] := beta[j] + dy * wt
    END;
    chisq := chisq + dy * dy * sig2i
  END;
  FOR j := 2 TO mfit DO
  BEGIN
    FOR k := 1 TO j - 1 DO
    BEGIN
      alpha[k, j] := alpha[j, k]
    END
  END
END; { mrqcof }

PROCEDURE mrqmin(x, y, sig: glndata; ndata: integer; VAR a: glmma; mma: integer;
  lista: gllista; mfit: integer; VAR covar, alpha: glncabynca; nca: integer;
  VAR chisq, alamda: real);
(* Programs using routine MRQMIN must define the types
  TYPE
  glndata = ARRAY [1..ndata] OF real;
  glmma = ARRAY [1..mma] OF real;
  gllista = ARRAY [1..mma] OF integer;
  glncabynca = ARRAY [1..nca,1..nca] OF real;
  and the variables
  VAR
  glochisq: real;
  glbeta: glmma;
  in the main routine. Also note that this routine calls MRQCOF, which
  requires a user-defined procedure FUNCS, described in that routine. *)
LABEL 99;
VAR
  k, kk, j, ihit: integer;
  atry, da: glmma;
  oneda: glncabynca;
BEGIN
  IF (alamda < 0.0) THEN
  BEGIN
    kk := mfit + 1;
    FOR j := 1 TO mma DO
    BEGIN
      ihit := 0;
      FOR k := 1 TO mfit DO
      BEGIN
        IF (lista[k] = j) THEN
          ihit := ihit + 1
      END;
      IF (ihit = 0) THEN
      BEGIN
        lista[kk] := j;
        kk := kk + 1
      END
      ELSE IF (ihit > 1) THEN
      BEGIN
        ErrorMsg('pause 1 in routine MRQMIN' + #10 +
          'Improper permutation in LISTA');
      END
    END;
    IF (kk <> (mma + 1)) THEN
    BEGIN
      ErrorMsg('pause 2 in routine MRQMIN' + #10 +
        'Improper permutation in LISTA');
    END;
    alamda := 0.001;
    mrqcof(x, y, sig, ndata, a, mma, lista, mfit, alpha, glbeta, nca, chisq);
    glochisq := chisq;
    FOR j := 1 TO mma DO
    BEGIN
      atry[j] := a[j]
    END
  END;
  FOR j := 1 TO mfit DO
  BEGIN
    FOR k := 1 TO mfit DO
    BEGIN
      covar[j, k] := alpha[j, k]
    END;
    covar[j, j] := alpha[j, j] * (1.0 + alamda);
    oneda[j, 1] := glbeta[j]
  END;
  gaussj(covar, mfit, nca, oneda, 1, 1);
  FOR j := 1 TO mfit DO
    da[j] := oneda[j, 1];
  IF (alamda = 0.0) THEN
  BEGIN
    covsrt(covar, nca, mma, lista, mfit);
    exit;
  END;
  FOR j := 1 TO mfit DO
  BEGIN
    atry[lista[j]] := a[lista[j]] + da[j]
  END;
  mrqcof(x, y, sig, ndata, atry, mma, lista, mfit, covar, da, nca, chisq);
  IF (chisq < glochisq) THEN
  BEGIN
    alamda := 0.1 * alamda;
    glochisq := chisq;
    FOR j := 1 TO mfit DO
    BEGIN
      FOR k := 1 TO mfit DO
      BEGIN
        alpha[j, k] := covar[j, k]
      END;
      glbeta[j] := da[j];
      a[lista[j]] := atry[lista[j]]
    END
  END
  ELSE
  BEGIN
    alamda := 10.0 * alamda;
    chisq := glochisq
  END;
END; { mrqmin }

procedure Delay(DTime: LongInt); { delay DTime miliseconds }
var
  l: LongInt;
begin
  l := GetTickCount;
  While (abs(l - GetTickCount) < DTime) do
    Application.ProcessMessages;
end; { Delay }
/// //////////////////////////////////////////////////////////////////

{ procedure Find_pk;
  var
  i,j,k,l,m,maxpos,MenuPos,xpos:integer;
  maxmag,np,a:real; MaxLam:array [MotorNumb] of real;
  Lam,Toler:array [1..3] of real; MenuItem: ArrayStr;
  ch:char; b:boolean; }

procedure findsimplex(CDs: array of tCDScan; nCD: integer; var NewPos: glmma);
const
  n = 3;
var
  xa, fc, fh, fl, fg, fe, fr, fo, al, be, ga, e: double;
  x, xh, xg, xl, xo, xr, xc, xe, xi, xy, xlast, xmin, xmax, k: glmma;
  f: array [1 .. n + 1] of double;
  s: array [1 .. n + 1, 1 .. n] of double;
  i, j, l, g, GenI, tev, h, per: integer;
  ch: char;
  StopFlag: boolean;

  function sig: boolean;
  var
    sg, s1, s2: real;
    i: integer;
  begin
    s1 := 0;
    s2 := 0;
    for i := 1 to nCD + 1 do
    begin
      s1 := s1 + f[i];
      s2 := s2 + f[i] * f[i];
    end;
    sg := s2 - s1 * s1 / (nCD + 1);
    sg := sg / (nCD + 1);
    sig := sg < 10;
  end;

  procedure findxefe;
  var
    j: integer;
  begin
    for j := 1 to nCD do
    begin
      xe[j] := ga * xr[j] + (1 - ga) * xo[j];
      x[j] := xe[j];
    end;
    NextInOut(x, nCD, fe, StopFlag);
  end;

  procedure subxh_xr;
  var
    j: integer;
  begin
    for j := 1 to nCD do
      xh[j] := xr[j];
    f[h] := fr;
  end;

  procedure xh_xr;
  var
    j: integer;
  begin
    for j := 1 to nCD do
      s[h, j] := xr[j];
    f[h] := fr;
  end;

  procedure findxcfc;
  var
    j: integer;
  begin
    for j := 1 to nCD do
    begin
      xc[j] := be * xh[j] + (1 - be) * xo[j];
      x[j] := xc[j];
    end;
    NextInOut(x, nCD, fc, StopFlag);
  end;

  procedure xh_xc;
  var
    j: integer;
  begin
    for j := 1 to nCD do
      s[h, j] := xc[j];
    f[h] := fc;
  end;

  procedure xh_xe;
  var
    j: integer;
  begin
    for j := 1 to nCD do
      s[h, j] := xe[j];
    f[h] := fe;
  end;

  procedure subxi;
  var
    i, j: integer;
  begin
    for i := 1 to nCD + 1 do
    begin
      for j := 1 to nCD do
      begin
        s[i, j] := (s[i, j] + xl[j]) / 2;
        x[j] := s[i, j];
      end;
      NextInOut(x, nCD, f[i], StopFlag);
    end;
  end;

begin
  StopFlag := false; { main find simplex }
  for i := 1 to nCD do
  begin
    s[1, i] := CDs[i].Start;
    k[i] := (CDs[1].Finish - CDs[1].Start) / 10;
  end;
  tev := 0;
  al := 1;
  be := 0.5;
  ga := 2;
  for i := 2 to nCD + 1 do
    for j := 1 to nCD do
      if j = i - 1 then
        s[i, j] := s[1, j] + k[j]
      else
        s[i, j] := s[1, j];
  for i := 1 to nCD + 1 do
  begin
    for j := 1 to nCD do
      x[j] := s[i, j];
    NextInOut(x, nCD, f[i], StopFlag);
  end;

  repeat
    { find xl,xg,xh,fl,fg,fh }
    fh := -1E20;
    fl := 1E20;
    for i := 1 to nCD + 1 do
    begin
      if f[i] > fh then
      begin
        fh := f[i];
        h := i;
      end;
      if f[i] < fl then
      begin
        fl := f[i];
        l := i;
      end;
    end;
    fg := -1E20;
    for i := 1 to nCD + 1 do
      if (f[i] > fg) and not(i = h) then
      begin
        fg := f[i];
        g := i;
      end;
    { find xo,fo }
    for j := 1 to nCD do
    begin
      xo[j] := 0;
      for i := 1 to nCD + 1 do
        if not(i = h) then
          xo[j] := xo[j] + s[i, j];
      xo[j] := xo[j] / nCD;
      xh[j] := s[h, j];
      xg[j] := s[g, j];
      xl[j] := s[l, j];
    end;
    for j := 1 to nCD do
      x[j] := xo[j];
    NextInOut(x, nCD, fo, StopFlag);
    { find xr,fr }
    for j := 1 to nCD do
    begin
      xr[j] := xo[j] + al * (xo[j] - xh[j]);
      x[j] := xr[j];
    end;
    NextInOut(x, nCD, fr, StopFlag);

    if fr < fl then
    begin
      findxefe;
      if fe < fl then
        xh_xe
      else
        xh_xr;
    end
    else if fr > fg then
    begin
      if fr > fh then
      begin
        findxcfc;
        if fc > fh then
          subxi
        else
          xh_xc;
      end
      else
      begin
        subxh_xr;
        findxcfc;
        if fc > fh then
          subxi
        else
          xh_xc;
      end;
    end
    else
      xh_xr;
  until (sig) or StopFlag;
  for i := 1 to nCD do
    NewPos[i] := xl[i];
end; { findsimplex }

procedure SimplexNR(CDs: array of tCDScan; nCD: integer; var NewPos: glmma);
const
  np = 3;
  mp = 4;
TYPE
  glmpnp = ARRAY [1 .. mp, 1 .. np] OF double;
  glmp = ARRAY [1 .. mp] OF double;
  glnp = ARRAY [1 .. np] OF double;
var
  StopFlag: boolean;
  p: glmpnp;
  y: glmp;
  k: glnp;
  x: glmma;
  i, j, iter: integer;

  function Compare(a: double; oper: string; b: double): boolean;
  begin
    if oper = '>' then
      Result := (a > b) and ((a - b) > SIE);
    if oper = '<' then
      Result := (a < b) and ((b - a) > SIE);
    if oper = '>=' then
      Result := (a > b) and ((a - b) > SIE);
    if oper = '<=' then
      Result := (a < b) and ((b - a) > SIE);
    if oper = '=' then
      Result := abs(a - b) < SIE;
  end;

  PROCEDURE amoeba(VAR p: glmpnp; VAR y: glmp; ndim: integer; ftol: double;
    VAR iter: integer);
  LABEL 99;
  CONST
    alpha = 1.0;
    beta = 0.5;
    gamma = 2.0;
    itmax = 500;
  VAR
    mpts, j, inhi, ilo, ihi, i: integer;
    yprr, ypr, rtol: double;
    pr, prr, pbar: glmma;
  BEGIN
    mpts := ndim + 1;
    StopFlag := false;
    iter := 0;
    WHILE not StopFlag DO
    BEGIN
      ilo := 1;
      IF (y[1] > y[2]) THEN
      BEGIN
        ihi := 1;
        inhi := 2
      END
      ELSE
      BEGIN
        ihi := 2;
        inhi := 1
      END;
      FOR i := 1 TO mpts DO
      BEGIN
        IF (y[i] < y[ilo]) THEN
          ilo := i;
        IF (y[i] > y[ihi]) THEN
        BEGIN
          inhi := ihi;
          ihi := i;
        END
        ELSE IF (y[i] > y[inhi]) THEN
          IF (i <> ihi) THEN
            inhi := i
      END;
      rtol := 2.0 * abs(y[ihi] - y[ilo]) / (abs(y[ihi]) + abs(y[ilo]));
      IF (rtol < ftol) THEN
        GOTO 99;
      IF (iter = itmax) THEN
      BEGIN
        ErrorMsg('Stop simplex - too many iterations');
        StopFlag := true;
      END;
      iter := iter + 1;
      FOR j := 1 TO ndim DO
        pbar[j] := 0.0;
      FOR i := 1 TO mpts DO
        IF (i <> ihi) THEN
          FOR j := 1 TO ndim DO
            pbar[j] := pbar[j] + p[i, j];
      FOR j := 1 TO ndim DO
      BEGIN
        pbar[j] := pbar[j] / ndim;
        pr[j] := (1.0 + alpha) * pbar[j] - alpha * p[ihi, j];
      END;
      // ypr := func(pr);
      NextInOut(pr, nCD, ypr, StopFlag);
      IF (ypr <= y[ilo]) THEN
      BEGIN
        FOR j := 1 TO ndim DO
          prr[j] := gamma * pr[j] + (1.0 - gamma) * pbar[j];
        // yprr := func(prr);
        NextInOut(prr, nCD, yprr, StopFlag);
        IF (yprr < y[ilo]) THEN
        BEGIN
          FOR j := 1 TO ndim DO
            p[ihi, j] := prr[j];
          y[ihi] := yprr;
        END
        ELSE
        BEGIN
          FOR j := 1 TO ndim DO
            p[ihi, j] := pr[j];
          y[ihi] := ypr;
        END
      END
      ELSE IF (ypr >= y[inhi]) THEN
      BEGIN
        IF (ypr < y[ihi]) THEN
        BEGIN
          FOR j := 1 TO ndim DO
            p[ihi, j] := pr[j];
          y[ihi] := ypr
        END;
        FOR j := 1 TO ndim DO
          prr[j] := beta * p[ihi, j] + (1.0 - beta) * pbar[j];
        // yprr := func(prr);
        NextInOut(prr, nCD, yprr, StopFlag);
        IF (yprr < y[ihi]) THEN
        BEGIN
          FOR j := 1 TO ndim DO
            p[ihi, j] := prr[j];
          y[ihi] := yprr;
        END
        ELSE
        BEGIN
          FOR i := 1 TO mpts DO
            IF (i <> ilo) THEN
            BEGIN
              FOR j := 1 TO ndim DO
              BEGIN
                pr[j] := 0.5 * (p[i, j] + p[ilo, j]);
                p[i, j] := pr[j];
              END;
              // y[i] := func(pr)
              NextInOut(pr, nCD, y[i], StopFlag);
            END
        END
      END
      ELSE
      BEGIN
        FOR j := 1 TO ndim DO
          p[ihi, j] := pr[j];
        y[ihi] := ypr
      END
    END;
  99:
  END; { amoeba }

begin { SimplexNR }
  for i := 1 to nCD do
  begin
    k[i] := 2 * (CDs[i].Finish - CDs[i].Start) / 3;
    p[1, i] := CDs[i].Start + k[i] / 2;
  end;
  for i := 2 to nCD + 1 do
    for j := 1 to nCD do
      if j = i - 1 then
        p[i, j] := p[1, j] + k[j]
      else
        p[i, j] := p[1, j];
  for i := 1 to nCD + 1 do
  begin
    for j := 1 to nCD do
      x[j] := p[i, j];
    NextInOut(x, nCD, y[i], StopFlag);
  end;
  amoeba(p, y, nCD, SIER * CDs[1].Step, iter);
  // for i:=1 to nCD do NewPos[i]:= xl[i];
end; { SimplexNR }

end.
