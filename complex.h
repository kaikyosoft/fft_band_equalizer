
#ifndef COMPLEX_H_
#define COMPLEX_H_

/*
 *	Structure represents complex number
 */
typedef struct {
	double re;		// real part of this number
	double im;		// imaginary part of this number
} COMPLEX;

/*
 *	Structure represents array of complex numbers
 *		aka one input sample
 */
typedef struct {
	COMPLEX *c;				// array of complex numbers
	unsigned int len;	// length of this array of complex numbers (*c)
	unsigned int max;	// allocated length of the array (*c)
} C_ARRAY;

/*
 *	Structure represents array of samples
 */
typedef struct {
	C_ARRAY **carrs;	// array of samples
	unsigned int len;	// length of this samples array (**carrs)
	unsigned int max;	// allocated length of the array (**carrs)
} C_ARRS;


extern COMPLEX complexAdd(COMPLEX c1, COMPLEX c2);
extern COMPLEX complexSub(COMPLEX c1, COMPLEX c2);
extern COMPLEX complexMult(COMPLEX c1, COMPLEX c2);
extern COMPLEX polarToComplex(double r, double fi);

extern double getRe(COMPLEX comp);
extern double getIm(COMPLEX comp);
extern double magnitude(COMPLEX comp);
extern double phase(COMPLEX comp);
extern double decibel(COMPLEX comp);

extern void formatComplex(COMPLEX c, char *str);
extern void conjugate(C_ARRAY *ca);

extern void initCA(C_ARRAY *ca, unsigned int len, unsigned int start);
extern C_ARRAY *allocCA(unsigned int len);
extern void reallocCA(C_ARRAY *ca, unsigned int len);
extern void freeCA(C_ARRAY *ca);

extern C_ARRS *initCAS(C_ARRS *cas, unsigned int len);
extern C_ARRS *allocCAS(unsigned int len);
extern void reallocCAS(C_ARRS *cas, unsigned int nlen);
extern void freeCAS(C_ARRS *cas);


#endif