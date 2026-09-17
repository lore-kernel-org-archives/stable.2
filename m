Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523C1F8755;
	Thu, 17 Sep 2026 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604435; cv=none; b=Z+EFiGyW4Uau8ex9+/3Pf753D2w+pHxtVIKv5KkGj1w5X+LvVEmV7kGKTLjc/oUnvmEn1li/Gjq7QPtzeDsEVY8kPSLI1n1amYXLH5mPGOt8kad/t1qUJUtN70MJOGvUHAPUlfeZJMaeqG8Z9oigx0s5y0P22ghdjED0Wd2gRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604435; c=relaxed/simple;
	bh=T6taZodXFCYnxyIAY8fB7774BuIWh1NuSVGdGrT1WtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q23Rr5TVL6/9YAI5l6wWDjho6HLRBRFqHKd5MjaA6sxLGU9Pq11WrqKrNKGdxLx7SsvAZFFS8yl0ILt4Pd1KX/PUGhDgkK7TYyFoDomi29KvoY/EqZ4Q99WQa1TogdJbfRJ2yFd5dDhvHCZiANyTPUWZJ0aKyC0fvlTX+hGf8WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxcPguzP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxcPguzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406E71F000FF;
	Thu, 17 Sep 2026 00:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604434;
	bh=VU0RdrSYSaktP7eaGg2QcyaHvscbHkZB/kh8R6MdnxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lxcPguzPWr9xu3mWRXA4anOPm4vOqDQWLx+eG9H664oOkIbJ7Daetn3c2Pv+AX6Da
	 KqVO2TMLzTHbHLsu5YufYRddZ42B7Uqp8+Wll3/1EaRdVVShOVr8wBBaoldEO2iQNa
	 toF0g/hNs+TKUYPoYfmzqMp3lpSVxMnM91TZouTKCZK/VaLiZX1bQ03vsirUwKizx0
	 5CKshC6Xi7Tv35wQhDkCLv5NFjsGoWxQnJXOtG9AGTz5pPI+oB/4RrHfHRauJkwq7r
	 YTaO5K7gO6QkkdmOjRvHwl/8y4rGHMW+C+t9WYpB2gsCy+AnzM8xfT06JBTySnB5Qi
	 XpU4aWc9Dm5dg==
Date: Thu, 17 Sep 2026 01:20:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 srinivas.pandruvada@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxcjk-1013: Fix trigger reference leak in
 kxcjk1013_probe()
Message-ID: <20260917012032.5d5f84be@jic23-hlaptop>
In-Reply-To: <20260916161054.2082486-1-vulab@iscas.ac.cn>
References: <20260916161054.2082486-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:10:54 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference acquired for indio_dev->trig is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Move the
> iio_trigger_get() after iio_triggered_buffer_setup() succeeds so that
> failure of motion trigger registration or buffer setup, which return
> before the mode is set, no longer leak the trigger reference.
> 
> Fixes: c1288b833881 ("iio: accel: kxcjk-1013: Increment ref counter for indio_dev->trig")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

See bma220 reply. Not something we are going to fix like this.

> ---
>  drivers/iio/accel/kxcjk-1013.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 2823ddde4bf2..dbaa829a98c2 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1488,10 +1488,6 @@ static int kxcjk1013_probe(struct i2c_client *client)
>  		if (ret)
>  			goto err_poweroff;
>  
> -		indio_dev->trig = iio_trigger_get(data->dready_trig);
> -
> -		data->motion_trig->ops = &kxcjk1013_trigger_ops;
> -		iio_trigger_set_drvdata(data->motion_trig, indio_dev);
>  		ret = iio_trigger_register(data->motion_trig);
>  		if (ret) {
>  			data->motion_trig = NULL;
> @@ -1508,6 +1504,9 @@ static int kxcjk1013_probe(struct i2c_client *client)
>  		goto err_trigger_unregister;
>  	}
>  
> +	if (data->dready_trig)
> +		indio_dev->trig = iio_trigger_get(data->dready_trig);
> +
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret)
>  		goto err_buffer_cleanup;

