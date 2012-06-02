pro lident1,fileid=fileid,filesp=filesp,extend=extend,$
	   ewlim=ewlim,charid=charid,wstart=wstart,wend=wend,$
	   iprint=iprint,_extra=e
;
if not keyword_set(fileid) and not keyword_set(filesp) then begin
  print,'LIDENT'
  print,'keyword parameters: '
  print,'fileid  - filename of the identification table'
  print,'          (unit 12 output from Synspec)'
  print,'filesp  - filename of the synthetic spectrum'
  print,'extend  - if set, the annotated lines have are drown'
  print,'          all the way down to the spectrum'
  print,'ewlim   - limiting approx.equivalent width for annotations'
  print,'charid  - character size for annotation (default=1)
  print,'wstart  - starting wavelength for annotations'
  print,'wend    - ending wavelength for annotations'
  print,'and all keywords acceptable by IDL routine PLOT
  return
endif
;
if keyword_set(iprint) then begin
	set_plot,'ps'
;	device,/land
;	device,/encapsulated, filename='lident1.ps'
endif
;
get_lun,lun1
openr,lun1,filesp
wla=fltarr(30000)
fla=wla
i=0
while not eof(lun1) do begin
  readf,lun1,wl0,fl0
  wla(i)=wl0 & fla(i)=fl0
  i=i+1
endwhile
close,lun1
free_lun,lun1
;
nln=i-1
wla=wla(0:nln)
fla=fla(0:nln)
set_viewport,0.13,0.95,0.15,0.65
ra=[wstart,wend]
;
 plot,wla,fla,xr=ra,_extra=e
;
 ewl=ewlim
 lineid_select,fileid,wli,lid,wst,st,ew,ewlim=ewl,range=ra
 lineid_annot,wla,fla,wli,ew,lid,wst,charid=charid,extend=extend
 set_viewport
;
if keyword_set(iprint) then begin
	device,/close
	spawn,'print idl.ps'
	set_plot,'win'
endif
end


pro lineid_select,file,Wline,lineid,wstring,strength,eqw, $
		  ewlim=ewlim,n=n,range=range
;+
;                       lineid_select
;
; procedure to extract the wave and ID's from the SYNSPEC output file
; input: file=name of file
; output:Wline = real*8 vector of wavelengths
;        lineid  = vector of identifications (string array)
;        wstring = string vector of wavelengths
;        strength = string line strength indicator
;        eqw      = approximate equivalent width
; optional keyword inputs:
;        ewlim = lower limit for approximate equivalent width
;                (default = 0)
;        N = strength indicator (  0  1      2       3       4
;                               (' ','.' or '*' or '**' or '***')
;               (default n = 2)
;        range = 2 element vector giving desired wavelength range
;               (default = [0,99999])
;-
;----------------------------------------------------------------------------
;
; print calling sequence
;
	if n_params(0) lt 1 then begin
		print,'CALLING SEQUENCE: lineid_select,file,Wline,lineid,'+ $
				'wstring,strength,eqw'

		print,'OPTIONAL KEYWORD PARAMETERS:'
		print,' EWLIM = limiting approx. equivalent width'
		print,' RANGE = [wmin,wmax]             default=[0,99999]'
		print,' N = minimum strength (0-4)      default=2'
		return
	end
;
; set keyword defaults
;
	if n_elements(N) eq 0 then N=2
	if n_elements(ewlim) eq 0 then ewlim=0
	if n_elements(range) eq 0 then range = [0,999999]
	wmin = range(0)
	wmax = range(1)
;
; open input file
;       
	get_lun,lun
	openr,lun,file
;
; initialization for loop
;
	st = ''
	wline = dblarr(2000)
	wstring = strarr(2000)
	lineid = strarr(2000)
	strength = strarr(2000)
	eqw = fltarr(2000)
	nlines = 0
;
; loop on lines in the file
;
	while not eof(lun) do begin
	    readf,lun,st                                  ;read string
	    st = strtrim(st,2)                          ;trim blanks
	    for i=0,1 do junk=gettok(st,' ')            ;skip first 2 columns
	    wave = gettok(st,' ')                       ;get wavelength
	    w = double(wave)                            ;convert to r*8

	    if (w ge wmin) and (w le wmax) then begin   ;within range?
		el = gettok(st,' ')                     ;element
		strput,el,strlowcase(strmid(el,1,1)),1  ;make second character
							;  lower case
		ion = gettok(st,' ')
		for i=5,7 do junk = gettok(st,' ')      ;skip columns 5-7
		ews = gettok(st,' ')
		ew=float(ews)
;            help,ew,ews
		str = strtrim(st,2)                     ;strength
		case str of                             ;decode strength
			''   : Nx=0
			'.'  : Nx=1
			'*'  : Nx=2
			'**' : Nx=3
			'***': Nx=4
			else : Nx=999                   ;unknown
		endcase
;
; add line to the list
;
		if Nx ge N and ew ge ewlim then begin
			wline(nlines) = w
			wstring(nlines) = wave + ' '
			lineid(nlines) =  el + ' ' + ion + ' '
			strength(nlines) = str
			eqw(nlines) = ew
			nlines = nlines + 1
		endif
	    end
	end
;
; extract good part of the arrays
;
	if nlines gt 0 then begin
		wline = wline(0:nlines-1)
		wstring = wstring(0:nlines-1)
		lineid = lineid(0:nlines-1)
		strength = strength(0:nlines-1)
		eqw = eqw(0:nlines-1)
	    end else begin
		print,'LINEID_SELECT: No lines found for given range/N'
	end
	close,lun
	free_lun,lun
return
end

pro lineid_annot,wave,flux,wline,eqw,text1,text2,text3,  $
	charid=charid,extend=extend,charthick=charthick
;+
;                               lineid_plot2b
;
; Plot spectrum with specified line identifications annotated at the
; top of the plot.
;
; CALLING SEQUENCE:
;       lineid_annot,wave,flux,wline,eqw,text1,text2,text3,   $
;                   charid=charid,extend = extend, charthick = charthick
;
; INPUTS:
;       wave - wavelength vector for the plot
;       flux - flux vector
;       wline - vector of line identifications.  (only the lines between
;               the plot limits will be used)
;       eqw   - vector of equivalent widths
;       text1 - string array of text to be used to annotate each line
;       text2 - (OPTIONAL) second string array of text to be used for
;               line annotation.  Since the text is written with
;               proportional spaced characters, TEXT2 can be used if
;               you want two sets of annotation to be alinged:
;
;               eg:     Cr IV  1390.009
;                       Fe V   1390.049
;                       Ni IV  1390.184
;                           instead of
;                       Cr IV 1390.009
;                       Fe V 1390.049
;                       Ni IV 1390.184
;       text3 - still additional text
;
; OPTIONAL KEYWORD INPUTS:
;
;               extend = specifies that the annotated lines should have a
;                       dotted line extended to the spectrum to indicate the
;                       line position.  EXTEND can be a scalar (applies to
;                       all lines) or a vector with a different value for
;                       each line.  The value of EXTEND gives the line
;                       IDL plot line thickness for the dotted lines.
;                       If EXTEND is a vector each dotted line can have a
;                       different thickness.  A value of 0 indicates that
;                       no dotted line is to be drawn. (default = scalar 0)
;               charid  = the character size of the annotation for each line.
;                       If can be a vector so that different lines are
;                       annotated with different size characters.  Charsize
;                       can be used to make stronger lines have a larger
;                       annotation. (default = scalar 1.0).
;               charthick = the character thickness of the annotation for 
;                       each line. If can be a vector so that different lines
;                       are annotated with characters of varying thickness.
;                       CHARTHICK can be used to make stronger lines have
;                       a bolder annotation. (default = !p.charthick)
; OPERATIONAL NOTES:
;
;       Once the program has completed, You can use OPLOT to draw additional
;       plots on the display. The plots !X.TITLE and !Y.TITLE are used but
;       the !P.TITLE (!MTITLE) is ignored.
;
;       If your annotated characters are not being rotated properly,
;       try setting !FANCY to a non zero value.
;
;       !X.RANGE, !Y.RANGE or the routine SET_XY can be used to change
;       plot limits before calling LINEID_PLOT.
;
; HISTORY:
;       version 1  D. Lindler Jan, 1992
;       Sept 27, 1993  DJL  fixed bug in /extend option
;       version 2 I. Hubeny Dec, 1993
;        extension for selecting and plotting using equivalent width
;-
;----------------------------------------------------------------------------

	if n_params(0) lt 1 then begin
	   print,'CALLING SEQUENCE: lineid_annot,wave,flux,wline,eqw,text1'+ $
		 '[,text2,text3]
	   print,'OPTIONAL KEYWORD PARAMETERS'
	   print,'EXTEND = switch for drawing indicating lines'
	   print,'CHARID = character size'
	   print,'CHARTHICK = character thickness'
	   retall
	end
;
; initialization
;

	if n_elements(charid) eq 0 then charid=1
	n = n_elements(wline)
	if n_elements(text2) eq 0 then text2 = strarr(n)
	if n_elements(text3) eq 0 then text3 = strarr(n)
	if n_elements(charid) eq 1 then csize = replicate(charid,n) $
				     else csize = charid
	if n_elements(extend) eq 0 then extend = 0
	if n_elements(extend) eq 1 then begin
	 if extend lt 0 then begin 
	   ethick = alog10(eqw*abs(extend))
	 endif else ethick = replicate(extend,n)
	endif else ethick = extend
	if n_elements(charthick) eq 0 then cthick = !p.charthick $
				      else cthick = charthick
	if n_elements(cthick) eq 1 then cthick = replicate(cthick,n)
;
; set plot area
;
;       set_viewport,0.13,0.95,0.3,0.55
;
; plot data
;
;       plot,wave,flux,title=' ',xstyle=1
;
; get data ranges
;
	xmin = !x.crange(0)
	xmax = !x.crange(1)
	ymin = !y.crange(0)
	ymax = !y.crange(1)
	xrange = xmax-xmin
	yrange = ymax-ymin
;
; find lines within x range and sort them
;
	good = where((wline gt xmin) and (wline lt xmax),nlines)
	if nlines lt 1 then return
	wl = wline(good)
	csize = csize(good) & cthick = cthick(good) & ethick = ethick(good)
	txt1 = text1(good) & txt2 = text2(good)

	sub = sort(wl)
	wl = wl(sub) & csize = csize(sub) & ethick = ethick(sub)
	chtick = cthick(sub) 
	txt1 = txt1(sub)  
	txt2 = txt2(sub)
	es   = string(format='(i5)',eqw)
	txt2 = txt2+es(good)+' '+text3(sub)
	maxids = 65/(total(csize)/nlines)   ;maximum number of identifications
	if nlines gt maxids then begin
		print,'Too many lines to mark'
		retall
	endif

;
; determine character height in wavelength units
;
	char_height = abs(xrange) / 65 * csize
;
; adjust wavelengths of where to print the line ids
;
	wlp = wl                ;wavelength to print text
;
; test to see if we can just equally space the annotated lines
;
	if (nlines gt maxids*0.85) and (n_elements(charid) eq 1) then begin
		wlp = findgen(nlines) * (xrange/(nlines-1)) + xmin
		goto,print_text
	end
;
; iterate to find room to annotate each line
;
	changed = 1             ;flag saying we moved a wlp position
	niter = 0
	factor = 0.35           ;size of adjustments in text position
	while changed do begin  ;iterate
	    changed = 0
	    for i=0,nlines-1 do begin
;
; determine the difference of the annotation from the lines on the
; left and right of it and the required separation
;
		if i gt 0 then begin
			diff1 = wlp(i)-wlp(i-1)
			separation1 = (char_height(i)+char_height(i-1))/2.0
		    end else begin
			diff1 = wlp(i) - xmin + char_height(i)*1.01
			separation1 = char_height(i)
		end

		if i lt (nlines-1) then begin
			diff2 = wlp(i+1) - wlp(i)
			separation2 = (char_height(i)+char_height(i+1))/2.0
		    end else begin
			diff2 = xmax + char_height(i)*1.01 - wlp(i)
			separation2 = char_height(i)
		end
;
; determine if line annotation should be moved
;
		if (diff1 lt separation1) or (diff2 lt separation2) then begin
		    if wlp(i) eq xmin then diff1 = 0
		    if wlp(i) eq xmax then diff2 = 0
		    if diff2 gt diff1 then $
				wlp(i) = (wlp(i) + separation2*factor) < xmax $
			   else wlp(i) = (wlp(i) - separation1*factor) > xmin
		    changed = 1
		endif

	    end

	    if niter eq 300 then $              ; fine adjustment for 
			factor = factor/3       ; crowded field
			

	    if niter eq 1000 then changed=0     ; stop at 1000 iterations
	    niter = niter + 1

	endwhile

;
; print line id's
;
print_text:
	maxcsize = max(csize)
	start_arrow = ymax + yrange/60
	bend1 = ymax + yrange/30
	bend2 = ymax + (yrange/30)*3
	stop_arrow = ymax + (yrange/30)*4
	start_text1 = stop_arrow + yrange/50*maxcsize
	start_text2 = start_text1 +  $
			max(strlen(strtrim(txt1,1)))*yrange/40*maxcsize

	for i=0,nlines-1 do begin
		plots,[wl(i),wl(i),wlp(i),wlp(i)], $
		      [start_arrow,bend1,bend2,stop_arrow]
		xyouts,wlp(i) + char_height(i)/2, start_text1, txt1(i), $
			orientation = 90, size=csize(i), charthick = cthick(i)
		xyouts,wlp(i) + char_height(i)/2, start_text2, txt2(i), $
			orientation = 90, size=csize(i), charthick = cthick(i)
	endfor
;
; extend selected lines down to the spectrum
;
	good = where((ethick gt 0) and (wl gt xmin) and (wl lt xmax),n)
	if n lt 1 then return
	ww = wl(good)
	ethick = ethick(good)
;         help,wave
;         help,flux
;         help,ww
;         print,n_elements(wave)
;         print,n_elements(flux)
;         print,wline
	linterp,wave,flux,ww,ff
	ymax = !y.crange(1)
	ymin = !y.crange(0)
	offset = (ymax-ymin)/20.0
	for i=0,n-1 do plots,[ww(i),ww(i)],[(ff(i)+offset)<ymax,ymax], $
				line=2,thick = ethick(i)

return
end







