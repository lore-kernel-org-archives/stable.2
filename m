Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795301480;
	b=H9TJkHDl2mc/g2UEaTnO0tACbOOkspw2yC2Np4ho2FiMmmcgeSNpFHVtHRuwbmTAwAtM
	 ddfe6rgf+WlrBn9tifWt+BLtnLOWyEe1nms2Zuz2PflZML8n1Oc7N3uOEk6xvRAdu/ikg
	 bu7OzuUCZx8GTUdRxSyNckeoBl2+T5RNYJE7Ftdl+9nRlbKOn5Bqtbsdy2hoJKbEJVZtd
	 paJlggC1zaA1WOIetCaX9SeB0upmLa67jSmfNJvcWsA2iKabTXLHtmVUV6FPemOxlNlio
	 wjHvm0sivOJhCoErLdHM0UNxdepjgEATFO7LdN4TVbBhdHw1oevzbcvJA4HalW1tZqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301480;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=M7DMWBB94yLZqEaPSWigGMEGI/4GG3JhAn9LfYKnXPE=;
	b=MBsioISdMFG2YmRDTN9AAORlbSylRO5L+1723NrnYvSmtMchEc/HYYxQU/2fCY0UbY9N
	 ZmO1A/WNuRa2mmNZhz9M1jWbqbVcZ9RFOgZ27vd6LQUpHUHeQc7kAzqjWgzb0QeInum69
	 OVSo97uFtIeebrSjgprOeE9vy/jGtzvWb5WaHpm35mv4QNNCJR+T4DQ4pG0lPEhq7CdSy
	 hixuZYrP5TA2aZWh8oByYo0dKPNRC+VEAPW3BHwnM8vSQEi6jtRDrKyZ/oxg2AlGCd6PA
	 SHvZwqhelmnJirTm8rAPQN0j7oK3mmnsZtJ2hGx3RGlCV5oTfEIOl8FpuUoxRDO7s/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+fJSMXm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA86606A331;
	Sat, 21 Nov 2026 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+fJSMXm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B1E1F000CA;
	Sat, 21 Nov 2026 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301480;
	bh=M7DMWBB94yLZqEaPSWigGMEGI/4GG3JhAn9LfYKnXPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b+fJSMXmBh79PHQmv8iixzQ57TVwBz1eAqyUajITE23tX6XJO9bYLoFobVPEu8Bnb
	 dvJBNK89U/PpIHOPCoyYDT1qx+0qdmKaiQB4zqoXMiN/6Hq9CXcJsqPEXLLZyBqIm3
	 TScpqY23WT04z3kejVElUuzqV1pxh5JIbhhbr6X00CSjeNPSvUgfHlNRTFAARt1j+9
	 5AvmrtAHKamEFYySoyLnGgqeh5BuqQIRNjYDMSHgFrUUC51hwYMcfgwQrY+xS2o9pU
	 s5UjYkerquQjbAbkm19TtwugK+kvMtNLPIcQtSVB3kfSv49DVcO7b3wBVWqJhHJPnd
	 4zzX1xABklZ5w==
Date: Sat, 21 Nov 2026 22:51:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Lee Jones <lee@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, <linux-iio@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 05/10] iio: adc: stm32-adc: Detach chained IRQ handler
 before removing domain
Message-ID: <20261121225114.41f87da3@jic23-hlaptop>
In-Reply-To: <a449f513-5d7f-4478-a389-9c47dd0ecddd@foss.st.com>
References: <20261119153151.1397003-1-lee@kernel.org>
	<20261119153151.1397003-6-lee@kernel.org>
	<a449f513-5d7f-4478-a389-9c47dd0ecddd@foss.st.com>
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

On Fri, 20 Nov 2026 18:23:19 +0100
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 11/19/26 16:30, Lee Jones wrote:
> > stm32_adc_irq_remove() disposes of the child IRQ mappings and removes
> > priv->domain before clearing the parent chained IRQ handlers.  Because
> > the parent hardware interrupt lines remain unmasked while child devices
> > use dummy_irq_chip, an interrupt arriving during teardown invokes
> > stm32_adc_irq_handler() after irq_domain_remove() has freed
> > priv->domain, and irq_set_chained_handler() also leaves handler_data
> > dangling.
> > 
> > Detach the chained handlers and clear handler_data with
> > irq_set_chained_handler_and_data() before tearing down the mappings and
> > removing the domain.
> > 
> > Fixes: 1add69880240 ("iio: adc: Add support for STM32 ADC core")
> > Closes: https://sashiko.dev/#/bug/linux-27c38690-bc20-43aa-a3fc-1ddd6f1bb74e
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---  
> 
> Hi Lee,
> 
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
This one seems a little more likely to be hit in practice, but
it doesn't apply to the fixes tree due to some other recent changes and
I'm lazy.

Hence applied to the testing branch of iio.git to line it up for next
merge cycle. We are getting late enough I should be keeping fixes to critical
stuff only and I'm going to assume this one isn't.

Jonathan

> Best Regards,
> Thanks,
> Fabrice
> 
> >  drivers/iio/adc/stm32-adc-core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> > index 4b532db3db62..13b75475046c 100644
> > --- a/drivers/iio/adc/stm32-adc-core.c
> > +++ b/drivers/iio/adc/stm32-adc-core.c
> > @@ -467,12 +467,12 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
> >  	int hwirq;
> >  	unsigned int i;
> >  
> > +	for (i = 0; i < priv->nb_irqs; i++)
> > +		irq_set_chained_handler_and_data(priv->irq[i], NULL, NULL);
> > +
> >  	for (hwirq = 0; hwirq < priv->nb_adc_max; hwirq++)
> >  		irq_dispose_mapping(irq_find_mapping(priv->domain, hwirq));
> >  	irq_domain_remove(priv->domain);
> > -
> > -	for (i = 0; i < priv->nb_irqs; i++)
> > -		irq_set_chained_handler(priv->irq[i], NULL);
> >  }
> >  
> >  static int stm32_adc_core_switches_supply_en(struct stm32_adc_priv *priv,  
> 
> 

