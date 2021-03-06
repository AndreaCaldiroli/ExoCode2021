      module output_write
      ! Write the output to the standard output files
      
      use global_parameters
      
      
      contains
      
      subroutine write_output(rho,v,p,T,heat,cool,eta,    &
                              nhi,nhii,nhei,nheii,nheiii,flag)
                              
      character(len = 6) :: tab = '      '
      character(len = 2) :: flag
      integer :: j
      real*8, dimension(1-Ng:N+Ng), intent(in) :: rho,v,p,T
      real*8, dimension(1-Ng:N+Ng), intent(in) :: heat,cool
      real*8, dimension(1-Ng:N+Ng), intent(in) :: eta
      real*8, dimension(1-Ng:N+Ng), intent(in) :: nhi,nhii
      real*8, dimension(1-Ng:N+Ng), intent(in) :: nhei,nheii,nheiii
      
      
      !---- Write thermodynamic profiles ----! 
          
      if (flag.eq.'eq') then    
       
      	open(unit = 2, file = './output/Hydro_ioniz.txt')
      	
	else	! Change output file after postprocessing
	
		open(unit = 2, file = './output/Hydro_ioniz_adv.txt')
		
	endif
      
            do j = 1-Ng,N+Ng
                  write(2,*) r(j),          &     ! Rad. dist.
                             rho(j)*n0,     &     ! Density
                             v(j),          &     ! Velocity
                             p(j)*p0,       &     ! Pressure
                		     T(j)*T0,       &     ! Temperature
                		     heat(j)*q0,    &     ! Rad. heat.
                		     cool(j)*q0,    &     ! Rad. cool.
                		     eta(j)                   ! Heat. eff.
            enddo
      close(2)
      
      
      !---- Write ionization profiles ----!  
      if (flag.eq.'eq') then   
      
      	open(unit = 3, file = './output/Ion_species.txt')
      	
	else	! Change output file after postprocessing
	
		open(unit = 3, file = './output/Ion_species_adv.txt')
		
	endif
	
            do j = 1-Ng,N+Ng
            
                  write(3,*) r(j),        & ! Rad. dist.
                             nhi(j)*n0,   & ! HI
            	 	     nhii(j)*n0,  & ! HII
            		     nhei(j)*n0,  & ! HeI
            		     nheii(j)*n0, & ! HeII
             		     nheiii(j)*n0       ! HeIII
            enddo
      close(3)
                  
                        
      !---- Writing format specification ----!
      
      ! Thermodynamic variables
2     format (F8.5,A,     &
              E12.5,A,    &
              E12.5,A,    &
              E12.5,A,    &
              F8.2,A,     &
              E12.5,A,    &
              E12.5,A,    &
              E12.5)             
 
      ! Ionization Profiles 
3     format (F8.5,A,4(E12.5,A),E12.5)
 
           
      end subroutine write_output
      
      
      ! End of module
      end module output_write
