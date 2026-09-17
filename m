Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CFC31AA87;
	Thu, 17 Sep 2026 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604921; cv=none; b=QaeNq6nmPMFCsSCZnIB4OulZ11SSrrHAu3OlbwN5UBC518naWScVaP5RfOgVGVu+dfRlSWxBr1xZT0Mh5GDgZdEPTf7qV58a+AtxjXPXpmAK8nqqxPa+FMe6woZ/3GrP+3iGWs9cmPFp+MBL5nJ83L9a8I0r5no6Z4zPqe8uZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604921; c=relaxed/simple;
	bh=+LgqeVTiH4S2tZFRBqpe0Npr++2C05zBRZrY3NveFkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWiJxqek7ZYxE1JwFmoRadBBnTrIvM+YHFVe6T6ZYj6sf2BBJLPbti2OYm9+41yD84u6q8AGTQtJCzALZdhUlZW+Jm16WE6jRGnAEA0ZJAd3XNIbuiv3WUagNXdAavKSrE65zt+4g78C7n8j+reCuFavQ2BvVtBRtO8uVoJcMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUz7ukG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUz7ukG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC301F00893;
	Thu, 17 Sep 2026 00:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604920;
	bh=aqvDKbafJBlzzBLtcdKxP5KjfBDz5ysEsP78P7FEeqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PUz7ukG4KF49DpBfAlReN+ATUomlHv5LX+jZMLtcsgDqQBsKzta6O6LJjg8hSkDts
	 nQOeu6O5pEwdoZr3aD0rM713W4z4FQ9gwTOBc1NDcedXIJzQHXutcUne8ZzN3WWVKN
	 UadNi82IiGfQof6LJBHGnbp6DIDXpGQfG5n818bbOP0CkKoaQC1bB61rk9GK+NjXV1
	 dqe+njTWstvJQl0CENilyLYxBVUSlGGWh2in0W2gg9f1LIkbtaGgNn65otBx45rEob
	 VS0kt4vb5E4E6/RUYJHqdgwl1O7NdDiJkuRF550iNymAVR8zfX2Y3ZRQf6i1xDrpIa
	 C2kelT0+2/l1A==
Date: Thu, 17 Sep 2026 01:28:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, tomislav.denis@avl.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads131e08: Fix trigger reference leak in
 ads131e08_probe()
Message-ID: <20260917012836.444a54ef@jic23-hlaptop>
In-Reply-To: <20260916162114.2083166-1-vulab@iscas.ac.cn>
References: <20260916162114.2083166-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:21:14 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
> devm_iio_triggered_buffer_setup() fails before setting that mode, the
> reference acquired for indio_dev->trig leaks. Move the
> iio_trigger_get() after the buffer setup succeeds.
> 
> Fixes: d935eddd2799 ("iio: adc: Add driver for Texas Instruments ADS131E0x ADC family")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Not this solution. See other threads on this.

> ---
>  drivers/iio/adc/ti-ads131e08.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
> index a585621b0bc3..d976214504c3 100644
> --- a/drivers/iio/adc/ti-ads131e08.c
> +++ b/drivers/iio/adc/ti-ads131e08.c
> @@ -851,8 +851,6 @@ static int ads131e08_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	indio_dev->trig = iio_trigger_get(st->trig);
> -
>  	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
>  		NULL, &ads131e08_trigger_handler, NULL);
>  	if (ret) {
> @@ -860,6 +858,8 @@ static int ads131e08_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
>  	st->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
>  	if (!IS_ERR(st->vref_reg)) {
>  		ret = regulator_enable(st->vref_reg);

