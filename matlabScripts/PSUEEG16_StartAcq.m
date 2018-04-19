function [ PSUEEG ] = PSUEEG16_StartAcq( PSUEEG )
% ********************
% Jerry171024
% ********************
% send a stop command to the PSUEEG
% then close the com port
fwrite(PSUEEG.s,PSUEEG.cmd.RDATAC);  %% if needed stop any acquistion on the board
PSUEEG.status = 'RDATAC';
end

