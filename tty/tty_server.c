/*
 * =====================================================================================
 *
 *       Filename:  tty_server.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  01/17/2019 07:00:41 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Deuk Hyun Park (ppdha82), ppdha82@focushns.com
 *        Company:  Focus H&S
 *
 * =====================================================================================
 */

/* serial.c
 *
 *	purpose :
 *		Serial device open/close/read/write.
 *
 ***************************************************************************************/
#include "common.h"

#define	DEFAULT_PORT_TIMEOUT_USEC	10

/***************************************************************************************
 * opening & closing serial device.
 ***************************************************************************************/

int tty_open(const char *ttydev, int baud,
			int databit, int stopbit, int parity,
			int handshake)	{
	int  htty;
	struct termios tty;

	NOTICE("%s : baud=%d, databit=%d, stopbit=%d, parity=%d, handshake=%d\n", ttydev, baud, databit, stopbit, parity, handshake);

	if ((htty = open (ttydev, O_RDWR | O_NOCTTY | O_NONBLOCK)) < 0) {
		perror ("open");
		return -1;
	}
	_printf("tty OPEN OK (%d)\n", htty);

	if (tcgetattr (htty, &tty) < 0) {
		perror ("tcgetattr");		
		goto on_func_failed;
	}

	if (cfsetispeed (&tty, (speed_t)baud) < 0) {				
		ERR ("Failed to set tty baud rate.\n");
		goto on_func_failed;
	}

	if (cfsetospeed (&tty, (speed_t)baud) < 0) {
		ERR("Failed to set baud rate of output!\n");
		goto on_func_failed;
	}

	cfmakeraw(&tty);

	tty.c_iflag &= ~(IGNPAR|PARMRK|IXON|IXOFF);
	tty.c_cflag &= ~(PARENB|PARODD|CSIZE|CRTSCTS|CSTOPB|CLOCAL);
	tty.c_cflag |= (databit|stopbit);

	if ((parity == PARMRK) || (parity == IGNPAR))
		tty.c_iflag |= parity;
	else
		tty.c_cflag |= parity;

	if (handshake != CRTSCTS)
		tty.c_iflag |= handshake;
	else
		tty.c_cflag |= handshake;

	tty.c_cc[VMIN]  = 1; // minimum character
	tty.c_cc[VTIME] = 0; // minimum wait time

	if (tcsetattr(htty, TCSANOW, &tty) < 0) {
		ERR ("Failed to set parameters!\n");
		goto on_func_failed;
	}
	_printf("SET RS485 BAUDRATE(%d)\n", baud);

	return htty;

on_func_failed:
	ERR ("Failed opening serial device(%s)\n", ttydev);
	close (htty);
	return -1;
}

void tty_close(int htty)
{
	if (htty < 0)
		return;
	tcdrain(htty);
	tcflush(htty, TCIOFLUSH);
	close(htty);
}

int	ttydev_open (ST_TTYDEV *dev, const char *ttydev, int baud, int databit, int stopbit, int parity, int handshake)
{
	assert (dev);
	assert (ttydev);
	dev->fd = tty_open (ttydev, baud, databit, stopbit, parity, handshake);

	if (dev->fd < 0)
		return -1;

	dev->baud = baud;	
	dev->databit = databit;
	dev->stopbit = stopbit;
	dev->parity = parity;
	dev->handshake = handshake;

	return 0;
}

void ttydev_close (ST_TTYDEV *dev)
{
	assert (dev);

	if (dev->fd >=0) {
		tty_close (dev->fd);
		dev->fd = -1;
	}
}

int uarttty_open(const char *ttydev, int baud, int databit, int stopbit, int parity, int handshake)
{
	int htty;
	unsigned int uart_ctrl = 0;
	
	htty = open(ttydev, O_RDWR | O_NOCTTY | O_NONBLOCK);					
	if (htty < 0)
		return -1;

	//uart_ctrl = 0x0f016000;	// default
	uart_ctrl = 0x0f016000;		// default

	//if (buad == B2400) {
	if (baud < B9600) {
		uart_ctrl |= BAUD_MODE0(BAUD_BELOW);
		uart_ctrl |= BAUD_MODE1(GET_UART_BAUD(baud));
	} else
		uart_ctrl |= BAUD_MODE0(GET_UART_BAUD(baud));
	uart_ctrl |= STOP_MODE(GET_UART_STOPBIT(stopbit));
	uart_ctrl |= SIZE_MODE(GET_UART_DATABIT(databit));
	uart_ctrl |= PARITY_MODE(GET_UART_PARITY(parity));
	debug("set PTZ (0x%08x) %d, %d, %d, %d, %d\n", uart_ctrl, baud, databit, stopbit, parity, handshake);
	ioctl(htty, UART_IOCTL_SET, &uart_ctrl);

	return htty;
}

void uarttty_close(int htty)
{
	if (htty < 0)
		return;

	close(htty);
}

int uartttydev_open(ST_TTYDEV *dev, const char *ttydev, int baud, int databit, int stopbit, int parity, int handshake)
{
	assert (dev);
	assert (ttydev);
	dev->fd = uarttty_open(ttydev, baud, databit, stopbit, parity, handshake);

	if (dev->fd < 0)
		return -1;

	dev->baud = baud;	
	dev->databit = databit;
	dev->stopbit = stopbit;
	dev->parity = parity;
	dev->handshake = handshake;

	return 0;
}

void uartttydev_close (ST_TTYDEV *dev)
{
	assert (dev);

	if (dev->fd >=0) {
		close (dev->fd);
		dev->fd = -1;
	}
}

int uartttydev_read(int uTTY, char* buf, int size)
{
	int left = size, retry = 4,  tot = 0;
	int res = -1;

wait:	
	res = read(uTTY, buf + tot, left);

	if (res > 0) {
		left -= res;
		tot += res;
	}

	if ((left > 0)  && (retry-- > 0))
		goto wait;

	if (0 == tot)
		;//debugv ("tty read timeout or error!\n");
	else if (size != tot) {
		//debugv ("Warning!! Failed to read uarttty requested size! (reqsz=%d readsz=%d)\n", size, tot);
	}

	return tot;	
}

/***************************************************************************************
 * Reading & writing serial device.
 ***************************************************************************************/
int tty_read (int hTTY, char * buf, int size)
{	
	struct timeval tv;
	fd_set rdset;	

	int left = size, tot = 0;
	int res = -1;

	FD_ZERO (& rdset);
	FD_SET (hTTY, & rdset);
	tv.tv_sec = 0;
	tv.tv_usec = DEFAULT_PORT_TIMEOUT_USEC;

	// Wait for data until timeout expires.	
	switch (select (hTTY + 1, & rdset, NULL, NULL, & tv)) {
	case -1: // select error.
		break;

	case 0:	 // time out.
		break;

	default: // There is some data to read. 
		if (! FD_ISSET (hTTY, & rdset))		
			break;

		res = read (hTTY, buf + tot, left);

		if (res <= 0)
		 	break;

		left -= res;
		tot += res;
		break;
	}

	if (0 == tot)
		;//debugv ("tty read timeout or error!\n");
	else if (size != tot) {
		//debugv ("Warning!! Failed to read tty requested size! (reqsz=%d readsz=%d)\n", size, tot);
	}

	return tot;	
}

int tty_write (int hTTY, char * buff, int size)
{
	int res;
	res = write (hTTY, buff, size);

	if (res < 0) {
		perror ("write");
		debugv ("Failed to write MCU serial.\n");
		return -1;
	}

	tcdrain (hTTY);

	if (res != size)
		debugv ("Warning!! Failed to write tty requested size! (reqsz=%d readsz=%d)\n", size, res);

	return res;
}

int main (void)
{
	return 0;
}
