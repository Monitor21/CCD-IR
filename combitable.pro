pro combitable

dir="../IR/MERGERuNS/"
readcol, dir+"averagemag.tab", nameir, air, rair,decir, nobsir, ncalir, $
meancalstdir, stdcalstdir,magtargir, meantargstdir, stdtargstdir,$
format='(a,a,d,d,i,i,f,f,f,f,f)'

dir="../CCD/GENSCRIPTS/"
readcol, dir+"averagemag.tab", name, a, ra,dec, nobs, ncal, $
meancalstd, stdcalstd,magtarg, meantargstd, stdtargstd,avesigmacirca,ssigmacirca,$
format='(a,a,d,d,i,i,f,f,f,f,f,f,f)'

nobsv=intarr(n_elements(nameir))
ncalv=intarr(n_elements(nameir))
meancalstdv=fltarr(n_elements(nameir))
stdcalstdv=fltarr(n_elements(nameir))
magtargv=fltarr(n_elements(nameir))
meantargstdv=fltarr(n_elements(nameir))
stdtargstdv=fltarr(n_elements(nameir))
avesigmacircav=fltarr(n_elements(nameir))
ssigmacircav=fltarr(n_elements(nameir))

for j=0,n_elements(nameir)-1 do begin
  crossid, rair[j], decir[j], ra, dec, result, cc
  if(result[0] ne -1) then nobsv[j]=nobs[result] 
  if(result[0] ne -1) then ncalv[j]=ncal[result]  
  if(result[0] ne -1) then meancalstdv[j]=meancalstd[result]  
  if(result[0] ne -1) then stdcalstdv[j]=stdcalstd[result] 
  if(result[0] ne -1) then magtargv[j]=magtarg[result] 
  if(result[0] ne -1) then meantargstdv[j]=meantargstd[result] 
  if(result[0] ne -1) then stdtargstdv[j]=stdtargstd[result]  
  if(result[0] ne -1) then avesigmacircav[j]=avesigmacirca[result] 
  if(result[0] ne -1) then ssigmacircav[j]=ssigmacirca[result] 
endfor
;print

get_lun, lun
openw, lun, "avecombi.tab"
for j=0,n_elements(nameir)-1 do begin
  printf, lun, nameir[j],rair[j],decir[j],nobsir[j],ncalir[j],$
  meancalstdir[j],stdcalstdir[j],magtargir[j],meantargstdir[j],stdtargstdir[j],$
  nobsv[j],ncalv[j],$
  meancalstdv[j],stdcalstdv[j],magtargv[j],meantargstdv[j],stdtargstdv[j],$
  format='(a15,x,d13.6,x,d13.6,x,2(x,i3),5(x,f7.3),x,2(x,i3),5(x,f7.3))'
endfor
close, lun
free_lun, lun

po='&'
popo='\\'
get_lun, lun
openw, lun, "avecombi.tex"
for j=0,n_elements(nameir)-1 do begin
  printf, lun, nameir[j],po,nobsir[j],po,ncalir[j],po,$
  meancalstdir[j],po,stdcalstdir[j],po,magtargir[j],po,meantargstdir[j],po,stdtargstdir[j],po,$
  nobsv[j],po,ncalv[j],po,$
  meancalstdv[j],po,stdcalstdv[j],po,magtargv[j],po,meantargstdv[j],po,stdtargstdv[j],po,$
  avesigmacircav[j],po,ssigmacircav[j],popo,$
  format='(a15,x,a2,x,2(x,i3,a2),5(x,f7.3,a2),x,2(x,i3,a2),7(x,f7.3,a2))'
endfor
close, lun
free_lun, lun

spawn, "sed 's/0.000/     /g' avecombi.tex > aa"
spawn, "sed 's/ 0 /  /g'  aa >avecombi.tex2"






end

;;;------------------------------------------------TO PERFORM a CROSSCORRELATION
;;;this macro return a vector and NOT the first elements
	      pro crossid, x1, y1, x2, y2, result, cc
	     
	result = -1

 	;looping trough the stars in the catalog
    test=sqrt(((x2-x1)*cos(y2*!pi/180.d0))^2+(y2-y1)^2)*3600.0d0
    ind=where( test lt 20.d0,cc ) 
    result=ind
 
if(ind[0] ne -1) then ind2=sort(test[ind])  ;;sorting to take the closest
if(ind[0] ne -1) then result=ind[ind2]  ;;only sorting
	  end
