/**
*Copyright (c) 2000-2001, Jim Crafton
*All rights reserved.
*Redistribution and use in source and binary forms, with or without
*modification, are permitted provided that the following conditions
*are met:
*	Redistributions of source code must retain the above copyright
*	notice, this list of conditions and the following disclaimer.
*
*	Redistributions in binary form must reproduce the above copyright
*	notice, this list of conditions and the following disclaimer in 
*	the documentation and/or other materials provided with the distribution.
*
*THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
*AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
*LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
*A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS
*OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
*EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
*PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
*PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
*LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
*NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
*SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*NB: This software will not save the world.
*/

/* Generated by Together */
#include "FoundationKit.h"
#include <math.h>

using namespace VCF;

VCF::Point::Point( const double & x, const double & y )
{
	init();
	this->m_x = x;
	this->m_y = y;
}

VCF::Point::Point()
{
	init();
}

void VCF::Point::init()
{
	this->m_x = 0.0;
	this->m_y = 0.0;
}

bool VCF::Point::closeTo( const double& x, const double& y, const double& tolerance )
{
	bool result = false;
	result = (::fabs(m_x - x) <= tolerance) && (::fabs(m_y - y) <= tolerance);
	return result;
}

bool VCF::Point::closeTo( const VCF::Point& pt, const double& tolerance )
{
	return this->closeTo( pt.m_x, pt.m_y, tolerance );
}

String VCF::Point::toString() 
{
	char txt[256];
	memset( txt, 0, 256 );
	sprintf( txt, "x: %.3f, y: %.3f", m_x, m_y );
	
	return String( txt );
};