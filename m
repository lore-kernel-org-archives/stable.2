Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74327221277;
	Mon, 27 Jul 2026 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119517; cv=none; b=r6Knd9zfv8aA5Qy8nEGcl4BCo6Dn4w2y5h51divwodYKxzZwig8J9l29G3UJQc/8N9AD4Qdmhz/MI8cpRlPaL+LrRy0/fVandpUIMHX7E8PlSebdj9xJmU9iUvHXrcEPYIv06ncC88RHxHDAZ9caR6URxC62WtMNM47ix0PZo8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119517; c=relaxed/simple;
	bh=ahX09hCMWRq6fvgmb+fqZDH6p8L24KPDgXvLX4ETW0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMAgEsJRcqj5RRDvs0ZTL3VrSjCLmE8MA5O8Op2WPiKDyOS0WZ18UGjpVKzocaOJtU8GAA4RyAWdYi8LSQVI0IMaVrKu24D+3K39E/fNob9vOC+mG6/LHILOYv6HK85sV7CqLyhQm4T6IhcTdhOrNJtJe/hKO57yeMOzAWePUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cew87S6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cew87S6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619AE1F000E9;
	Mon, 27 Jul 2026 02:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785119516;
	bh=Er+E8J6pWnRc+l9TKEaFFu14LRNnOAIt5FQYdwQ5JN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cew87S6l6bc+gvIwRIjZcyC9afNHhWNVjJzOraQjPqtnACJdVa6Guq2RYRgYDvP9r
	 KhuEEynuXBJEsl9vNS56LpE1a3IuTPUPbE+c5uyLCZvwVKKaqxY04WonKyTUFgFBDs
	 5JjeaSGep8/ny8HosfeAHyK93+l8eRlvxAi4I9fomX6cEblvzdpkV07+vhUp5FISSX
	 Yd6EchRaTsBo7r4RTfiNCp0wWR3/EKtBDl9ZlNESDhJAm9NxhdaM3yf0yA3aZMDpEb
	 pL7+CkbRi3vT4oipRE5mGbWwrfIkJkWkoG++S16Exj4cF4GDYKEoyluRX2Ekt0u/Xs
	 essWp0JjwhjcQ==
Date: Mon, 27 Jul 2026 03:31:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH] iio: light: apds9306: fix PM reference leak in
 apds9306_read_data()
Message-ID: <20260727033151.0ea0cb9d@jic23-huawei>
In-Reply-To: <20260725051048.5616-1-mokshpanicker.7@gmail.com>
References: <20260725051048.5616-1-mokshpanicker.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 05:10:48 +0000
Moksh Panicker <mokshpanicker.7@gmail.com> wrote:

> apds9306_read_data() calls pm_runtime_resume_and_get() but several
> error paths return directly without calling pm_runtime_put_autosuspend(),
> leaking the runtime PM reference and preventing the device from
> autosuspending.
> 
> Add a goto label before pm_runtime_put_autosuspend() and use it on
> all error paths after a successful pm_runtime_resume_and_get().
> 
> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
Good find.
Please look at PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and matching ERR macro.

Using that should simplify this fix quite a bit and generally give us nicer code.


> ---
>  drivers/iio/light/apds9306.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 5ca4c87524fe..014db7a1787e 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -475,19 +475,21 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
>  
>  	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
>  	if (ret)
> -		return ret;
> +		goto out_pm_put;
>  
>  	ret = regmap_field_read(rf->repeat_rate, &repeat_rate_idx);
>  	if (ret)
> -		return ret;
> +		goto out_pm_put;
>  
>  	ret = regmap_field_read(rf->int_src, &int_src);
>  	if (ret)
> -		return ret;
> +		goto out_pm_put;
>  
>  	intg_time = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
> -	if (intg_time < 0)
> -		return intg_time;
> +	if (intg_time < 0) {
> +		ret = intg_time;
> +		goto out_pm_put;
> +	}
>  
>  	/* Whichever is greater - integration time period or sampling period. */
>  	delay = max(intg_time, apds9306_repeat_rate_period[repeat_rate_idx]);
> @@ -510,7 +512,7 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
>  						  APDS9306_ALS_INT_STAT_MASK)),
>  				       APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);
>  	if (ret)
> -		return ret;
> +		goto out_pm_put;
>  
>  	/* If we reach here before the interrupt handler we push an event */
>  	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
> @@ -530,14 +532,15 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
>  	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
>  	if (ret) {
>  		dev_err_ratelimited(dev, "read data failed\n");
> -		return ret;
> +		goto out_pm_put;
>  	}
>  
>  	*val = get_unaligned_le24(&buff);
>  
> +out_pm_put:
>  	pm_runtime_put_autosuspend(data->dev);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int apds9306_intg_time_get(struct apds9306_data *data, int *val2)

