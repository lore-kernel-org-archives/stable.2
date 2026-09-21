Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E8D1A268;
	Mon, 21 Sep 2026 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956170; cv=none; b=RY+tx6Gp4GrUuVF+aUAq0vMXEpJvZfTGGgQZGz8dqPtOH8x964v0TGxyOMWge56WYKY7gykQ/nIkIiWzPOo+s3qZ/OIo43Y/Bnad3ZcRnJctjokFB+Ku3T+8Kv1nmxdZgORDPEdo7XHID/39LJHR+b23imj98y/zQIBWNm5ovak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956170; c=relaxed/simple;
	bh=aklF/EWuE76Z15sPm/QIOukEDyqk1XTh0ATY+Cy7KYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvsnDjbfeGVxJ/kpiaw6RnK83L0RTNZ1mRiGeF5ea+uGQhngR40wH1FGLFX5SfsQywMyWcMcN1CgvRHpJAVVWwfg2TntSpoxkDOtMcHma04MxOaHgHFx31g+Ye9RSTmI2sSB8zFhLrF+hWDQCDCFL+LGw38BnAmwdyLFmeOqsv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHd78tbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHd78tbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D73C1F000FF;
	Mon, 21 Sep 2026 02:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789956169;
	bh=STRTGCSap7RA0c1tuGUPWzIx25Ds61DxcSt2CIHn/Mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hHd78tbvA6bRaxBn1jhqufbKdHWmlGHhigy0wl+hvk/FfpafHUC60D87zTu/nEuRi
	 5sAO0lpTaapECkFJyzuPCd5XB/uLYu1Ir9L38n/RfJ8VvykkV8qUYu2dCB2BiEKK6w
	 0GjobAH6vzwGQuT9ffZDqkr75dDNvUNtxie7o60C8EyXdEPjV42PZ9CtPPAwEyZD8Q
	 QOSFPeuY8RzqX+MGltWxmsGf3yJvc+yfnDfeyuRYMm5h0jUuKpZDvrWOKQkAi9t0BT
	 wtLTTZ1c7E+VPqQVYNlf9WmxMc7SEdmTNkqGEuBDFuDKsXAsSEpglgGTZnWf2p+Vel
	 QGmZ3O/8sgXvQ==
Date: Mon, 21 Sep 2026 03:02:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, Siratul Islam
 <email@sirat.me>, Danilo Krummrich <dakr@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxcjk-1013: disable autosuspend on remove
Message-ID: <20260921030243.767af571@jic23-hlaptop>
In-Reply-To: <43bdf1d5-bd82-496b-8408-871646fe59d4@gmail.com>
References: <20260914112053.1686061-1-lgs201920130244@gmail.com>
	<43bdf1d5-bd82-496b-8408-871646fe59d4@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 08:04:12 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 14/09/2026 14:20, Guangshuo Li wrote:
> > kxcjk1013_probe() enables runtime PM autosuspend with
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
> > Fixes: 124e1b1d0924 ("iio: accel: kxcjk-1013: support runtime pm")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >   drivers/iio/accel/kxcjk-1013.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > index 166fb786425f..c6b030f64be1 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -1547,6 +1547,7 @@ static void kxcjk1013_remove(struct i2c_client *client)
> >   
> >   	iio_device_unregister(indio_dev);
> >   
> > +	pm_runtime_dont_use_autosuspend(&client->dev);
> >   	pm_runtime_disable(&client->dev);
> >   	pm_runtime_set_suspended(&client->dev);
> >     
> 
> I am not sure if it matters, but it bugs me a bit to see that the 
> clean-up path for PM here, and clean-up path at probe error, do still 
> not have same steps. As far as I see the probe error path omits the 
> pm_runtime_set_suspended(). Do you think this should/could be fixed?
> 
> Oh, and if it is fine as it is - I would really appreciate education as 
> to why :)
I'll go with it probably isn't fine. But honestly I haven't chased exactly
what happens around that stuff on a failed driver probe.
> 
> Other than that:
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> (I know I am late with the tag as Jonathan applied this already - I 
> suppose it's still Ok to say I am "Ok" with the fix :] )
> 
Absolutely!

Jonathan

> Yours,
> 	-- Matti
> 

