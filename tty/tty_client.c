/*
 * =====================================================================================
 *
 *       Filename:  tty_client.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  01/17/2019 07:14:07 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Deuk Hyun Park (ppdha82), ppdha82@focushns.com
 *        Company:  Focus H&S
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <termios.h>
#include <fcntl.h>

int main(int argc, char** argv)
{
	int fd;
	// 통신 포트를 파일 개념으로 사용하기 위한 디스크립터 입니다.
	// 이 파일 디스크립터를 이용하여 표준 입출력 함수를 이용할 수 있습니다. 

	struct termios newtio;
	// 보오율이나 stop bit 크기 등의 시리얼 통신 환경을 설정하기 위해
	// termios 구조체를 선언했습니다. 
	fd = open( "/dev/ttyAMA2", O_RDWR | O_NOCTTY | O_NONBLOCK );

	// /dev/ttyS0를 사용하기 위해 open()함수를 사용합니다.
	// O_RDWR은 파일 디스크립터인 fd를 읽기와 쓰기 모드로 열기 위한 지정이며
	// O_NOCCTY와 O_NONBLOCK는 시리얼 통신 장치에 맞추어 추가했습니다.

	memset( &newtio, 0, sizeof(newtio) );

	// 시리얼 통신환경 설정을 위한 구조체 변수 newtio 값을 0 바이트로 깨끗이 채웁니다. 

	newtio.c_cflag = B115200;   // 통신 속도 115200 
	newtio.c_cflag |= CS8;		// 데이터 비트가 8bit
	newtio.c_cflag != CLOCAL;	// 외부 모뎀을 사용하지 않고 내부 통신 포트 사용
	newtio.c_cflag != CREAD;	// 쓰기는 기본, 읽기도 가능하게
	newtio.c_iflag = 0;         // parity 비트는 없음
	newtio.c_oflag = 0;
	newtio.c_lflag = 0;
	newtio.c_cc[VTIME] = 0; 
	newtio.c_cc[VMIN] = 1; 

	tcflush (fd, TCIFLUSH );
	tcsetattr(fd, TCSANOW, &newtio );   // 포트에 대한 통신 환경을 설정합니다. 

	char test[128];
	memset (test, 0, sizeof (test));
	strcat(test, argv[1]);
	strcat(test, "\n");
	write( fd, test, sizeof(test) );
	// 표준 입출력 함수를 이용하여 시리얼 포트로 17자의 문자열을 전송합니다.

	close( fd);
	// 통신 포트를 닫아 사용을 중지합니다. 

	return 0; 
}
