%echoudp('off');
%echoudp("on",2021);
uFirst = udpport("LocalPort",2021,"EnablePortSharing",true);
configureTerminator(uFirst, "CR/LF");
disp(uFirst.Terminator);
configureCallback(uFirst,"terminator",@sendAcknowledgement);
disp(uFirst.BytesAvailableFcn);
disp(uFirst.BytesAvailableFcnMode);
%echoudp("off");
pause(10);

function sendAcknowledgement(u, ~)
% Read the data received from the other udpport instance. readline removes
% the terminator from the data read.
data = readline(u);

% Prepare the acknowledgement string.
data = "COMMAND RECEIVED - """ + data +  """. SENDING ACKNOWLEDGEMENT.";
disp(data);
% Send the acknowledgement string, followed by the Terminator "CR/LF", to the
% udpport instance bound to port 3030 in the first MATLAB instance.
writeline(u, data, "127.0.0.1", 3000);
end


