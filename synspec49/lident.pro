pro lident,fileid=fileid,filesp=filesp,extend=extend,$
	   ewlim=ewlim,charid=charid,wstart=wstart,wend=wend,$
	   _extra=e
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
get_lun,lun1
openr,lun1,filesp
wla=fltarr(150000)
fla=wla
i=0L
nln=i
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
end







