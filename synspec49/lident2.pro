pro lident2,fileid=fileid,filesp=filesp,extend=extend,$
	   ewlim=ewlim,charid=charid,wstart=wstart,wend=wend,$
		   fl2sp=fl2sp,fl3sp=fl3sp,sc1=sc1,sc2=sc2,sc3=sc3,$
		   yrg=yrg,iprint=iprint,_extra=e
;
if not keyword_set(fileid) and not keyword_set(filesp) then begin
  print,'LIDENT'
  print,'keyword parameters: '
  print,'fileid  - filename of the identification table'
  print,'          (unit 12 output from Synspec)'
  print,'filesp  - filename of the theoretical synthetic spectrum'
  print,'extend  - if set, the annotated lines are drawn'
  print,'          all the way down to the spectrum'
  print,'ewlim   - limiting approx.equivalent width for annotations'
  print,'charid  - character size for annotation (default=1)
  print,'wstart  - starting wavelength for annotations'
  print,'wend    - ending wavelength for annotations'
  print,'fl2sp   - filename of the observed spectrum, for comparison'
  print,'fl3sp   - filename of the third spectrum'
  print,'sc1     - scaling divisor to apply to the theoretical spectrum'
  print,'sc2     - scaling factor to apply to the observed spectrum'
  print,'sc3     - scaling factor to apply to the third spectrum'
  print,'yrg     - exact ordinate range for plot'
  print,'iprint  - print command. If omitted, output to monitor'
  print,'and all keywords acceptable by IDL routine PLOT
  return
endif
;
if keyword_set(iprint) then begin
	set_plot,'ps'
	device,/land
;       device,/encapsulated, filename='lident2.ps'
endif
get_lun,lun1
openr,lun1,filesp
wla=fltarr(150000)
fla=wla
i=0
while not eof(lun1) do begin
  readf,lun1,wl0,fl0
  wla(i)=wl0 & fla(i)=fl0
  i=i+1
endwhile
fla=fla/sc1
close,lun1
free_lun,lun1
;
nln=i-1
wla=wla(0:nln)
fla=fla(0:nln)
set_viewport,0.13,0.95,0.15,0.65
ra=[wstart,wend]
;
 plot,wla,fla,xr=ra,/xsty,chars=2,charth=2,thick=3.0,$
 xthick=4.,ythick=4.,xchar=0.75,ychar=0.75,$
 xtit='!17Wavelength [A]!X',ytit='!17Flux!X',$
 yrange=yrg,/ysty,linestyle=0,_extra=e
;
 ewl=ewlim
 lineid_select,fileid,wli,lid,wst,st,ew,ewlim=ewl,range=ra
 lineid_annot,wla,fla,wli,ew,lid,wst,charid=charid,extend=extend
 plt,fl2sp,x,y,/nopl
 y=y/sc2
 oplot,x,y,thick=3
 plt,fl3sp,x1,y1,/nopl
 y1=y1/sc3
 oplot,x1,y1,thick=3
 set_viewport
;
if keyword_set(iprint) then begin
	device,/close
	spawn,'print idl.ps'
	set_plot,'win'
endif
end







