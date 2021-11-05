echoudp("off");
PORT = 5241;  % port of this server
echoudp("on",PORT);
u = udpport("datagram","IPV4","LocalPort", PORT,"EnablePortSharing",true);

s = struct('a','b','b',555);
b = string(s);
write(u,b,"string","192.168.1.110",PORT);

while false
    if (u.NumDatagramsAvailable > 0)  % if udp was received
        
        % read udp
        datagram = read(u, u.NumDatagramsAvailable, "uint8");
        
        % get datagram components
        data = datagram.Data;
        senderAdress = datagram.SenderAddress;
        senderPort = datagram.SenderPort;
        disp(data);

        break
    end
end

%data = read(u,1,"uint16");
%disp(data);
%flush(u,"output");
%clear u
