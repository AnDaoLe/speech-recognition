/*****************************************************************************/
/*                                                                           */
/* FILENAME                                                                  */
/* 	 main.c                                                                  */
/*                                                                           */
/* DESCRIPTION                                                               */
/*   TMS320C5505 USB Stick. Application 2. Improved Audio Template.          */
/*   Take microphone input and send to headphones.                           */
/*                                                                           */
/* REVISION                                                                  */
/*   Revision: 1.00	                                                         */
/*   Author  : Richard Sikora                                                */
/*---------------------------------------------------------------------------*/
/*                                                                           */
/* HISTORY                                                                   */
/*   Revision: 1.00                                                          */
/*   5th March 2010. Created by Richard Sikora from TMS320C5510 DSK code.    */
/*                                                                           */
/*****************************************************************************/
/*
 * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/ 
 * 
 * 
 *  Redistribution and use in source and binary forms, with or without 
 *  modification, are permitted provided that the following conditions 
 *  are met:
 *
 *    Redistributions of source code must retain the above copyright 
 *    notice, this list of conditions and the following disclaimer.
 *
 *    Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the 
 *    documentation and/or other materials provided with the   
 *    distribution.
 *
 *    Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
 *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
 *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
 *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
*/

#include "stdio.h"
#include "usbstk5505.h"
#include "sndfile.h"
#include "stdlib.h"
#include "math.h"
#include "dsplib.h"
#pragma	DATA_SECTION( outBuffer , "expdata0");
#pragma	DATA_SECTION( inBuffer , "expdata1");
#define DATALENGTH   4800
short inBuffer[DATALENGTH];
short outBuffer[DATALENGTH];

void *bufferH[31];
void *bufferL[51];
int coef = 0;
int a =0, k= 0, j=0, i=0;

Int16 S[103];
Int16 A[103];
Int16 B[103];
Int16 C[103]; //7ffff
Int16 L[103];
Int16 Temp[103];
const int BL = 103;
Int16 BHigh[31] = {
	      416,    267,    298,    279,    195,     33,   -215,   -545,   -945,
	    -1393,  -1860,  -2312,  -2712,  -3025,  -3225,  29474,  -3225,  -3025,
	    -2712,  -2312,  -1860,  -1393,   -945,   -545,   -215,     33,    195,
	      279,    298,    267,    416
	};



Int16 BLow[51] = {
           -60,        -178,        -163,         240,         895,        1137,
           502,        -430,        -504,         400,         909,          23,
         -1108,        -584,        1143,        1360,        -806,       -2244,
           -68,        3132,        1793,       -3891,       -5394,        4403,
         20317,       28184,       20317,        4403,       -5394,       -3891,
          1793,        3132,         -68,       -2244,        -806,        1360,
          1143,        -584,       -1108,          23,         909,         400,
          -504,        -430,         502,        1137,         895,         240,
          -163,        -178,         -60
};

Int16 Sample[103] = {
     -564,    336,    250,    184,    133,     92,     56,     24,     -7,
      -36,    -65,    -92,   -117,   -139,   -156,   -168,   -171,   -167,
     -153,   -129,    -95,    -52,     -1,     57,    118,    182,    243,
      300,    348,    384,    404,    405,    385,    342,    273,    179,
       60,    -83,   -247,   -429,   -626,   -833,  -1044,  -1253,  -1456,
    -1646,  -1818,  -1966,  -2086,  -2174,  -2229,  30521,  -2229,  -2174,
    -2086,  -1966,  -1818,  -1646,  -1456,  -1253,  -1044,   -833,   -626,
     -429,   -247,    -83,     60,    179,    273,    342,    385,    405,
      404,    384,    348,    300,    243,    182,    118,     57,     -1,
      -52,    -95,   -129,   -153,   -167,   -171,   -168,   -156,   -139,
     -117,    -92,    -65,    -36,     -7,     24,     56,     92,    133,
      184,    250,    336,   -564
};
Int16 GAIN_IN_dB = 5;
Uint32 SAMPLES_PER_SECOND =24000L;


/* New. Variable for step */
unsigned int Step = 0; 

void queueH(void *value){
	bufferH[coef]= value;
	coef++;
	if (coef == 31) {
		coef = 0;
	}
}

void queueL(void *value){
	bufferL[coef]= &value;
	coef++;
	if (coef == 51){
		coef = 0;
	}
}

void readwav(){	SNDFILE *sf;
	SF_INFO info;
	unsigned short num_channels;
	unsigned short num, num_items;
	int *buf;
	Uint32 f,sr,c;
	int i,j;
	FILE *out;

	/* Open the WAV file. */
	info.format = 0;
	sf = sf_open("sample.wav",SFM_READ,&info);
	if (sf == NULL)
		{
		printf("Failed to open the file.\n");
		exit(-1);
		}
	/* Print some of the info, and figure out how much data to read. */
	f = info.frames;
	sr = info.samplerate;
	c = info.channels;
	num_items = f*c;
	printf("num_items=%d\n",num_items);
	/* Allocate space for the data to be read, then read it. */
	buf = (int *) malloc(num_items*sizeof(int));
	num = sf_read_int(sf,buf,num_items);
	sf_close(sf);
	printf("Read %d items\n",num);
	/* Write the data to filedata.out. */
	//convert float to q
	float out[]= {0};
	Int16 qout[]= {0};
		for (i = 0; i < num; i += c)
			{
			for (j = 0; j < c; ++j)
				out[i+j]=buf[i+j];
			}

	fltoq(out,qout,128);
}


void filterwav(Temp){
	for (a=0;a<len(Temp);a++)
	{
		//high pass filter
		Temp[i]= BHigh[i]*inBuffer[j];
		//Temp[i]=Temp[i]<<15;
		C[k]=C[k]+Temp[i];
		i--;
		if (C[k] > 32766) C[k]=C[k]/32766;
		if (i==0){
			queueH(&C[k]);
			k++;
			j++;
			i=102;
			C[k]=0;
		}

	}
//here we put input with a Low Pass
	for (a=0;a<4799;a++)
	{
		outBuffer[k]=outBuffer[k]+BLow[i]*C[j];
		i++;

		if (i==51){
			queueL(outBuffer);
			k++;
			j++;
			i=0;
		}
	}
}

/*
void entropy_cut(Uint32 datum){
}
*/
void MFCC(out){
//convert input from sd card to q15, frequency transform
	for (i=0; i < len(qout); i=i++){
			out[i]=pow(2595,10)*log(1+out[i]/700);
		}
	for (i=0; i < len(qout); (i=i+128)){
		rfft32(out, 128, NOSCALE);
	}
	for (i=0; i < len(qout); i++){
		out[i] = out[i]*out[i];
	}

	for (i=0; i<len(qout); i++){
		out[i] = log(out[i]);
	}
	for (i=0; i < len(qout); (i=i+128)){
		ifft32(out, 128, NOSCALE);
	}
}

void NN(out){
//test function
		long output;
		short weight1[]={0}, weight1_2=0.3, layer[]={0}, layer[]={0};
	out= 1.0/(1.0+exp(-out));
	output1 = weight1[0];
	for (i=1; i<= 3; i++){ //3 is the length of the output
	layer = layer + ouput[i]*weight1[i];
	}
	//need to repeat  for all layers and outputs

	//need to add weight model to minimize error (gradient descent)

}
/* ------------------------------------------------------------------------ *
 *                                                                          *
 *  main( )                                                                 *
 *                                                                          *
 * ------------------------------------------------------------------------ */
void main( void ) 
{

readwav();
filterwav(Temp);
//entropy_cut(out);
MFCC(out);
//NN(out);
//Will just input all functions in that order to avoid using pointers

return 0;
}

/* ------------------------------------------------------------------------ *
 *                                                                          *
 *  End of main.c                                                           *
 *                                                                          *
 * ------------------------------------------------------------------------ */
//NEED TO TEST FOR individual parts
