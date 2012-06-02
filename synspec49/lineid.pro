pro lineid,fileid=fileid,filesp=filesp,extend=extend,$
           ewlim=ewlim,charsize=charsize,wstart=wstart,wend=wend,$
		   _extra=e
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
set_viewport,0.13,0.95,0.25,0.65
ra=[wstart,wend]
print,nln
;
 plot,wla,fla,xr=ra,_extra=e
;
 ewl=ewlim
 lineid_select,fileid,wli,lid,wst,st,ew,ewlim=ewl,range=ra
 lineid_annot,wla,fla,wli,ew,lid,wst,charsize=charsize,extend=extend
 set_viewport
;
end







