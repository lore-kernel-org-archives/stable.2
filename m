Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32562750F2;
	Thu, 17 Sep 2026 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614696; cv=none; b=DKXnBRCLrpOM+REaCEkvP+srKw/9w1WJ4peVSHu0/OGHuOTcd+wpoePAOMNu8/M2C+vrbwLg0I2A2sTNScJ1TgC/sa/F0dy+JzI5zZIfrHUii722hsNSC+2KKSTxGJunPXW9Sy9Rp2O6zagDTagXCV6yj4606fCP/60xA3Z0PpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614696; c=relaxed/simple;
	bh=KzLEC865v1+MeUtJvWKUgYlPya45LNMIfoqNLvIPBys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWm9zxnQhDbVLIPSb0jHMVxx3JALrSzlpCA/U6GXR/EVjaopA+AWLbp5SG1C9tpxx98j68WiyesWGUa2X5j2FsR53sUsXR+H5s5VEMlwTGp8WBhPr1Wd5pLunbVq7dccjZBM2O3HFsQEqjMPDVPZ059AWDgp00TGiHt5hat4rEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGKSNR4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGKSNR4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694AF1F000FF;
	Thu, 17 Sep 2026 03:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789614694;
	bh=p37WslwqTFupVnWRtqZCqX3Mp6C7WdJ7OYa7IZcx95c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SGKSNR4BNiuhH49T9JrWbbHOuGhiTLb1cXJdXzG4jnexsmtdIXJl3nTKQLLojFw/l
	 cpco9bN9dYkVlOCK7DqU0t6cbOr6pmoHz6TbCU3wJ3VV+Pvk52GgR94wvY3Z4AoMff
	 1F1iWLu3Ikd11dR5PIZ9Cvcp0j9yIzotetrW4ZpX0ZrNGWya8EQwSRBPBlPObGGV+D
	 wInEn4zq9vBS64HutZuFL8FFburZbtHB2+yBXzWOKbverFJhBwNlTumFFlofD9K0an
	 YvJzKygGesTc8b9HZzHjy9uukIOAq6wToh0VG8FnPw/ZeG0mVztPcbhoJyFNX1eUVp
	 di0tLs8GXuP2A==
Date: Thu, 17 Sep 2026 04:11:28 +0100
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
Message-ID: <20260917041128.6d10a2f6@jic23-hlaptop>
In-Reply-To: <20260914145339.00002f0b@gmail.com>
References: <20260914113422.1689331-1-lgs201920130244@gmail.com>
	<20260914145339.00002f0b@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 14:53:39 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 14 Sep 2026 19:34:22 +0800
> Guangshuo Li <lgs201920130244@gmail.com> wrote:
> 
> > at91_adc_probe() enables runtime PM autosuspend with
> > pm_runtime_use_autosuspend(). The probe error path correctly undoes
> > this setting with pm_runtime_dont_use_autosuspend(), but the normal
> > remove path only disables runtime PM.
> > 
> > The runtime PM API requires pm_runtime_use_autosuspend() to be undone
> > with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
> > was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
> > set therefore leaves the runtime PM state incompletely cleaned up after
> > the driver is unbound.
> > 
> > Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> > path.
> > 
> > This issue was found by manual code inspection.
> > 
> > Fixes: 75d7556ac0e4 ("iio: adc: at91-sama5d2_adc: add runtime pm support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> > index e8a5285bb6d4..e68632e628c7 100644
> > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > @@ -2487,6 +2487,7 @@ static void at91_adc_remove(struct platform_device *pdev)
> >  
> >  	pm_runtime_disable(st->dev);
> >  	pm_runtime_set_suspended(st->dev);
> > +	pm_runtime_dont_use_autosuspend(st->dev);
> >  	clk_disable_unprepare(st->per_clk);
> >  
> >  	regulator_disable(st->vref);  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied.

Please make sure to take into account both Joshua and Krzystof's
feedback that multiple near identical changes to drivers in the
same subsystem should be in a series.

Thanks,

Jonathan

> 

