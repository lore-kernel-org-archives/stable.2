Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1B3BBFD9
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531726; cv=none; b=f/pSZPiiPjT04KHPqn9PNfFIYsbhe/uXB0KWz7/mUXKfHcsjafVW3yVhzAvjF+LrKq3i3xSMHZdEPai/IROy20ec6rF4VuWCUqv1dcd1uLUoTWtvMhmEIxnvHwDQ2kAkvOVyRa0Gugb/ys3grnNaB+UJ7JFHnY+fe2tDruvZEgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531726; c=relaxed/simple;
	bh=s6FZYmulgvomkdY9Fcfdj3azSZv7XguaNTjdt7XQ080=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pqe18cxkBQnGCiaDFRl2I+VgA3dDEIvGGwXe7D3DbF0VGvlc61u3CgEoT5sI3MpABr5T4+Ay4Nc/LE8umW/5JnUhkIh3KMxLhpXIJSWriL3ihRccDTgZQb/ToFXT2pc6B4YwYZ+pNeO65L6Brq7kSlP9+yKEEHfsgHFZX1WzW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIyidMYx; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIyidMYx"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887635e952so983480f8f.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790531723; x=1791136523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nKitTAlwTBExXI+cI2+8578Ap+v+wKyXIoUr5i+JPl8=;
        b=qIyidMYxGa5GI2DCovSSGiYtkNlwmLmPZVoPMRV8/8HA9hSHYE6Myqe1TlRkKa5C2P
         P48CbrZ3euJKTmo8k3c4ljO4/tIJXoSKK2DI9DSMcGOouEccutJ2GeH46xNDu9vAAAbF
         Cmw8PJ5haznHdC2abLVYgfBlhY/qDt9cSNBWlmvdH+6y2Z1paE6RpgiUCwvX0HjBZvZJ
         9AFiSdYnMbGDPiB4A8e/tVSHpHKz/tMKBUdFwtZZH1nx41qLwihQncd25CaenUHBAtv0
         Ad77awKe8O21KBLMiLR+CfzCNoUyf20d5LDV1vA2c42P/tGBbMZJ14ueJZ8e2bNca21n
         sMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531723; x=1791136523;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nKitTAlwTBExXI+cI2+8578Ap+v+wKyXIoUr5i+JPl8=;
        b=aYSLJlqT+sYtDlQfeHZM2cs48ZKRPUh/slSZICm2fiufDrBZxdsSZ8/EXnJJxH5DN9
         gLZfrF/6ItGwaquL05aD62JaNJMu+FHcv5vpKwYAwpV1bDGS8YU4ZoMV/Us5A1fvVwi6
         OgO9LsEcC8DZEHDokCDaych8bhx/EQT9XKBcR1It1aNzKsdbyxD7Fw/pinSPTGgQZsjc
         vFsvGVp9IB/Khjb8W5Eq5oH82Kch/EppNfEZ+anXkZTDvjLnzY0oMFouhKEtCidYM2r+
         h2Gj2DXBhQO9PlaRwDu2CeQRzb7Vw0eoPwDPtfVQouegxrYmSCJ+QIhb2eihd5MFfjly
         lRzA==
X-Forwarded-Encrypted: i=1; AKwUvBwWX3Flh0bNkWECb4S5lSjR8sAqgArQ/OsUzq5sUDCgbEXMqVrdm1cSAPpCeqYbc4HiQG3fIM4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0Z6YWqR6ryRkM77fwnp6Lh4yJPyJpXeLWawH+6SWolIekeDB0
	oexo5v9Z2t0UBgHJzv7jLzxgieiwDl+DQ6bamKyeTM97/TuUyruZhcUP
X-Gm-Gg: AYBFou0ARIELI4XIAhpR3YDc/JDfZkSKQisuxWmiTKdjyIRLYQHBNP2nZKQca9QXZOC
	nIYbPelwudr/DcAExwmCtrB1p5/KU7YqUWe7xl17t7WyU44SywrJbU9u/8wF0QfvSSsqaovMQFQ
	sG8Uxum2Nvs7OEPFQqU9wtsMkGrI8SfGCOvBmYmWYIJ9KkymeHyP0TbEsnB9a0iOcAiKexc5woK
	N9tJQbtoWWDVWM4xz0caKJ4Q7WZYHamVEGpexxA9N3M3DwnZiu+Iktxwv7L4JjHU/8b2CycK/rz
	5PQ/z0ayMDE7o8xWCa/u/iOXhdSJtN/gtYC8juRQh1f6nuHJDx9zTFrbiz9h/zIoiiAZB8yyDuf
	eQnmwOyzuuXm6oO2p1vBhLQCMaOZc3f/1rEBDK7E0X2e7FBRsvxmSOjW567avRweLZFhL/6znZS
	Yqc8YxuAyqXQHGCoyR72dvJNLakKdfA3HImaUgGhPPYHzDrhlXS4G5H+EGHeIR2op0si52lwUzj
	Xfy1CmeLbkztWh9z8AzDz1mwoVKtppqQPUNBj8G4GeIKejKMn77Go4h4dQzZ92ornWklAHibzCd
	O2RAzxtR04McS8LisSS3zsGF5U+eU0fuyDIxi4Y3/peDfWrZhcAGf7pfnGpb5ynHHgciuT09m0x
	O7auk7oIsODYRqRb/ExF2ZCUm01y3U0g=
X-Received: by 2002:a05:6000:468c:b0:488:76f5:c7d with SMTP id ffacd0b85a97d-48876f50d2bmr11484821f8f.6.1790531722779;
        Sun, 27 Sep 2026 10:55:22 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b1dfsm22726735f8f.4.2026.09.27.10.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:55:22 -0700 (PDT)
Date: Sun, 27 Sep 2026 19:55:19 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91-sama5d2: disable autosuspend on remove
Message-ID: <20260927195519.76c2885b@systembl0wer>
In-Reply-To: <20260917041128.6d10a2f6@jic23-hlaptop>
References: <20260914113422.1689331-1-lgs201920130244@gmail.com>
	<20260914145339.00002f0b@gmail.com>
	<20260917041128.6d10a2f6@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 04:11:28 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 14 Sep 2026 14:53:39 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > On Mon, 14 Sep 2026 19:34:22 +0800
> > Guangshuo Li <lgs201920130244@gmail.com> wrote:
> >   
> > > at91_adc_probe() enables runtime PM autosuspend with
> > > pm_runtime_use_autosuspend(). The probe error path correctly undoes
> > > this setting with pm_runtime_dont_use_autosuspend(), but the normal
> > > remove path only disables runtime PM.
> > > 
> > > The runtime PM API requires pm_runtime_use_autosuspend() to be undone
> > > with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
> > > was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
> > > set therefore leaves the runtime PM state incompletely cleaned up after
> > > the driver is unbound.
> > > 
> > > Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> > > path.
> > > 
> > > This issue was found by manual code inspection.
> > > 
> > > Fixes: 75d7556ac0e4 ("iio: adc: at91-sama5d2_adc: add runtime pm support")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > > ---
> > >  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> > > index e8a5285bb6d4..e68632e628c7 100644
> > > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > > @@ -2487,6 +2487,7 @@ static void at91_adc_remove(struct platform_device *pdev)
> > >  
> > >  	pm_runtime_disable(st->dev);
> > >  	pm_runtime_set_suspended(st->dev);
> > > +	pm_runtime_dont_use_autosuspend(st->dev);
> > >  	clk_disable_unprepare(st->per_clk);
> > >  
> > >  	regulator_disable(st->vref);    
> > 
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> Applied.
> 
> Please make sure to take into account both Joshua and Krzystof's
> feedback that multiple near identical changes to drivers in the
> same subsystem should be in a series.
> 

FYI, patches like these will become redundant as I have a patch adding
this to pm_runtime_reinit() so driver core calls this automatically on
unbind queued for 7.4 [1].

[1] https://lore.kernel.org/all/20260919-move-dont-use-autosuspend-v1-1-f6e2d1315c23@gmail.com/

-- 
Kind regards,
Joshua Crofts
