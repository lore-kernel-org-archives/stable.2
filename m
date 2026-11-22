Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376952;
	b=4t/8ipRf0RUUdXeSmEpDw+KEvvOoaINl6BliHqzmK+71jQ6sA16uc2Qs9eDBneodsxhx
	 6U3HKG8sR7R4xr8dq8N2wUHxO/TVnJyX26CKyQPHyIiw7LzYC+JAUSTndPQSWrf27d17D
	 QITsyK/+x7HN9xT7yLAKrb9/K/p7oabXViVn9ovTzzjKkbbatA6Pz3EnojQvT9FVTnLWS
	 xpfzRPGtP9/OjB7jy21Y59DobAymJbLLM5zitKkTzHs00gRWPG3QTQJFGVcZZt79H9wTc
	 VhIjeHpro/apW/wTqDpu2JI/6R/tzAMliTtWvmq9MKl2jvtbgwPGrHdCoR8NCGoAT3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376952;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7RlmqShaVLVCrFL26b8L6FpqT606cA+3tszi9Li1QLg=;
	b=U34BZCNVoxCaxY//Hh7P5xUT8qHLy28cJngHsjsMsPwlr+8FSpglsqcnGEA3fEgua6Hf
	 5EbtjKnfgmMuvdzXyjhXAe1gbWOyQKJsvqI5QDeXHzeVRxDPgi3Rp9AzEz8DFC3bqRjeb
	 hRj+jUbIFB8m0AIgI5u0oByEm4JqxprSRaE6MlDxNgqh1DYMpUj7ZJ7BzHv9bnzWJbirW
	 J8GTqIAq/V92AYLR/jMQlEMA+LeLsVdd+SSZA/tK8SKQEDHOoss86PJGoc92MOiLGptwR
	 YsVdDXCDb96nWYL4tWDYTVn8qNQrVOlil3d0cnlh3hvq8ePK6CqMwYYi0k5fKQNJHnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JLL4Uf/8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3C606A31A;
	Sun, 22 Nov 2026 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JLL4Uf/8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9851F000C0;
	Sun, 22 Nov 2026 19:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795376951;
	bh=7RlmqShaVLVCrFL26b8L6FpqT606cA+3tszi9Li1QLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JLL4Uf/8rXtH8SX8QjPumO+n+ApisX122z0M0THo+0cEYGMF9KJ8zo265WBMP7cWt
	 mJBftw5sNQ6OzbC/ke8ogthWVuyQo6bboTfGLbY/PWdoWuvRBIoozJD2bAfGNR7pOQ
	 OsdhFUDiq8D1M5LvGQOpQ4IuHzDyfqio4SmK/dVXQ3kmewCLz89A5Zij3IQulChDoT
	 WE2G/ApNbYmyfBWj6G9oo5UB+HiQfW1voms9/oAH4j7Oi30+2eA2OSbGkbavELI/mB
	 nzRB6sCuOo09c1qXVnPoQKLE/bjgM05R64jSyrdfyrtbR6Fk7dW8OowU+bpeVrPkgU
	 nQV7GFEOWKvyw==
Date: Sun, 22 Nov 2026 19:49:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: phil.williams@advisoft.co.nz, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Mario Tesi <martepisa@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fall back to 25 us/tick without a
 trim
Message-ID: <20261122194905.562ab69a@jic23-hlaptop>
In-Reply-To: <avrFD8e4UlKOB4NB@lore-desk>
References: <20261116-st-lsm6dsx-ts-fallback-v1-1-8ace30afbfb5@advisoft.co.nz>
	<avrFD8e4UlKOB4NB@lore-desk>
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

On Mon, 16 Nov 2026 09:55:43 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> On Nov 16, Phil Williams via B4 Relay wrote:
> > From: Phil Williams <phil.williams@advisoft.co.nz>
> > 
> > Commit 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp
> > calculation") takes the FIFO timestamp scale from ts_sensitivity.
> > That field is only filled in for parts that have freq_fine. The
> > untagged-FIFO parts are left at zero:
> > 
> >   LSM6DS3
> >   LSM6DS3H
> >   LSM6DSL, LSM6DSM, ISM330DLC and LSM6DS3TR-C
> > 
> > st_lsm6dsx_read_fifo() multiplies the raw counter by hw->ts_gain, so
> > every sample is published with the timestamp taken when the buffer
> > was enabled. The accelerometer and gyroscope values still update.
> > Userspace that integrates attitude from the timestamp delta treats a
> > stuck timestamp as dt = 0.
> > 
> > These parts have no freq_fine register, so there is no trim to apply.
> > Use the previous fixed scale of 25000 ns/tick when ts_sensitivity is
> > unset. Entries that already set it are left alone.
> > 
> > Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp calculation")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Phil Williams <phil.williams@advisoft.co.nz>
> > ---
> > Resending inline. The first copy went out as an attachment.
> > No code changes.
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 823f8ac66..98db90a30 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -2525,8 +2525,14 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
> >  			return err;
> >  	}
> >  
> > -	/* calibrate timestamp sensitivity */
> > +	/*
> > +	 * Parts with no freq_fine register have no trim and leave
> > +	 * ts_sensitivity unset. Those parts used a fixed 25 us/tick.
> > +	 * A zero gain publishes every FIFO sample with one timestamp.
> > +	 */
> >  	hw->ts_gain = ts_settings->ts_sensitivity;
> > +	if (!hw->ts_gain)
> > +		hw->ts_gain = 25000;  
> 
> I guess the patch is fine but it seems a bit weird to set .ts_sensitivity to
> 25000 for ST_LSM6DSR_* family in st_lsm6dsx_sensor_settings array and keep this
> chek here. Is it better to just add the missing info in
> st_lsm6dsx_sensor_settings? (I do not have a strong opinion about it).

Agreed. I'd rather we just added the data to all the hw entries so this
special casing isn't needed here + we have the appropriate info in those
structures.

Thanks,

Jonathan

> 
> Regards,
> Lorenzo
> 
> >  	if (ts_settings->freq_fine) {
> >  		err = regmap_read(hw->regmap, ts_settings->freq_fine, &val);
> >  		if (err < 0)
> > 
> > ---
> > base-commit: fa2933aac170dd19c6a7f0d7b81a8f537e40915c
> > change-id: 20261116-st-lsm6dsx-ts-fallback-cd21f1d1e30e
> > 
> > Best regards,
> > --  
> > Phil Williams <phil.williams@advisoft.co.nz>
> > 
> >   

