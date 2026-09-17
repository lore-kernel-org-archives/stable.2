Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CEF33CE80;
	Thu, 17 Sep 2026 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614597; cv=none; b=aVQMYG/bYkQ2bO7Kf4PFx2MuowjLsqmYOThtwpnkOVS+qEzLp5I6V1KAI37zinALjIvN96w6gHnW+QRAJRHP9o3SM+0QtIneAt6qSypDXTDIYnLfVetnfJkRa8RZ00t9+A2cpu/aytbTi7yhxZXBbZlJta4e/c8y/WbYwn7FS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614597; c=relaxed/simple;
	bh=Gs96RRBBhbW/0NVDq3rZB2xKvmNRzqW2/0SuyxoJknY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Onb7d18OoBnJNvwwXMHq4Nx91z6cNtzBGtg9F9vtNcCLGKeb8xBzszWnIdC2QQO0ZHb/rolEWdvi1lXp4HJiwNU9xvIySSlBgXmA0wStyCi2dEQTUxyvrowe/Sn1n3wBfRTh1WSKLyDUeVretMR2VSQeo0WzpBtxA3qPnOAloKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRkWQ7so; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRkWQ7so"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE861F000FF;
	Thu, 17 Sep 2026 03:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789614595;
	bh=k9vP/Lso5tsa56UC6JSiKsREZslPM3fsQFjAZqBY6oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TRkWQ7soH/l248mOEURuBaCjosuP3lSp7cP8VnRfQhmdXVf9gtqlJT1JctfgxBJBG
	 24mjZ2SA+PIkCaumSML7u+LuUiBeRFbviyr95WRmGxh+yIEts1BwJUG+V42jMeYdp2
	 6J5l8y/IQLApZp7QgLtBtL/rZ03C1QEeUa9ilg92G6iUrzQNKxhSeIayB3GFdYiJD4
	 jq81ptaFburk4kHNSWMlouzi1jH1ToEI+V/dSm3ZsUTlIMjvAwKVggGsus8QD3cWE5
	 s3EZyj60XHtdhSIH5BZr37a4If3circJLTedTAK8RbEikiD6GducuraXiRdmVvGqlP
	 jodMELFKtpJCQ==
Date: Thu, 17 Sep 2026 04:09:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, Danilo Krummrich
 <dakr@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Pan Chuang
 <panchuang@vivo.com>, Irina Tirdea <irina.tirdea@intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma9553: disable autosuspend on remove
Message-ID: <20260917040951.2dbf7579@jic23-hlaptop>
In-Reply-To: <20260914145118.00007445@gmail.com>
References: <20260914113012.1688043-1-lgs201920130244@gmail.com>
	<20260914145118.00007445@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 14:51:18 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 14 Sep 2026 19:30:12 +0800
> Guangshuo Li <lgs201920130244@gmail.com> wrote:
> 
> > mma9553_probe() enables runtime PM autosuspend with
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
> > Fixes: 40cb761306d6 ("iio: add driver for Freescale MMA9553")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/iio/accel/mma9553.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> > index 8e7aaac89d47..5a36d415a837 100644
> > --- a/drivers/iio/accel/mma9553.c
> > +++ b/drivers/iio/accel/mma9553.c
> > @@ -1136,6 +1136,7 @@ static void mma9553_remove(struct i2c_client *client)
> >  
> >  	iio_device_unregister(indio_dev);
> >  
> > +	pm_runtime_dont_use_autosuspend(&client->dev);
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> >    
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

Applied.
