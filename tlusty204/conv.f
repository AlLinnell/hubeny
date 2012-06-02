      Program conv
      open (unit=5,file='fort.13',status='old')
      open (unit=8,file='fort.13A',status='replace')
      do j=1,1000000
      read (5,100,end=9)vnu,fl,edd
  100 format(e15.8,e12.4,f7.3)
c     wavelength in Angstroms units
      wl=2.99792458E18/vnu
      fla=fl
c     flux in erg/cm^2/s^-1/Angstrom
      fl=fla*vnu**2/2.99792458E18
      write (8,100)wl,fl,edd
      end do
    9 close (5,status='keep')
      close (8,status='keep')
      end program conv
