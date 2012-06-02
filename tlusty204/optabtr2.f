      implicit real*8(a-h,o-z)
      character*(80) optable
      real*8 nu
      common/vectors/ tempvec(50),rhovec(50)
      common/opacities/ nu(30000),absopac(50,50,30000)
        read(5,*) optable
   20   open(52,file=optable,status='old')
	read(52,*) numfreq,numtemp,numrho
	read(52,*)
	read(52,*) (tempvec(i),i=1,numtemp)
	read(52,*)
	read(52,*) (rhovec(j),j=1,numrho)
	do k = 1, numfreq
	 read(52,*)
	 read(52,*)
	 read(52,*) nu(k)
	 do j = 1, numrho
            read(52,*) (absopac(i,j,k),i=1,numtemp)
	 end do
	end do
	close(52)
c
        write(63) numfreq,numtemp,numrho
        write(63) (tempvec(i),i=1,numtemp)
        write(63) (rhovec(j),j=1,numrho)
        do k = 1, numfreq
           write(63) nu(k)
           do j = 1, numrho
              write(63) (absopac(i,j,k),i=1,numtemp)
           end do
        end do
        close(63)
c
        end


