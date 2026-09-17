Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13B2D2385;
	Thu, 17 Sep 2026 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614544; cv=none; b=rZe5k4loQ5MVJjdPgmtr1NZt5a225P00lX0uQ5sNwU80XudcFrcsDcQgKIalnK4hjReQKpFweWh0V4bUAfPP3+VfWDVn5J9iLzbo1ggy4Ac7E7OplT4wZNT1Xb/iPipO6d1kKbQJpXSVCV+fvNqXZDm5+ITVbKgeDZ8LI1Ob/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614544; c=relaxed/simple;
	bh=YNHRKIM569kerKprtYl4FItETLNYy+EftX+OSWMQy/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEJQy3AX/O48dkiLKFF/3HTkx9hK7Rhdh1cjiF7ig9EGzYQuzjdVv0G0IFyDTBZlSGXN1GUQ5S68SdN5YBXK782bowP5/lVzIoVg7TqJB6e39x4B2Vea1Pq5fM5Z2j7umyhOer1kaQeoiIo5P5B31ZNwp9dtcaofcupgV6ZWJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu0Mq8tc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eu0Mq8tc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997581F000FF;
	Thu, 17 Sep 2026 03:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789614540;
	bh=Mz745jPMmQISCmRLSQyCjy0BF1KtecXyzmycCnUBXgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Eu0Mq8tc2HkKY19FumyChGH4cv5e6HiGzxghj3zwFFNOa3RIHExfc30K5l5xBfePV
	 mzT7BmWMvzkT9PCgh+BYmcHt8sgccxAalqSNLcgEPZviQ1SNdd3Wl04DC7E+Gwle39
	 kjSimlkJ7Z8mmYosIiBGmzDBcrCi9YORC0YUu/nGElqwCM2ctL/e5HkYdURTrxIe76
	 9CSShVFnZAs/hdE6fei/fP5/IDB6CBy0+qOtNbq+gDiLQW81V4uqk9de5+kPGuiokc
	 UZiIH9+ATrviy1xR6EUc682njkH3Po6dZY6+jYc/SLIBWlCuNRS+iKirpzvRAJKusq
	 A+e5szB2PunRQ==
Date: Thu, 17 Sep 2026 04:08:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, Siratul Islam
 <email@sirat.me>, Pan Chuang <panchuang@vivo.com>, Irina Tirdea
 <irina.tirdea@intel.com>, Vlad Dogaru <ddvlad@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma9551: disable autosuspend on remove
Message-ID: <20260917040855.2ecf298d@jic23-hlaptop>
In-Reply-To: <20260914145021.00006863@gmail.com>
References: <20260914112447.1686972-1-lgs201920130244@gmail.com>
	<20260914145021.00006863@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 14:50:21 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 14 Sep 2026 19:24:47 +0800
> Guangshuo Li <lgs201920130244@gmail.com> wrote:
> 
> > mma9551_probe() enables runtime PM autosuspend with
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
> > Fixes: 6da93a6710a3 ("iio: accel: mma9551: Add runtime pm support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/iio/accel/mma9551.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> > index 7e01427fd9c4..182f488edab1 100644
> > --- a/drivers/iio/accel/mma9551.c
> > +++ b/drivers/iio/accel/mma9551.c
> > @@ -500,6 +500,7 @@ static void mma9551_remove(struct i2c_client *client)
> >  
> >  	iio_device_unregister(indio_dev);
> >  
> > +	pm_runtime_dont_use_autosuspend(&client->dev);
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> >    
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied thanks.  Most of these drivers (maybe all) would benefit from
a sprinkling of devm_ magic if anyone has time to do it!

Jonathan

> 

