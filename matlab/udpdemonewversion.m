PORT = 12000;  % port of this server
uSecond = udpport("LocalPort", PORT,"EnablePortSharing",true);
configureTerminator(uSecond,"CR/LF");
disp(uSecond.Terminator);
configureCallback(uSecond,"terminator",@readAcknowledgement);
disp(uSecond.BytesAvailableFcn);
disp('ok');
disp(uSecond.BytesAvailableFcnMode);
configureCallback(uSecond, "off");
pause(10);

clear uSecond;
function readAcknowledgement(u, ~)
disp('here')
% Read the acknowledgement data. readline removes the Terminator from the
% data read.
data = readline(u);

% Display the acknowledgement string read.
disp(data);
end
