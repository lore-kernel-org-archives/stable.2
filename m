Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B733BBD7;
	Thu, 17 Sep 2026 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605333; cv=none; b=Q1+1bhebYjdUMsgLTN5A9ymbRUbtBRrbG00Gk/7fWjjuTIp8C18hms/FEyS9TY+ZQ3lLYTDeIkO7zD4a8jXb32N3H4pfrLGezSIonKZvDaEsYsM+pxnvcJ30akibi4wBldgg1S83Ij2/F8vzzdkykbJyk0sVCGktIdx8KRQJ1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605333; c=relaxed/simple;
	bh=2/tdqlw6vXtO24iaDv7futA5HHSvR37f6H9D1F192nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Co8++7qDhzRr62QMMz/D34zTaGOUh52w3heJHRTjf17CI21P7sWbq4GwkbbrFzKpdP2JvjJJk0SR405lXp3TX13J4RzkmjkNX1tK1HsBgJkB/ZtAEgXmpie+NcaPe0SlUnDRNkzFj3taOUMMPaT62H0OlwzbakI4MD08OKKjMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5fL7zzn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5fL7zzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E5A1F000FF;
	Thu, 17 Sep 2026 00:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605330;
	bh=PYQ4YR8JKG2CF8G9dEZ1LC5DzF2Kh+srf0yaNn7gBAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K5fL7zznlygisp113bqOqBLQQJG4kZTyzWOiUakcf8heHFe14OVocS5PSg/okN9b4
	 gPElV/fFWTwi5ZRXBDT1DdAD59yeHyR4iBBK4zKG0HLQ0yFExx+iBpCglmIsZq4hoW
	 F2/X7a+Jvsp5obrEkctN7v6tFTMhqY61oqjcuR5USinM/2SV0hd722UrcXzHIwgKc4
	 T9HOBjwBlfYlM9NNCYutzrfrU65hLg7wOOyXVeAAH/3JxEEUgzK/ivDAFQHvY5Qq44
	 t3IeS7uXpI9JvAXQBISz1yHxSzzR89J/ZqY3xBr8Nk8eLiihgRUdeyo4mFGufeT777
	 e6NRa6DpjSFuQ==
Date: Thu, 17 Sep 2026 01:35:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, gwendal@chromium.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: acpi-als: Fix trigger reference leak in
 acpi_als_probe()
Message-ID: <20260917013528.137c154e@jic23-hlaptop>
In-Reply-To: <20260916163440.2084089-1-vulab@iscas.ac.cn>
References: <20260916163440.2084089-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:34:40 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
> devm_iio_triggered_buffer_setup() fails before setting that mode, the
> reference acquired for indio_dev->trig leaks. Move the
> iio_trigger_get() after the buffer setup succeeds.
> 
> Fixes: 24b84444eb6f ("iio: acpi_als: Add trigger support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Same again.  Not going to introduce subtle ordering fixes like this.
We need a comprehensive solution with appropriate changes in the
IIO core to handle cleaning that reference up. See bma220 for
more on this.
> ---
>  drivers/iio/light/acpi-als.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index ab229318dce9..ad95057d99c2 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -206,11 +206,6 @@ static int acpi_als_probe(struct platform_device *pdev)
>  	ret = devm_iio_trigger_register(dev, als->trig);
>  	if (ret)
>  		return ret;
> -	/*
> -	 * Set hardware trigger by default to let events flow when
> -	 * BIOS support notification.
> -	 */
> -	indio_dev->trig = iio_trigger_get(als->trig);
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      iio_pollfunc_store_time,
> @@ -219,6 +214,12 @@ static int acpi_als_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Set hardware trigger by default to let events flow when
> +	 * BIOS support notification.
> +	 */
> +	indio_dev->trig = iio_trigger_get(als->trig);
> +
>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
>  		return ret;

