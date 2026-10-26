Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792982771;
	b=m8HqOjJpTEsHmyj2plFCgOSdkZJ5WJ2mvU2DKzO909m+pcg9NA5Nm+/FhKf78+wLoX3k
	 K8pMW6xd71FZN1ScajsHn8TDJQCCSHFC27ijy/l56bd/Uk1TVzT7BvqwZ6i3YzHvWsZUp
	 cVjPc8mQOLLcojKAGnWm1Xi81ik2J9o8xnBR+ajjNs2uAJqJEIcrAmydNSfZo2aomycJx
	 munc/VWPcdpTRNrNygKh8TUcF3+Hbrcc6EA3QV1J6iLLFjfQBZ1060gUb9obuds3xHdDu
	 QRJFnQTDhwiPyeE1Z4eoFmCDWvIrX1BaUG+WTiQLPrcVEgLDvtD7/NrPADYR30qjyMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982771;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GNx9q8xlz4C2pL81nd+DaavacT/yEGpKYKkpo4ND8NU=;
	b=3zr8b9aVGA7aqUJ//s6U2L3+RToAVz6Nkd60K0aL4k5PrHfU/19sPQ6524ke0bmGIioY
	 VRZj33H0cey3dszr9FsQq6vapT3EHW75657KHs5MXbpCEJqdU4ym+BaqkGZBVzUUZcKEX
	 MPN+wrhsYduWvPkLhcGUXL7dkFpxdmMtXeNSjRdhWiDIef1QfWwNalRMnUG1Wrpr3Kv+V
	 IF/yfkBvdoiGQwZi1S5FW6iGD5EhcB7dHvRG0Qz86b1w/o+nuTe+LHOO4UYu1QCZs/Ai9
	 1SZIAIpDcex/jmUywNVyATJUCnnbxqkjzIa5XLYJu1Djv4mDKUFQEEinHo2Mb1KIRRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bERgx/F9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C6606A31A;
	Mon, 26 Oct 2026 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bERgx/F9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0F21F031E2;
	Mon, 26 Oct 2026 02:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792982770;
	bh=GNx9q8xlz4C2pL81nd+DaavacT/yEGpKYKkpo4ND8NU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bERgx/F9ZjkMitNzqoudEWvCaXT/3dbqzKl+ZiXjjftlhGpYvDfv2NBTP4Y5e8Aac
	 T5naUosoU6z7L5JhLOUn5cwD6Xojt86l3MB36mxqAzZxDafUW7VJR7bnO8GXGVsd1T
	 YuLAdE4slSGEOw1ry/io4QzbhEudt28Aa8iwrLMm5SiQt6Iuu2fhYi7H/+V3fv0JJp
	 AyLzhVyGLVxkTrVjHWnCQlXxiIN1VdW1zXOmkc2i1AOjwx9N+AIVhVV10UbRpW0euO
	 k5RsxToIcyTpiusbpp6nw/BJ2hul1yf6nOzDTLyM4UYxHxa7g2Mem1HwEGpiLrNDsN
	 HeTCHU99vn4gQ==
Date: Mon, 26 Oct 2026 02:46:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Eddie James
 <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: wait for a new sample after a
 ratio change
Message-ID: <20261026024605.3286702f@jic23-hlaptop>
In-Reply-To: <atZqSXI14WojGso5@ashevche-desk.local>
References: <20261019153328.80739-1-zoone.rupert@gmail.com>
	<atZqSXI14WojGso5@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 22:06:49 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 19, 2026 at 06:33:28PM +0300, Rupesh Majhi wrote:
> > After an oversampling ratio change, the sample waiting in the result
> > registers and the one being measured are both from the old ratio, but
> > are scaled with the new one. Pressure ratio 2 to 16 reads 192 kPa instead
> > of 103 kPa, and temperature is off by hundreds of degrees. Pressure is
> > also wrong after a temperature ratio change, as it is compensated with
> > the cached temperature.
> > 
> > Discard those two samples on a ratio change, and for temperature cache
> > the one after. The ratio write now blocks until then.
> > 
> > That wait can be longer than the 1/rate timeout, after which the driver
> > resets the chip and the ratio silently goes back to 1. Allow two periods.  
> 
> ...
> 
> >  /* Make sure sleep time is <= 30ms for usleep_range */
> >  #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)  
> 
> Seems the use of USEC_PER_SEC below should be postponed to a regular cleanup.
> Because otherwise it will be inconsistent with the above where it would need
> to be 30 * USEC_PER_MSEC
Do we want to have the extra churn on the below?
I'm not that bothered by a temporary state of different styles.
Nice indeed to have a follow up tidying up other cases though!

There is quite a bit going on around this driver, so I'm going to pick this
one up for the testing branch of iio.git rather than the faster path.

Thanks,

Jonathan

> 
> > -/* Silently handle error in rate value here */
> > -#define DPS310_POLL_TIMEOUT_US(rc)	((rc) <= 0 ? 1000000 : 1000000 / (rc))
> > +/* A period plus a measurement time; silently handle error in rate value */
> > +#define DPS310_POLL_TIMEOUT_US(rc)	(2 * USEC_PER_SEC / max(rc, 1))  
> 

