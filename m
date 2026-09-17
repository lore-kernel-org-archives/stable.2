Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394D315D53;
	Thu, 17 Sep 2026 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605648; cv=none; b=u2/FGTd9N/W994p6jm93O80vMxv0eYn6F87m1Jd53G+uISNZBdAhf60zACrQ9Zi8wUM+YwoFZj+r/5AflMIkDgAxKDXSEBXUQJRvrxjUPA1SspySngjLGglr8qH0GtV76FS1vQo3S3OFyGXByHorXdkIDu2ofecq9uhrdKMnHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605648; c=relaxed/simple;
	bh=53fQJtWaglbTzYvtW1itQmUmK3y5fQPMcjBjBJCLpb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1Oz2oZbCIjJHkamjU5K2Aa3bbiyUJQY+F6fjA0gVzwTff8SrNTff0lBlmb1hLZxGekfkF4GceQ5KOR+rM38OAA83d2B8yz6n5dHzxhRk3ScFyybqoMFu1VFZoursFCr0Hr6DTjozhC0zB03ehizA03QNktjnTt6+6dncPFG2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeG2uQOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeG2uQOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CF21F000FF;
	Thu, 17 Sep 2026 00:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605646;
	bh=x7PZzSgSd7bhRvjxdxDYadQIgM+pPnZzijQbH933b7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VeG2uQOaE6bl3ZgltdIsLIABmGIOucAyb+QtaV092jcfj/B/F7gFM7pRR7QSF5PS0
	 NEVNQq8QrxhO5KWw4Y1L8pWj1/scSfhZDcuE6crzh3fM3OL3XKoS0U8X/U4qhGMykX
	 oWcmXyXlJHSrCgOHuSxFqhm/N0QCAzfbzHgeW898fn4u2Ma0py/4/L2HOkK6hHcCP5
	 TPLh98/xJ8am1ioUoj80a+w5xzzyD5dtqhw+Nbnj0TvtZoGSy3TXZa2KPTlERnddOE
	 nxrcK2mkfO51EyA4J9QLF4VnNCEIZcMaEKI6sWopTVvsXGdY9u8UfaZvkGS2ctvXty
	 SQniwDp6+ip0g==
Date: Thu, 17 Sep 2026 01:40:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, apokusinski01@gmail.com, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tmp006: Fix trigger reference leak in
 tmp006_probe()
Message-ID: <20260917014044.4f72b35c@jic23-hlaptop>
In-Reply-To: <20260916164517.2084799-1-vulab@iscas.ac.cn>
References: <20260916164517.2084799-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:45:17 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Failure of
> devm_request_irq() or of triggered buffer setup returns before that
> mode is set and leaks the reference acquired for indio_dev->trig.
> Take the reference only after the triggered buffer setup succeeds.
> 
> Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Not this way - see other threads on same topic.

> ---
>  drivers/iio/temperature/tmp006.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index d8d8c8936d17..06303ce72bfb 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -354,8 +354,6 @@ static int tmp006_probe(struct i2c_client *client)
>  		if (ret)
>  			return ret;
>  
> -		indio_dev->trig = iio_trigger_get(data->drdy_trig);
> -
>  		ret = devm_request_irq(&client->dev, client->irq,
>  				       iio_trigger_generic_data_rdy_poll,
>  				       IRQF_NO_THREAD, "tmp006_irq",
> @@ -369,6 +367,9 @@ static int tmp006_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (data->drdy_trig)
> +		indio_dev->trig = iio_trigger_get(data->drdy_trig);
> +
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  

