Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13526B640;
	Wed,  1 Jul 2026 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864257; cv=none; b=j61YWnHO9vXHh94Vf6E8pvPzahpTR20IUGQLCMmGu6Gzs3yVfo+gCm7EgklP/JcZaJzoXqesyE8QNCIPtt+Pxx/xrgGnORYBV0B8qVy6dhc+A+GH7e7c7ngwlW40W8s57Ld/yW9eajmJ5VEbTRMW1v8qBiM7Q13KqachKelveNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864257; c=relaxed/simple;
	bh=Gni2YfNSHDKoZtWC1Kgb1yuwCOMZ1Qs5Fc8JEyzlMlA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyhIRpdkio1O30E5nUc1euQVdWc4Z42/8Hh+ByTOW4oS3ZtInGZr/FrY1wS0HLZ+FlXIfd/GaWEzOhrgtBgnAVudsCI49hMgLVm4YjAXBFIuVOjjaluWkyvX37JIQZUDs/Ghr2OF8s478wbIecV4a7BM/e9apgJXaYhhwP9bYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6zmRfJl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6zmRfJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F661F000E9;
	Wed,  1 Jul 2026 00:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782864255;
	bh=wSuX7oOz4l6RtucKBz0dBwYpIzI2t1e1F30Dh2OSyy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V6zmRfJlVKt3v2EFt6NmXMvgomW2fLilJPpaD0jWGYHls+FNWWjUtmn1ZFjj7vIdM
	 UhXCDHijl7gMc9rk/OfRyAIS76AqgNd76mU7PguSJrnrBVU+TC4i5t0sKbqG8IR1uP
	 OrLOD73Gk9CdMZfj0D9d7NK4qgpqPfUgkWme/Gi2MUJcR4MSI5F17PtjmIea4DjB6W
	 RCUSrkVc8I1QmH2wOXRb6Etf20oMLGusSOrDsP8swZC3F82Nbl2B+gn53om5c88rqn
	 hBjoz5Z0WQZ9jVoqCVwmdIcI0pevMCQ9wt+7lUxkxzdt+os2bAczzq+fY2KIqDutNC
	 nwehzglT5VP3g==
Date: Wed, 1 Jul 2026 01:04:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iio: dac: m62332: Fix regulator reference count
 imbalance
Message-ID: <20260701010410.59ae003e@jic23-huawei>
In-Reply-To: <20260630021309.36636-2-erick.henrique.rodrigues@usp.br>
References: <20260630021309.36636-1-erick.henrique.rodrigues@usp.br>
	<20260630021309.36636-2-erick.henrique.rodrigues@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 23:13:09 -0300
Erick Henrique <erick.henrique.rodrigues@usp.br> wrote:

> m62332_set_value() enables the Vcc regulator on every write of a
> non-zero value and disables it on every write of zero, without tracking
> the channel's current state. Because the regulator is reference counted,
> changing a channel directly from one non-zero value to another enables
> it more than once, while a later write of zero disables it only once.
> The reference count never returns to zero and the regulator is left
> enabled indefinitely.
> 
> Only enable the regulator on the transition from zero to non-zero, and
> only disable it on the transition from non-zero to zero, using the
> previously stored channel value to detect the edge. Balance the
> regulator on the I2C error path so the reference count stays consistent
> if the write fails.
> 
> Fixes: b87b0c0f81e8 ("iio: add m62332 DAC driver")
> Reported-by: Jonathan Cameron <jic23@kernel.org>

I was just passing on Sashiko's feedback so this should be
the appropriate stuff for reported by Sashiko + a link to 
sashiko.dev entry for the earlier version.

> Closes: https://lore.kernel.org/r/20260419144958.03394ed5@jic23-huawei
> Cc: stable@vger.kernel.org
> Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
> ---
>  drivers/iio/dac/m62332.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
> index 3497513854d7..b66b4c28859a 100644
> --- a/drivers/iio/dac/m62332.c
> +++ b/drivers/iio/dac/m62332.c
> @@ -43,7 +43,7 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
>  
>  	mutex_lock(&data->mutex);
>  
> -	if (val) {
> +	if (val && !data->raw[channel]) {

This is a little fiddly to read.  Perhaps a pair of local booleans
would help.
	bool enabling, disabling;

	enabling = val && !data->raw[channel];
	disabling = !val && data->raw[channel];

>  		res = regulator_enable(data->vcc);
>  		if (res)
>  			goto out;
> @@ -52,14 +52,17 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
>  	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
>  	if (res >= 0 && res != ARRAY_SIZE(outbuf))
>  		res = -EIO;
> -	if (res < 0)
> +	if (res < 0) {
> +		if (val && !data->raw[channel])
> +			regulator_disable(data->vcc);
>  		goto out;
> +	}
>  
> -	data->raw[channel] = val;
> -
> -	if (!val)
> +	if (!val && data->raw[channel])
>  		regulator_disable(data->vcc);
>  
> +	data->raw[channel] = val;
> +
>  	mutex_unlock(&data->mutex);
>  
>  	return 0;

