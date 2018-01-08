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
#include <assert.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <netinet/in.h>
#include <unistd.h>


//#define	__TEST__
// googletest
#if defined (__TEST__)
#include <gtest/gtest.h>
#endif

#define	BUF_SIZE		1024
#define	TEMP_BUF_SIZE	20
#define	LISTEN_COUNT	5

void error_handling(char *message);
void childHandler(int signal);

#if defined(__TEST__)
int getBuildNumber(char* build, char* project)
{
	char* p = NULL;
	if (build == NULL || project == NULL) {
		return -1;
	}
	if (strlen(build) <= strlen(project)) {
		return -1;
	}
	if (strstr(build, project) == NULL) {
		return -1;
	}
	p = build + strlen(project);
	return atoi(p);
}

TEST(getBuildNumberTest, HandlesPositiveInput)
{
	EXPECT_EQ(1301, getBuildNumber("ABC1301", "ABC"));
	EXPECT_EQ(1401, getBuildNumber("ABC1401", "ABC"));
	EXPECT_EQ(-1, getBuildNumber("CIH1401", "ABC"));
	EXPECT_EQ(-1, getBuildNumber("CIH1401", "ABC"));
	EXPECT_TRUE(strcmp("ABC1400", "ABC1301") > 0);
	EXPECT_TRUE(strcmp("ABC1400", "ABC1400") == 0);
	EXPECT_TRUE(strcmp("ABC1400", "ABC1401") < 0);
}
#endif	/* #if defined(__TEST__) */

int main(int argc, char *argv[])
{
#if defined(__TEST__)
	testing::InitGoogleTest(&argc, argv);
	RUN_ALL_TESTS();
#else
	int serv_sock;
	int clnt_sock;
	char message[BUF_SIZE];
	int str_len;
	
	struct sockaddr_in serv_addr;
	struct sockaddr clnt_addr;
	socklen_t clnt_addr_size;
	pid_t pid;
	struct sockaddr_in peerSocket;

	signal(SIGCHLD, (void (*)(int)) childHandler);

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

	while (1)
	{
		clnt_addr_size = sizeof(clnt_addr);

		while((clnt_sock = accept(serv_sock, (struct sockaddr*)&clnt_addr, &clnt_addr_size)) >= 0)
		{
			getpeername(clnt_sock, (struct sockaddr*)&peerSocket, &clnt_addr_size);
#if 0
			char peerName[sizeof(peerSocket.sin_addr) + 1] = {0, };
			sprintf (peerName, "%s", inet_ntoa(peerSocket.sin_addr));

			if (strcmp(peerName, "0.0.0.0") != 0)
			{
				error_handling("getpeername() error");
			}
#endif			
			pid = fork();

			if (pid == 0)
			{
				close(serv_sock);
				while((str_len = read(clnt_sock, message, BUF_SIZE)) != 0)
				{
					write(clnt_sock, message, str_len);
					write(1, message, str_len);
				}
			}
		}
#if 1
		if (clnt_sock < 0)
		{
			close(clnt_sock);
			error_handling("accept() error");
		}
#endif
	}
	close(serv_sock);
#endif	/* #if defined(__TEST__) */
	return 0;
}


void error_handling(char *message)
{
	fputs(message, stderr);
	fputc('\n', stderr);
	exit(1);
}

void childHandler(int signal)
{
	int status;
	pid_t spid;

	while ((spid = waitpid (-1, &status, WNOHANG)) > 0)
	{
		printf("자식 프로세스 wait 한 결과 \n");
		printf("============================\n");
		printf("%15s:%3d\n", "PID", spid);
		printf("%15s:%3d\n", "Exit Value", WEXITSTATUS(status));
		printf("%15s:%3d\n", "Exit Stat", WIFEXITED(status));
	}
}
