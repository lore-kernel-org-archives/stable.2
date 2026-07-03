Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D177F279334;
	Fri,  3 Jul 2026 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105347; cv=none; b=bOFrn7McZW+g35gA9+QW9hS3jQO6AOpSpJPrXvU6k5KV3qU/TUahJD9kDN0kg/PF7r42lu5TXT1ViVb6Elk+OLsRG/ezLlRY1cpfqEZguvrSwHp77iYza/0BrVnkJm6bPBJxnCeLwZm9DCoXtYOVWMYzg56L2GNzcCLhjYe2YTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105347; c=relaxed/simple;
	bh=0HAw4IF5+vJjZLubMPzLBZ3ZKABmSkC7nOW1fR2lvqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1pKpD1Hlgrlz/CAY6jrbfWR+TQhQpNta8FZTBJIVNXUfdSi9lrLBjW+K5vbZrADO+jv1aReva08MEx4IA2nkGSVbZH5HlLjgneQgyqewZfQptyDUslR6bI5F0haQmQXvSSu+KkXT8NlFzIgweRWODXWE3tprOahf5oEK1EWXJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq3BSxF/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq3BSxF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4151F000E9;
	Fri,  3 Jul 2026 19:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783105346;
	bh=/v/11QHli8SHAW+cYni/rdBq+HRJs++OUQUFF1VwmY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eq3BSxF/MAzlL/0uxpvtp4kPr2SJYiM7mmnLCrEfxcB7pXLfUajKoyafB1db21sVP
	 dVN2+v3xBtQwk6WxwQukkJIINqKbbhbTPKV1DcJgLtc06p9r4TnBPP3UMg4f/CLTLY
	 JOoW7xxFFQvw1ZLI49rVJtQmOF7s64PqK8y1Feg1g2k0ckUJXAAGdYxkVhJDS4BpC7
	 7GSnpBMxVWTc3hN4rRaunhNf2sR0b/rdzz81tqbrY1PlpZDeQ8c3rs6182gu+T/Hiw
	 7aJzuwcxTCWsKOx6Sj3i3AtzbFNhOo7gbWThs5DVcoBirGSWCWoITLgcNFJf6b1xmn
	 tGq8o6oZQKswQ==
Date: Fri, 3 Jul 2026 20:02:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamp clock period by
 using lower value
Message-ID: <20260703200224.69d60475@jic23-huawei>
In-Reply-To: <20260623-inv-icm42600-fix-timestamp-clock-period-v1-1-82184d2429f4@tdk.com>
References: <20260623-inv-icm42600-fix-timestamp-clock-period-v1-1-82184d2429f4@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 16:22:15 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
Sorry for delay - I'm finally getting back on top of my emails (for IIO anyway!)

> Clock period value is used for computing periods of sampling. There is
> no need for it to be higher than the maximum odr, otherwise we are
> losing precision in the computation for nothing.

Silly question - what are the user visible results of that precision loss?

Less accurate time stamp estimates, or something else?

Jonathan


> 
> Switch clock period value to maximum odr period (8kHz).
> 
> Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 4 ++--
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index 532d5fdffaf8..7df920ef3cf0 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -1170,10 +1170,10 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
>  	accel_st->filter = INV_ICM42600_FILTER_AVG_16X;
>  
>  	/*
> -	 * clock period is 32kHz (31250ns)
> +	 * clock period is 8kHz (125000ns)
>  	 * jitter is +/- 2% (20 per mille)
>  	 */
> -	ts_chip.clock_period = 31250;
> +	ts_chip.clock_period = 125000;
>  	ts_chip.jitter = 20;
>  	ts_chip.init_period = inv_icm42600_odr_to_period(st->conf.accel.odr);
>  	inv_sensors_timestamp_init(&accel_st->ts, &ts_chip);
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> index 11339ddf1da3..a18dcac93929 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> @@ -755,10 +755,10 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
>  	}
>  
>  	/*
> -	 * clock period is 32kHz (31250ns)
> +	 * clock period is 8kHz (125000ns)
>  	 * jitter is +/- 2% (20 per mille)
>  	 */
> -	ts_chip.clock_period = 31250;
> +	ts_chip.clock_period = 125000;
>  	ts_chip.jitter = 20;
>  	ts_chip.init_period = inv_icm42600_odr_to_period(st->conf.accel.odr);
>  	inv_sensors_timestamp_init(&gyro_st->ts, &ts_chip);
> 
> ---
> base-commit: cc746297b23e89bd5df9f91f3a0ca209e8991763
> change-id: 20260623-inv-icm42600-fix-timestamp-clock-period-931338a848c3
> 
> Best regards,
> --  
> Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> 

