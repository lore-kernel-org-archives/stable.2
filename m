Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383664;
	b=LgGxT9tyqbDCTxpmDtjkNXPu6NB9HhmnTk73hlWX733SQ3lRjpK3QU218EiMlxlgKjCZ
	 I+flbjCYFOYD+oawuH2/LpwjmgWVLpEPdUCrM35Sbz+TuQFV56sfSi5jg9qhONePLm48a
	 QZaRFQ8rQNRW2DYsa+kJxEeOGxOUifqkPlYZH4j1I1fweya3swu9WxrvcSvgirddnwzMt
	 XZ6zYxEy+kYDHDWtXi9wSTUmmE1a/Wt79Jf7xCi/eixlIJI6LF7maYHd9bR8eDXdk8rGn
	 LJaDLWClQuSmjpnO7SBbeaf093Jhhp954CJZmUY9MQ64Ij2yBcrz6wS8R65miK/+GFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383664;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5xeRgjtQ4aBRCLdC1l3UpIvgsBpz7rqdhU/SsbMNbao=;
	b=IsWGvSudRH6BQrFOsRwcUtfh0HGqFuhbpzsptAsYu1aQYNQD6bKlN2zg0+p5e3lML5LN
	 /zLcx7cYyVistesJdYNnU6CWl4x3JDvZ9CzAtDqUF6thSMouORHLVd7TokTOEzttYjBFp
	 ub6dvJ7YUOO9pyadZvOEJ0QBdwoWNvCEGXOi9kYW8oo9VtrtPjBu/usfNaCMNXlg7iEYS
	 ogOOsTyaUEgco8r/F0vE8T0TS4MDvcW3LpKN1Oo1a8938SDeazuX9d8pTYCY69hgihaPY
	 tDWfApzi9YrPOngrl2TJa0LAtjSvlNZqai2ao9vOz9wXxXTLZbudrlQRZ5O9w+Ef6vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oED68b0g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05D1606A320;
	Sun, 22 Nov 2026 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oED68b0g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDD51F008B2;
	Sun, 22 Nov 2026 21:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383662;
	bh=5xeRgjtQ4aBRCLdC1l3UpIvgsBpz7rqdhU/SsbMNbao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oED68b0gYqf4ZoJPJddluGEGEQYM9ixaKIPKBFap6WznGL+ii6fqRqFx3HDsNya2R
	 ShkMBl9+/d77pMRJI7357hvFh3C4Ns4S8NJIBtm1D1aaHL01iyNVO07JAQWO16pm+3
	 g34UvEoJZkqrXmI1u0wvpLUvRHPd0GKFLFWBCa+RLEZWSFK0jBvGTbzX7hEeFgI54y
	 /VdepQxvF+kd3wD+xegGvnJyO76OBXuAP4djsYFcqV3MsTdcTyOd0jNI7CljblX5Up
	 gSnJ3PpymfXihunJfzcJQHAZyywgP5KK3xM/zStkld3zyL27g/mE/TC8uGhDsTyKgW
	 kXt/4C8bVM68g==
Date: Sun, 22 Nov 2026 21:40:57 +0000
From: Lee Jones <lee@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 05/10] iio: adc: stm32-adc: Detach chained IRQ handler
 before removing domain
Message-ID: <20261122214057.GE70182@joneslee-macbookpro.roam.internal>
References: <20261119153151.1397003-1-lee@kernel.org>
 <20261119153151.1397003-6-lee@kernel.org>
 <a449f513-5d7f-4478-a389-9c47dd0ecddd@foss.st.com>
 <20261121225114.41f87da3@jic23-hlaptop>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121225114.41f87da3@jic23-hlaptop>

On Sat, 21 Nov 2026, Jonathan Cameron wrote:

> On Fri, 20 Nov 2026 18:23:19 +0100
> Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:
> 
> > On 11/19/26 16:30, Lee Jones wrote:
> > > stm32_adc_irq_remove() disposes of the child IRQ mappings and removes
> > > priv->domain before clearing the parent chained IRQ handlers.  Because
> > > the parent hardware interrupt lines remain unmasked while child devices
> > > use dummy_irq_chip, an interrupt arriving during teardown invokes
> > > stm32_adc_irq_handler() after irq_domain_remove() has freed
> > > priv->domain, and irq_set_chained_handler() also leaves handler_data
> > > dangling.
> > > 
> > > Detach the chained handlers and clear handler_data with
> > > irq_set_chained_handler_and_data() before tearing down the mappings and
> > > removing the domain.
> > > 
> > > Fixes: 1add69880240 ("iio: adc: Add support for STM32 ADC core")
> > > Closes: https://sashiko.dev/#/bug/linux-27c38690-bc20-43aa-a3fc-1ddd6f1bb74e
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---  
> > 
> > Hi Lee,
> > 
> > Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> This one seems a little more likely to be hit in practice, but
> it doesn't apply to the fixes tree due to some other recent changes and
> I'm lazy.
> 
> Hence applied to the testing branch of iio.git to line it up for next
> merge cycle. We are getting late enough I should be keeping fixes to critical
> stuff only and I'm going to assume this one isn't.

My preference for all of these sets is for them to be applied for -next
rather than -fixes, if it's all the same to you.

And yes, v2s are no issue (replying to your other comments here).

Bear with.

-- 
Lee Jones
