Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793119247;
	b=iiMFXxsxUVhRPGtLAX08aA82NFWa24MWPulV7/1EROk6GBhg+VZaExFCu3bgx+emHqBI
	 0ol3d65xXlI0uIFPeMP1Mr5WaMn+xsrGBcyO+nqnfIn9w2T3Amam2xu76xZwDznB8Gqxn
	 qnByKTyWJISjO7nQOrqZqli8tDHNSzpb4zIKj5q6xHtm6I28C7u/9TFutyaARvhOJn2oN
	 HP8/lkqxj2Jn/W09ZX2dBf6znyolExlDq79qNLVdnV04SGZFy50s3n/PCHLXDxocRTmsy
	 lWKv6TucIqPzi0Ws5K/ztLYV8IzZvjzraU8we8lEDM9RotB6KjCxUx2c0lB+SBiotGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=G64J3My5E4LHAZytVY99BN0a3iynkD/Y4fMqy8a7CDc=;
	b=j7CYIu4n32UHK0k2leER2HQbUvHMG430fi1rHkiqL1bzIEd9/7ZF8Q9YkO5Suc9IIYDb
	 ntRLGvq68BKelKxtH0+fEMO1RLk7zu9ASynu8kCZkrpY9KRqI/JyRvquabwmmvaWV17M0
	 +R1w4VJQ4ftA/iVWgyQ56RoTsGPijHRVXEHPhnYdaJUjEDOqdyjoEReIc4DkCFvCHlfF7
	 WsxV3gXAWaMafTNZ5hSqWiQQ8cweVHKUeiosw0wTpX4l07w505pwyKCmmqUbDhsu5CJlw
	 80UbV1GfFdlxcB+gM5mS86t6O4kkQFF1n2/HKkUex7NI64qIelxDMEMVE2X1FrX3idA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ihnwKcxC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AC5606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4AC5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ihnwKcxC
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-677bc4704cbso79024d50.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793119246; cv=none;
        d=google.com; s=arc-20260327;
        b=fiuAwP5GfAs5CSs8y9J/Y1nOuIdQopzoIHl/oUc68e0yVOqzWa8fhBsSkdTDPkpWE0
         WPnXEO/0q74rYbuKQvjWlFlBa7vXvdPpbSnO7JjbjnU52zMFltFOBR+bi37t8PPVy15X
         41S43CK6b44j7OmQZo9LRyczTPk+cf/SCgl1yObg4qGUfEj2Z9iootm9ELiF9DcRL4iY
         D8nqV3r4wAHVw4ClOrmTZRacH/friRlpaCd46n0VJ/vr95g4DeiM+rfpcYbSq1H09ER6
         7wKnA59PjYb3tM0tmdZUIanmRpqb5VbdArcXsCQiTTNW+D7wXQF+rph7VUHU8k2sg/s/
         dEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G64J3My5E4LHAZytVY99BN0a3iynkD/Y4fMqy8a7CDc=;
        fh=FxNiIE8Sk8/4S/PhYjfmxHeTm9uJrytMH3Ii2bgO8GQ=;
        b=OI4Kinb6h7dbJFP1X4IRLS0SASH3pmeqZSOYFaTwPVuTn1FoxkCRebdHxf0iR+1y1G
         rKMh71HyfpUz19pqvgQFvMoFdpFQi38Dlp0abvyIi4EugErQLLj7tsS8+eQqhsIhkE7Q
         zY3shmgKlHZArzxFLCeMlzS9pI9ZQEjkAiu3RJs/jOoRWrXbSoFlGLlcGKRdnSSrGy8i
         CAswe9KNMPoCorw2n6CLfyd0l+MCXdmW9GnM+AqaEW8fx+yoAnjsOgP1IudQUKdp220j
         sCWO018gaV+7/GZ9ZtzR55rT3b7Weu6R+d7tQtzOOAEj9D6rxZOnGbFi4hNOendMIOl7
         avgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119246; x=1793724046; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G64J3My5E4LHAZytVY99BN0a3iynkD/Y4fMqy8a7CDc=;
        b=ihnwKcxCTJLEgMsjfIVumhb6S0IfEmdzQwZEYEoTXBg7l0yUs2viibcjKq+iTQidF7
         O8BcOsQKRMPh7AN3jfl0F2oF53nmB+3HME49sCtOa+NCR0k5I/pOikZg5PMEAHF1m5MB
         DsCDOtERRjqVO7qZcevvzlSuJm/9UMMioLJ0KaULaLQz73rO6imX9JcHOV9Kl6pzy2RA
         vwgi5QTkqwNg+tR1HhAf3J5jZH4PXC0cjj9FxDdmzqllqgoik6ahJ+uvCoP+kNlazJwQ
         43GMbCFUXNmWl7PDNmflZTBVJ0V0UCzZnEa7ewGeG8IsKFI4VvRs3TA3PDS38FpaVmBp
         Cf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119246; x=1793724046;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G64J3My5E4LHAZytVY99BN0a3iynkD/Y4fMqy8a7CDc=;
        b=mhcAIf2reO/TsKwCdAw/zZv8FRZ2Qcg1T+18IOHhWcVcaxRoAfRpBIcS7OKcbPRhzG
         69yftQDWymRRe5Vro9dNB7WDSCdDImKAnYfzXZwCC7j34BDUjon0HHsnAc/CQPUXVS0I
         hAnQPsPKu7bfxAzHdWwlWwkC6MqXff+SwNNgFRdCqlzfwOKfbE4in8VeCDT6vzAEQ2aG
         fNjr/BbcniexoFBwFS56Zplt2gxJbRhetGeD41f0hKRdqJSAnpPQAH6amvgzDxB9jYqu
         lFfP5WThN9GfuqH58mlJRKa13/OlnumCo5TWOMCgw+mjUZ/3AT9kW/fHLiMUszGn+gNG
         bstw==
X-Forwarded-Encrypted: i=1; AKwUvBz31cBwfdEdU6mUa/fyqSGs3BoI+PqYT86epBXG/mXirjfoj5aB05wkXy6Yhz1nF25HdVBfkH0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUl6WJ9HJ61uo9E0hTXnkwjRDN85TKP2GMsoJerbnfpPvelhi8
	T5P0RTdjX8HlbyvT1PqoDF7jPAOqcgN0TeEA313rHXIV4bLw24W1zEJv0AjeAPFYnXb9tqIlFvI
	ew5FjjrT/LZRGqmNy291SN8cChka24do=
X-Gm-Gg: AYBFou0j4WacP2huGQpkVvUiuSLoAGz/s6shJJV2K2M/rsXBeTYP2ZMpH2VC0GK4Nfr
	yF+a9ATBRv/WbYkDuWkFO4SGQGLySbhBup4XudwN1ErimUTACKvls4f6FlMrb0vANP554pt/QUb
	a0AtPQRPM6tAkfdT1kZKLCau7o9jhWAwHQybkmNBCe7GE6LhyrMZTOk/MZs9emVoMLNPxt3vLtH
	KbXoCf7FRpaM9x1gTYe4UrNhMwwkHMKjN330V8EumWvpBr5IBLdRpahDr266Z9FM6e5CR67oqJB
	t8bThQG4IMmRKnjLmELf4lhK0bGU78R7aSb6zz6Yl3EboVqcNEZ53hh+I75PKFYFrZFy/74NULn
	7XUIXoC0pdn42gwSrRe7Pg7ZHpcTYsupBL2pP
X-Received: by 2002:a05:690e:21c9:b0:678:151:5218 with SMTP id
 956f58d0204a3-67a7bd81c3cmr32130d50.110.1793119245748; Tue, 27 Oct 2026
 09:40:45 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027032609.119226-1-lgs201920130244@gmail.com> <179310015976.2808517.13064510476219400398@kernel.org>
In-Reply-To: <179310015976.2808517.13064510476219400398@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 28 Oct 2026 00:40:33 +0800
X-Gm-Features: AclHuK8AK6dZaz6wgjS33W_jF3KCjGoJH6NgyB5biX1dQWpffjnyXhNOXiRNnyU
Message-ID: <CANUHTR8Ypwpm+Qqmk-fob1=e040rRH5QGTs7gN6MWRKQYyOdCw@mail.gmail.com>
Subject: Re: [PATCH] mfd: twl6040: fix IRQ action memory leaks during teardown
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, 
	Samuel Ortiz <sameo@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
	linux-omap@vger.kernel.org, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lee,

On Wed, 28 Oct 2026 at 00:26, Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 27 Oct 2026, Guangshuo Li wrote:
>
> > twl6040_remove() currently removes the regmap IRQ chip before
> > removing the MFD child devices. This destroys the IRQ mappings
> > before the child drivers can release their interrupt handlers.
> >
> > The parent driver also registers READY and thermal interrupt
> > handlers using devm_request_threaded_irq(). These handlers are
> > normally released by device-managed cleanup after remove returns,
> > when the corresponding IRQ descriptors have already been removed.
> >
> > Consequently, free_irq() cannot find the IRQ descriptors and the
> > allocated struct irqaction objects are not freed. The associated
> > IRQ threads also cannot be stopped through the normal cleanup path.
> >
> > The probe error paths have a similar issue, as they destroy the IRQ
> > chip before the device-managed IRQ handlers are released.
> >
> > Remove the MFD child devices first, then explicitly free the
> > parent's READY and thermal IRQ handlers using devm_free_irq()
> > before removing the regmap IRQ chip.
> >
> > Also update the probe error paths to release successfully requested
> > IRQs before destroying their mappings.
> >
> > This issue was found by our static analysis tool under development.
> >
> > Fixes: ab7edb149c75 ("mfd: twl6040: Convert to use regmap_irq")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/mfd/twl6040.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> > index 562a0f939f6e..7b05d21cd17d 100644
> > --- a/drivers/mfd/twl6040.c
> > +++ b/drivers/mfd/twl6040.c
> > @@ -745,7 +745,7 @@ static int twl6040_probe(struct i2c_client *client)
> >                                       "twl6040_irq_th", twl6040);
> >       if (ret) {
> >               dev_err(twl6040->dev, "Thermal IRQ request failed: %d\n", ret);
> > -             goto readyirq_err;
> > +             goto thirq_err;
> >       }
> >
> >       /*
> > @@ -791,10 +791,14 @@ static int twl6040_probe(struct i2c_client *client)
> >       ret = mfd_add_devices(&client->dev, -1, twl6040->cells, children,
> >                             NULL, 0, NULL);
> >       if (ret)
> > -             goto readyirq_err;
> > +             goto mfd_err;
> >
> >       return 0;
> >
> > +mfd_err:
> > +     devm_free_irq(twl6040->dev, twl6040->irq_th, twl6040);
> > +thirq_err:
> > +     devm_free_irq(twl6040->dev, twl6040->irq_ready, twl6040);
> >  readyirq_err:
> >       regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
> >  gpio_err:
> > @@ -809,9 +813,10 @@ static void twl6040_remove(struct i2c_client *client)
> >       if (twl6040->power_count)
> >               twl6040_power(twl6040, 0);
> >
> > -     regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
> > -
> >       mfd_remove_devices(&client->dev);
> > +     devm_free_irq(twl6040->dev, twl6040->irq_th, twl6040);
> > +     devm_free_irq(twl6040->dev, twl6040->irq_ready, twl6040);
> > +     regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
>
> Why not use more devm_*() handlers?
>
> devm_regmap_add_irq_chip()
>
> devm_free* eeks me out.  The point of devm_*() is that it's managed.
>
> >       regulator_bulk_disable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
> >  }
> > --
> > 2.43.0
> >
>
> --
> Lee Jones

Thanks for your suggestion. I'll look into using devm_*() APIs in v2.

Would you prefer that I submit the twl6040 and hi655x-pmic fixes as a
single patch series in v2, or separately?

Best regards,
Guangshuo Li
