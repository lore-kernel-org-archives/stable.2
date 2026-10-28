Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180231;
	b=EDhHUm5huKdw/Crmmxf1/UseaMCOa8u4+e7bILkBNUMOb2L15oVaOWTrq9jsrj81OU28
	 V2u04RcEPjcHTF4N7O988Ag50OEqF1D80QHfMr/nx6sb+9+3LwM4uajYDzb1lY9PpMbsM
	 0o9WD1IWFoGvfOR5ab90tRt1u5qSuOLBnh2uI3bLeBZ5vz0UCxKZbUb8SvU3hlNZijeNr
	 Uhz/Q9rKs3d4p4tisldjZGHaNUruBBRSTpVricCfvPCqWzIM8/g46jgonC8MWJjnrFVmj
	 NMlDDqkOdvS4rsC+sE1TAPMykL3b5ZdkEO0u44VAqxSs4Ar9R4/cCtYaZrs91me5gbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180231;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hkt3J7o6BQgO40vmJfQcUjJjdHsbv2iE23eksw80Rug=;
	b=Ditz8HRQLnd22HBrHCC3NUhcfO6RAvO0cfNF8+OffaAN0JB2VOeqcaxbCfpfqCApm208
	 qekuFBhF9Z2LCh7eBwaPZb5cB9Bj/3jNnN6LhS7ezyfqJDkDsDclrr/DiLp8UpOmGMrgv
	 kPGsD6AU0FG8kJ02BnKVbNKfPZ+eA90wn+UooPCwDOW79iyHpXOM+v2eqtitehShtqI3G
	 w4TI0CgZcbRg2DSozGRZuN0WqXuQ8+XvLyDY030aeLIBmSBnnMBkePqnYijRVdDq/hX7E
	 MyF3shlrVaTIl8tIMRck3hRXCkk519EThPwY5x3oGnmpRXSuX8GELY+gCTicbTTyDtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWzv57eo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD5606A327;
	Wed, 28 Oct 2026 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWzv57eo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A121F031E3;
	Wed, 28 Oct 2026 09:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793180231;
	bh=hkt3J7o6BQgO40vmJfQcUjJjdHsbv2iE23eksw80Rug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gWzv57eoVREIE6uyRZgZdIiciEl7WLnQhOONFi+w9KDK3Uw2DwGDKIqmwozZ5u164
	 G2OU1cFTYutESW96OZgJMn/OT8s1QMfi015khHuFvNahrjuFJVsgyX7HcUtZBUXkVa
	 SJQPChGv6ukztUUTlkXWIm6FiS7k2Hez40MBg7Ml7wFjlWw6vtgUdjXfWG6DFr40Iw
	 O3xCIvQevAQOTO6mVEmTBaSNyNltMjtPzq4bQZtTsR6g7NcupBtxzAm0AsCcxDOTDh
	 9kyF6FOzzK4pXsZF3pjixNiFjUS0gXRzfl0mUwtxnUGx9ukcHRtM/XHGFL4/hhU/Pq
	 hp3koq66nDdhw==
Date: Wed, 28 Oct 2026 09:37:05 +0000
From: Lee Jones <lee@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org,
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mfd: twl6040: fix IRQ action memory leaks during teardown
Message-ID: <20261028093705.GK2195460@google.com>
References: <20261027032609.119226-1-lgs201920130244@gmail.com>
 <179310015976.2808517.13064510476219400398@kernel.org>
 <CANUHTR8Ypwpm+Qqmk-fob1=e040rRH5QGTs7gN6MWRKQYyOdCw@mail.gmail.com>
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
In-Reply-To: <CANUHTR8Ypwpm+Qqmk-fob1=e040rRH5QGTs7gN6MWRKQYyOdCw@mail.gmail.com>

On Wed, 28 Oct 2026, Guangshuo Li wrote:

> Hi Lee,
> 
> On Wed, 28 Oct 2026 at 00:26, Lee Jones <lee@kernel.org> wrote:
> >
> > On Tue, 27 Oct 2026, Guangshuo Li wrote:
> >
> > > twl6040_remove() currently removes the regmap IRQ chip before
> > > removing the MFD child devices. This destroys the IRQ mappings
> > > before the child drivers can release their interrupt handlers.
> > >
> > > The parent driver also registers READY and thermal interrupt
> > > handlers using devm_request_threaded_irq(). These handlers are
> > > normally released by device-managed cleanup after remove returns,
> > > when the corresponding IRQ descriptors have already been removed.
> > >
> > > Consequently, free_irq() cannot find the IRQ descriptors and the
> > > allocated struct irqaction objects are not freed. The associated
> > > IRQ threads also cannot be stopped through the normal cleanup path.
> > >
> > > The probe error paths have a similar issue, as they destroy the IRQ
> > > chip before the device-managed IRQ handlers are released.
> > >
> > > Remove the MFD child devices first, then explicitly free the
> > > parent's READY and thermal IRQ handlers using devm_free_irq()
> > > before removing the regmap IRQ chip.
> > >
> > > Also update the probe error paths to release successfully requested
> > > IRQs before destroying their mappings.
> > >
> > > This issue was found by our static analysis tool under development.
> > >
> > > Fixes: ab7edb149c75 ("mfd: twl6040: Convert to use regmap_irq")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > > ---
> > >  drivers/mfd/twl6040.c | 13 +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> > > index 562a0f939f6e..7b05d21cd17d 100644
> > > --- a/drivers/mfd/twl6040.c
> > > +++ b/drivers/mfd/twl6040.c
> > > @@ -745,7 +745,7 @@ static int twl6040_probe(struct i2c_client *client)
> > >                                       "twl6040_irq_th", twl6040);
> > >       if (ret) {
> > >               dev_err(twl6040->dev, "Thermal IRQ request failed: %d\n", ret);
> > > -             goto readyirq_err;
> > > +             goto thirq_err;
> > >       }
> > >
> > >       /*
> > > @@ -791,10 +791,14 @@ static int twl6040_probe(struct i2c_client *client)
> > >       ret = mfd_add_devices(&client->dev, -1, twl6040->cells, children,
> > >                             NULL, 0, NULL);
> > >       if (ret)
> > > -             goto readyirq_err;
> > > +             goto mfd_err;
> > >
> > >       return 0;
> > >
> > > +mfd_err:
> > > +     devm_free_irq(twl6040->dev, twl6040->irq_th, twl6040);
> > > +thirq_err:
> > > +     devm_free_irq(twl6040->dev, twl6040->irq_ready, twl6040);
> > >  readyirq_err:
> > >       regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
> > >  gpio_err:
> > > @@ -809,9 +813,10 @@ static void twl6040_remove(struct i2c_client *client)
> > >       if (twl6040->power_count)
> > >               twl6040_power(twl6040, 0);
> > >
> > > -     regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
> > > -
> > >       mfd_remove_devices(&client->dev);
> > > +     devm_free_irq(twl6040->dev, twl6040->irq_th, twl6040);
> > > +     devm_free_irq(twl6040->dev, twl6040->irq_ready, twl6040);
> > > +     regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
> >
> > Why not use more devm_*() handlers?
> >
> > devm_regmap_add_irq_chip()
> >
> > devm_free* eeks me out.  The point of devm_*() is that it's managed.
> >
> > >       regulator_bulk_disable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
> > >  }
> > > --
> > > 2.43.0
> > >
> >
> > --
> > Lee Jones
> 
> Thanks for your suggestion. I'll look into using devm_*() APIs in v2.
> 
> Would you prefer that I submit the twl6040 and hi655x-pmic fixes as a
> single patch series in v2, or separately?

I'm not overly concerned.

-- 
Lee Jones
