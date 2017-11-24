/*
 * =====================================================================================
 *
 *       Filename:  echo_server.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2017년 11월 24일 15시 04분 16초
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  DH. Park (ppdha82), dh1982.park@samsung.com
 *        Company:  Samsung Techwin Co.
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define	BUF_SIZE		1024
#define	TEMP_BUF_SIZE	20
#define	LISTEN_COUNT	5

void error_handling(char *message);

int main(int argc, char *argv[])
{
	int serv_sock;
	int clnt_sock;
	char message[BUF_SIZE];
	int str_len;
	
	struct sockaddr_in serv_addr;
	struct sockaddr_in clnt_addr;
	int clnt_addr_size;

	if (argc != 2)
	{
		printf("Usage : %s <port>\n", argv[0]);
		exit(1);
	}

	serv_sock = socket(PF_INET, SOCK_STREAM, 0);

	if (serv_sock == -1)
	{
		error_handling("socket() error");
	}

	memset(&serv_addr, 0, sizeof(serv_addr));
	serv_addr.sin_family = AF_INET;
	serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	serv_addr.sin_port = htons(atoi(argv[1]));

	if (bind(serv_sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
	{
		error_handling("bind() error");
	}

	if (listen(serv_sock, LISTEN_COUNT) < 0)
	{
		error_handling("listen() error");
	}

	clnt_addr_size = sizeof(clnt_addr);

	clnt_sock = accept(serv_sock, (struct sockaddr*)&clnt_addr, &clnt_addr_size);
	if (clnt_sock < 0)
	{
		error_handling("accept() error");
	}

	while((str_len = read(clnt_sock, message, BUF_SIZE)) != 0)
	{
		write(clnt_sock, message, str_len);
		write(1, message, str_len);
	}

	close(serv_sock);
	close(clnt_sock);
	return 0;
}


void error_handling(char *message)
{
	fputs(message, stderr);
	fputc('\n', stderr);
	exit(1);
}
