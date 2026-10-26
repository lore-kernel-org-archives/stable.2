Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792982185;
	b=sevfWrvwDyNlXLxdqScu7uSJUGxz2x6djNf4bL2o2vH9x6PAWBodhkzx6F8RA8rb8hBt
	 uJGehriS3n/35Ac7LYaH8AVOdwF+rMulaayuJAfdzpk197dmXo7tpsGORaa+9cGxb3JVy
	 JGLR3j+vjKncfNMpFd+kQ66+Z4JebY2d8GsSKmU2sUn97YEnpaw9KejrbltDkiuiah8Hj
	 T3uI2NHrWPUDlWOVAptnWMMICJ8Y+r3OEU6Da3KxhpDMBV9kuJBER55jCXe5pfohuCorG
	 G9UgCltjNYsRqmb4BEZDq9XKPgzlNUX9NfQXvMmNRS6f2yvciygkuOGuCsc2ts7UDng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982185;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SKoskmUEHncN1Kp0kif2lvDuh8lAXn+L/FJB4C/RkwY=;
	b=yeuGmfju2AVczy3ynbspK86c+nfidu1hF7MeUCe8IkKrznsdM2lP/RzyOQy1U+6nyQwM
	 76rbe3BxDE83wBgne5tEUqnvuMgY2h7AgNLEiq/x/xgc3fIaGlMP733rtT6H/AGwMcJJe
	 iedF9WVmPWiE+8cUD3nepEKqwwvm2nahC8WHrqt/0keyk7H7gvz3yW9WVvAwCnUPxnpzN
	 hnCnZBQ/xftq4peHIx6blWo5BAVuaAceRmKHAmd5pQt6XG18YWXtSb98M+3FCCdSFRlVp
	 MIhAIA9L+mritNhMlqMNDEDTzvTKzW19KBcHDX6govuUN0FqIan2lj4GP2LE4kCRlvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mWbmE/Ms";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF6606A325;
	Mon, 26 Oct 2026 02:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWbmE/Ms
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536CC1F01828;
	Mon, 26 Oct 2026 02:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792982184;
	bh=SKoskmUEHncN1Kp0kif2lvDuh8lAXn+L/FJB4C/RkwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mWbmE/MsZWdtfu3a7PO7aUhygtABZuVNAJq2UvRc2sjPS84+BFbxWVLSpF9I3S2WQ
	 QZQBTe1UvvVwzlh4NwYNPlck061aZdX9OM0jTjhzNScV7JXBQDsnQKhdmKUKptMKgJ
	 98LxX0BJJHVgRUEtNtZqUEAhUGoA5NadcScYluzaf60436pYnPUN+c5hT/EmLAJJ0H
	 U2RlybtH0sTr5/MGrOS4XHZcx0fNWkt12QUMgCbzJbaVKqw1HMWdwVKYkOxPCAVqix
	 HveIoOFq3kUnElKoak3C7EE2OjveGlXfGHch2T0o3O4Bk6Sy2eR4k+lQc6F/RZ6qva
	 Xpo/DpqEBPw3w==
Date: Mon, 26 Oct 2026 02:36:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: inv_sensors: prevent timestamps going back in time
 in transitions
Message-ID: <20261026023616.02ef34db@jic23-hlaptop>
In-Reply-To: <20261020-iio-common-inv-sensors-fixes-for-preventing-timestamp-in-past-v1-1-c27be451b287@tdk.com>
References: <20261020-iio-common-inv-sensors-fixes-for-preventing-timestamp-in-past-v1-1-c27be451b287@tdk.com>
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

On Tue, 20 Oct 2026 17:26:00 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Ensure when computing first timestamp and when applying odr change,
> that the next timestamp will not be lower than the previous one.
> 
> This way there is no risk to have a timestamp going back in time, meaning
> being lower than the previous one. It already can never happen without
> a transition because we are generating timestamps by adding the period
> to the last timestamp.
> 
> Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Maybe it is just me, but it does feel like there have been a lot of
bugs in this code.  It's complex fiddly stuff so perhaps not surprising.

Anyhow, applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 16 ++++++++++++----
>  include/linux/iio/common/inv_sensors_timestamp.h       |  3 ++-
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> index 8c9e81a77e68..9040da80f0c7 100644
> --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> @@ -133,10 +133,15 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
>  		return;
>  
>  	/* no previous data, compute theoretical value from interrupt */
> -	if (ts->timestamp == 0) {
> +	if (!ts->init) {
>  		/* elapsed time: sensor period * sensor samples number */
>  		interval = (s64)ts->period * (s64)sample_nb;
> -		ts->timestamp = timestamp - interval;
> +		delta = timestamp - interval;
> +		/* prevent next timestamp to be lower than the last one */
> +		if ((delta + ts->period) > ts->timestamp)
> +			ts->timestamp = delta;
> +		ts->init = true;
> +
>  	}
>  
>  	/* update delta timestamps and estimated period */
> @@ -184,7 +189,7 @@ void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
>  				     u32 fifo_period, size_t fifo_nb,
>  				     unsigned int fifo_no)
>  {
> -	s64 interval;
> +	s64 interval, timestamp;
>  	u32 fifo_mult;
>  
>  	if (ts->new_mult == 0)
> @@ -207,7 +212,10 @@ void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
>  		fifo_period = fifo_mult * ts->chip_period.val;
>  		/* computes time interval between interrupt and this sample */
>  		interval = (s64)(fifo_nb - fifo_no) * (s64)fifo_period;
> -		ts->timestamp = ts->it.up - interval;
> +		timestamp = ts->it.up - interval;
> +		/* prevent next timestamp to be lower than current one */
> +		if ((timestamp + ts->period) > ts->timestamp)
> +			ts->timestamp = timestamp;
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_apply_odr, "IIO_INV_SENSORS_TIMESTAMP");
> diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
> index 4f08204ede3b..91690778ae88 100644
> --- a/include/linux/iio/common/inv_sensors_timestamp.h
> +++ b/include/linux/iio/common/inv_sensors_timestamp.h
> @@ -66,6 +66,7 @@ struct inv_sensors_timestamp {
>  	u32 new_mult;
>  	u32 period;
>  	struct inv_sensors_timestamp_acc chip_period;
> +	bool init;
>  };
>  
>  void inv_sensors_timestamp_init(struct inv_sensors_timestamp *ts,
> @@ -94,7 +95,7 @@ static inline void inv_sensors_timestamp_reset(struct inv_sensors_timestamp *ts)
>  	ts->it = interval_init;
>  	ts->delta = interval_init;
>  	ts->delta_counter = 0;
> -	ts->timestamp = 0;
> +	ts->init = false;
>  }
>  
>  #endif
> 
> ---
> base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
> change-id: 20261020-iio-common-inv-sensors-fixes-for-preventing-timestamp-in-past-8da19f683084
> 
> Best regards,
> --  
> Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> 

