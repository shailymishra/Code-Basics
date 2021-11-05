/*
	Simple UDP Server
*/

#include<stdio.h>
#include<winsock2.h>
#include <conio.h>
#include <stdio.h>
#include <string.h>

#pragma comment(lib,"ws2_32.lib") //Winsock Library

#define BUFLEN 1024	//Max length of buffer
#define PORT 8888	//The port on which to listen for incoming data

int main()
{
	SOCKET s;
	struct sockaddr_in server, si_other;
	int slen , recv_len;
	char buf[BUFLEN];
	WSADATA wsa;
    struct Books {
    char  title[50];
    char  author[50];
    char  subject[100];
    int   book_id;
    } book; 
    FILE* fp = fopen("readwrite.csv", "a+");

	slen = sizeof(si_other) ;
	
	if (!fp) {
        // Error in file opening
        printf("Can't open file\n");
        return 0;
    }


	//Initialise winsock
	printf("\nInitialising Winsock...");
	if (WSAStartup(MAKEWORD(2,2),&wsa) != 0)
	{
		printf("Failed. Error Code : %d",WSAGetLastError());
		exit(EXIT_FAILURE);
	}
	printf("Initialised.\n");
	
	//Create a socket
	if((s = socket(AF_INET , SOCK_DGRAM , 0 )) == INVALID_SOCKET)
	{
		printf("Could not create socket : %d" , WSAGetLastError());
	}
	printf("Socket created.\n");
	
	//Prepare the sockaddr_in structure
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = INADDR_ANY;
	server.sin_port = htons( PORT );
	
	//Bind
	if( bind(s ,(struct sockaddr *)&server , sizeof(server)) == SOCKET_ERROR)
	{
		printf("Bind failed with error code : %d" , WSAGetLastError());
		exit(EXIT_FAILURE);
	}
	puts("Bind done");

	//keep listening for data
	while(1)
	{
		printf("Waiting for data...");
		fflush(stdout);
		
		//clear the buffer by filling null, it might have previously received data
		memset(buf,'\0', BUFLEN);
		
		//try to receive some data, this is a blocking call
		//recvfrom(s, (char*)buf, sizeof(myStruct_), 0, (struct sockaddr *)&client_sock, &slen);
		recv_len = recvfrom(s, buf, BUFLEN, 0, (struct sockaddr *) &si_other, &slen);
		Books *BookTosend=(Books *)buf;
		printf( "Sever Book 1 title : %s\n", BookTosend->title);
		printf( "Book 1 author : %s\n", BookTosend->author);
		printf( "Book 1 subject : %s\n", BookTosend->subject);
		printf( "Book 1 book_id : %d\n", BookTosend->book_id);

    // Saving data in file
	    fprintf(fp, "%s, %s, %s,%d\n", BookTosend->title,
            BookTosend->author, BookTosend->subject,BookTosend->book_id);

		// if ((recv_len = recvfrom(s, buf, BUFLEN, 0, (struct sockaddr *) &si_other, &slen)) == SOCKET_ERROR)
		// {
		// 	printf("recvfrom() failed with error code : %d" , WSAGetLastError());
		// 	exit(EXIT_FAILURE);
		// }
		
		//print details of the client/peer and the data received
		printf("Received packet from %s:%d\n", inet_ntoa(si_other.sin_addr), ntohs(si_other.sin_port));
		printf("Data: %s\n" , buf);
		
		// //now reply the client with the same data
		// if (sendto(s, buf, recv_len, 0, (struct sockaddr*) &si_other, slen) == SOCKET_ERROR)
		// {
		// 	printf("sendto() failed with error code : %d" , WSAGetLastError());
		// 	exit(EXIT_FAILURE);
		// }
	}
    fclose(fp);

	closesocket(s);
	WSACleanup();
	
	return 0;
}