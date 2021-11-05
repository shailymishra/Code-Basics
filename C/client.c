/*
	Simple udp client
*/
#include<stdio.h>
#include<winsock2.h>

#pragma comment(lib,"ws2_32.lib") //Winsock Library

#define SERVER "127.0.0.1"	//ip address of udp server
#define BUFLEN 512	//Max length of buffer
#define PORT 8888	//The port on which to listen for incoming data

int main(void)
{
	struct sockaddr_in si_other;
	int s, slen=sizeof(si_other);
	char buf[BUFLEN];
	//char message[BUFLEN];
    char message[]="micasa";
	FILE* fp = fopen("w.csv", "a+");


    struct Books {
    char  title[50];
    char  author[50];
    char  subject[100];
    int   book_id;
    } book; 
	WSADATA wsa;


    struct Books Book1;        /* Declare Book1 of type Book */
    /* book 1 specification */
    strcpy( Book1.title, "C Programming");
    strcpy( Book1.author, "Nuha Ali"); 
    strcpy( Book1.subject, "C Programming Tutorial");
    Book1.book_id = 6495407;
    Books *BookTosend = &Book1;
    /* print Book1 info */
    printf( "Book 1 title : %s\n", BookTosend->title);
    printf( "Book 1 author : %s\n", BookTosend->author);
    printf( "Book 1 subject : %s\n", BookTosend->subject);
    printf( "Book 1 book_id : %d\n", BookTosend->book_id);


	//Initialise winsock
	printf("\nInitialising Winsock...");
	if (WSAStartup(MAKEWORD(2,2),&wsa) != 0)
	{
		printf("Failed. Error Code : %d",WSAGetLastError());
		exit(EXIT_FAILURE);
	}
	printf("Initialised.\n");
	
	//create socket
	if ( (s=socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) == SOCKET_ERROR)
	{
		printf("socket() failed with error code : %d" , WSAGetLastError());
		exit(EXIT_FAILURE);
	}
	
	//setup address structure
	memset((char *) &si_other, 0, sizeof(si_other));
	si_other.sin_family = AF_INET;
	si_other.sin_port = htons(PORT);
	si_other.sin_addr.S_un.S_addr = inet_addr(SERVER);
	
	//start communication
	while(1)
	{
		// printf("Enter message : ");
		// gets(message);
		//message ="mivats";
		//send the message
        sendto(s, (char*)&Book1, sizeof(Book1), 0, (struct sockaddr *) &si_other, slen);
        //dwBytes = sendto(s,BookTosend, sizeof(*BookTosend),0 , (struct sockaddr *) &si_other, slen);
		if (sendto(s, message, strlen(message) , 0 , (struct sockaddr *) &si_other, slen) == SOCKET_ERROR)
		{
			printf("sendto() failed with error code : %d" , WSAGetLastError());
			exit(EXIT_FAILURE);
		}
		
		//receive a reply and print it
		//clear the buffer by filling null, it might have previously received data
		memset(buf,'\0', BUFLEN);
		//try to receive some data, this is a blocking call
		if (recvfrom(s, buf, BUFLEN, 0, (struct sockaddr *) &si_other, &slen) == SOCKET_ERROR)
		{
			printf("recvfrom() failed with error code : %d" , WSAGetLastError());
			exit(EXIT_FAILURE);
		}
		
		puts(buf);
	}

	closesocket(s);
	WSACleanup();

	return 0;
}