Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09A34752F;
	Sun, 27 Sep 2026 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790543073; cv=none; b=hY4ynlhEyqfvU/v5zaYdTq2Y9Q7qKrooXqkhgfeJ8S3oqubvEXeUSVttJNeytHH7Db1Klvm1wVPkEDVZ23DHCRoTJZsJTYi+kVvX+VNAknXr5EL3IWEg6xS6J5P9cNsJ3Z26P9FNZksoCSJSNSH3iwl8IlLBKbvDDGHHAcr0LxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790543073; c=relaxed/simple;
	bh=ckQPlAnTtGGc3r/q+vRk1OGbd9dYLDD3qRsojFUpn9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FW41A8uMpVVgY/HY8CMwJBwMXUxKQE3UWgd0TkbYLPQV9Hr6TWH3RVhFRUj7yVym1QkggFpvDiCEFaOGlMyV9ZFufedJrvREkA2YUgdXNFsaMAO7C4cj/PA0fvsCsQvxAe9xUMFY0eHuEmRna09IvM8F84iZ6P2qiJT54Kx1wM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhDiLzFQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhDiLzFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89BC1F000FF;
	Sun, 27 Sep 2026 21:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790543072;
	bh=jfDqhPISRULKrUo48D5cmiM75e4HKBRGSaeEuhMiqWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MhDiLzFQriDGDMF6BYyMYjoLBGEyg2EO67Q1XdyuITdqJuoaOByuufsDJI+ZAfi0C
	 1m7Z5w6x2Z6RZETJG8fckbp4aEdbLVdVSAkPu5JgIt21QF5qEyxFfdPyrx3BG8Nz9w
	 meYtOb9T5f3JKablixSIYOL8iqeM5ZPyYZvjrwT08UrYjbtNU67p/8epkeoDS+nrJa
	 Dv8DztnGnPY1mefunG09+YqJdgv4lmD9rmhAEqcFfYbiHO1EG07PRbFIBlBZKNmMcT
	 Eae6LG4ODf9QNIVD0oHCvOxQT/uthf0jOiuQmM10N5/piQULThOLX6D0tsk5z/Z76W
	 ZePDxRa5Ek+ZA==
Date: Sun, 27 Sep 2026 22:04:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91-sama5d2: disable autosuspend on remove
Message-ID: <20260927220426.7b657976@jic23-hlaptop>
In-Reply-To: <20260927195519.76c2885b@systembl0wer>
References: <20260914113422.1689331-1-lgs201920130244@gmail.com>
	<20260914145339.00002f0b@gmail.com>
	<20260917041128.6d10a2f6@jic23-hlaptop>
	<20260927195519.76c2885b@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 19:55:19 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Thu, 17 Sep 2026 04:11:28 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon, 14 Sep 2026 14:53:39 +0200
> > Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >   
> > > On Mon, 14 Sep 2026 19:34:22 +0800
> > > Guangshuo Li <lgs201920130244@gmail.com> wrote:
> > >     
> > > > at91_adc_probe() enables runtime PM autosuspend with
> > > > pm_runtime_use_autosuspend(). The probe error path correctly undoes
> > > > this setting with pm_runtime_dont_use_autosuspend(), but the normal
> > > > remove path only disables runtime PM.
> > > > 
> > > > The runtime PM API requires pm_runtime_use_autosuspend() to be undone
> > > > with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
> > > > was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
> > > > set therefore leaves the runtime PM state incompletely cleaned up after
> > > > the driver is unbound.
> > > > 
> > > > Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> > > > path.
> > > > 
> > > > This issue was found by manual code inspection.
> > > > 
> > > > Fixes: 75d7556ac0e4 ("iio: adc: at91-sama5d2_adc: add runtime pm support")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > > > ---
> > > >  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> > > > index e8a5285bb6d4..e68632e628c7 100644
> > > > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > > > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > > > @@ -2487,6 +2487,7 @@ static void at91_adc_remove(struct platform_device *pdev)
> > > >  
> > > >  	pm_runtime_disable(st->dev);
> > > >  	pm_runtime_set_suspended(st->dev);
> > > > +	pm_runtime_dont_use_autosuspend(st->dev);
> > > >  	clk_disable_unprepare(st->per_clk);
> > > >  
> > > >  	regulator_disable(st->vref);      
> > > 
> > > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>    
> > Applied.
> > 
> > Please make sure to take into account both Joshua and Krzystof's
> > feedback that multiple near identical changes to drivers in the
> > same subsystem should be in a series.
> >   
> 
> FYI, patches like these will become redundant as I have a patch adding
> this to pm_runtime_reinit() so driver core calls this automatically on
> unbind queued for 7.4 [1].
> 
> [1] https://lore.kernel.org/all/20260919-move-dont-use-autosuspend-v1-1-f6e2d1315c23@gmail.com/
> 

Nice. Thanks for the heads up.

J
