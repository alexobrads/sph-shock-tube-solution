module calc_derivs

  use ghosts
  use calc_density
  use equation_of_state
  use calc_accel
  implicit none


contains

  subroutine get_derivs(blob, n, ng, dt_new)
    real, intent(inout) :: blob(:,:)
    integer, intent(inout) :: n, ng
    real, intent(out) :: dt_new
    integer :: i

    do i=1,3
      call set_ghosts(blob, n, ng)
      call get_density(blob, n, ng)
      blob(:n, 4) = 1.2*(blob(:n, 3)/blob(:n, 5))

    enddo

    call set_ghosts(blob, n, ng)
    call eos(blob)
    call set_ghosts(blob, n, ng)
    call get_accel(blob, n, ng, dt_new)
    call set_ghosts(blob, n, ng)

  end subroutine get_derivs

end module calc_derivs
