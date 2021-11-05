%echoudp("off");
%u = udpport;
%flush(u,"output");
%clear u

book = struct('title',{},'author',{},'subject',{},'book_id',{});
PORT = 8888;  % port of this server
%echoudp("on",PORT);
%u = udpport;
%configureTerminator(u,"CR")
%u = udp(PORT);

u = udpport("datagram","IPV4","LocalPort", PORT,"EnablePortSharing",true,"OutputDatagramSize",1024);
%configureTerminator(u,"CR")
%
%write(u,1:5,"uint8","10.2.130.11",PORT);
disp('test')
while true
    %disp("Waiting for data...");
    drawnow('update');
    if(u.NumDatagramsAvailable == -1)
        disp('data read error');
    end
    if (u.NumDatagramsAvailable > 0)  % if udp was received
        disp('got something');
        disp(u.NumDatagramsAvailable)
        datagram = read(u, u.NumDatagramsAvailable, "uint8");
        senderAdress = datagram.SenderAddress;
        senderPort = datagram.SenderPort;
		sprintf("Received packet from %s:%d  %d \n", senderAdress, senderPort,u.NumDatagramsAvailable);

        %disp(senderAdress);
        %disp(senderPort);
        % read udp
        
        % get datagram components
        data = datagram.Data;
        disp(data);
        disp('ok');
        %data1 = fgets(u);
        s = char(data);
        disp(s)
        %sprintf(" Track No 		: %s  ",ctn_no);
		%sprintf(" course(deg)	: %f  \n",course);
		%sprintf(" speed(m/s)		: %f  \n",speed);
		%sprintf(" height (meter ): %f  \n",height);
		%sprintf(" dmax1 (meter ) : %f  \n",dmax1);
		%sprintf(" idn_by_node    : %f  \n",idn_by_node); % 1 Friendly  2 hostile
		%sprintf(" lat            : %f  \n",lat_long_wgs84.lat);
		%sprintf(" longitude      : %f  \n",lat_long_wgs84.longitude);
		%sprintf(" pos_x (in meter): %f  \n",cartesian_pos.pos_x);
		%sprintf(" pos_y (in meter ): %f  \n",cartesian_pos.pos_y);
        break
    end
end

%data = read(u,1,"uint16");
%disp(data);
flush(u,"output");
clear u;
