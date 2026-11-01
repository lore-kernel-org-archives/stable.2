Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793557413;
	b=XiQRxfT2GBvldAJmMSKl4lRMqP7IAfVJ1AWdkBH14oyRBcAZpefRCFUA7B8u2VH+fG93
	 OuIrtMCX6VxgFjXm7Vec/Pff/LX+6fn9gxmb2UCsT+Sqy59l4tFUII3myUObvGXmY+Qq9
	 2X7HS9I4XADXNR16N7j+GGTzCC3rQbYpK7/KpoSCDFjO+pmoq+o0qgmO78fOa13HIfr0E
	 7+XnISefyww1ziog4nrmC5Euw1cvFlUWihJ5UG2U3+6JKyW5UjQ97ktdZRguz6ZZCmQsP
	 qIU3tnvFSn8VjuccqdCtRfB8EsWO4Y5gJ54SuWrlqtPOjE04RIBw2y53ggHJUJc/4rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793557413;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CexjKfWtjIoJ9DgljIXuFJ9dsvppgQJpj8XKTnS3YHQ=;
	b=3B7V+xiwm0p3f4ipSOw0zzubDUzuTrlh5mmRQ0U/vy5UIwLRX92JAgOcjC6dWXuCixbz
	 KktK2lbjtSS/DyAdGVaW6snAjDRmuiImkqnoMMQ9outUZ7msHIb5PYNjfgMiYDFvT1ARV
	 B0VNf1eQAOcnBqMpoI4o4V+9jjj+7CUuOYhwlImu7LbozrzlbAcrb6KeB34r7Jm3CdcoL
	 uYI4Ri2Y5NmcXEJwF04VHTapzTlveQNKT0TX7J8+XWk/ie+ODZzK0BEMIY36IQoklYvtR
	 SG+bFZa4UgtC+B+DPwbZMIPNoLjqr1WJuV0a90wd1cBRilYXLR7LEdnxi2/cdpp30MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmTNwo69;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFC606A324;
	Sun,  1 Nov 2026 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmTNwo69
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BD01F000C1;
	Sun,  1 Nov 2026 18:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793557412;
	bh=CexjKfWtjIoJ9DgljIXuFJ9dsvppgQJpj8XKTnS3YHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dmTNwo69zFaCQXvC/ED/42xUCxYEr/xQsy2LxIsKvTi2TRX3v8wEwDsVnAxL6CVjl
	 qtEurOKeT21839/CyOwj4Aq12+04zJhvqZNTzDT2qEz8BYc8WoMFNMUsfNDMW/lNKq
	 hFzYQP0O9zvIGcxx39lBVxPHe+2qd/OTBh8m127Aq2wKQHBdDx+KgvX9U+ygE2oTOs
	 47r0axbU1cHMr9ZKL0h4Jd8Q4rOtWkWtX31Gj2ZaJYI4yuAVOsU1p3S5inoszvChHP
	 J53DpCPpq8KMYouvTVyIk5SBeer8/1hO3sqxPR4Ub26fuTgjKQXXmGiR2Hb7pi+zNn
	 s9t0soY4Sz7KA==
Date: Sun, 1 Nov 2026 18:23:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Liu Yufei <lyf98405@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Gustavo Silva <gustavograzs@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: fix zero timestamp in triggered
 buffer
Message-ID: <20261101182327.4fd27ceb@jic23-hlaptop>
In-Reply-To: <20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com>
References: <20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com>
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

On Wed, 28 Oct 2026 10:59:26 +0800
Liu Yufei <lyf98405@gmail.com> wrote:

> When the device's own data ready trigger is used, the trigger is
> polled with iio_trigger_poll_nested() from the threaded IRQ handler.
> In that path the pollfunc top half, iio_pollfunc_store_time(), is
> never run, so pf->timestamp is left at zero and every sample pushed
> to the buffer carries a zero timestamp.
> 
> Take the timestamp in the trigger handler itself and drop the top
> half, so that a valid timestamp is provided for all triggers.
> 
> Fixes: a1854d55f54b ("iio: imu: bmi270: add support for data ready interrupt trigger")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liu Yufei <lyf98405@gmail.com>

Firstly. Do you have a setup where you actually care about this, or is this
found by reading code / LLM etc? If nothing else that changes
the urgency.

This is an old problem. I really need to find some time to write
a more consistent solution for timestamp acquistion that would
indicate if we have a better timestamp or not and stop this
being a driver problem.  We used to avoid this by having most
triggers go through the irq_work dance but that was considered
too much of an overhead.

As Andy suggested we do want to grab the timestamp if appropriate
in the top half if it is our own trigger (the one registered
by the driver) because we then know it is the best possible
for a dataready trigger.

The way some drivers handle this is to check on whether the
trigger set is our own or not. Now ideally we'd do that check
in some helper code, but writing that is less than trivial
(which is why I've not done it already)

https://elixir.bootlin.com/linux/v7.3/source/drivers/iio/light/rpr0521.c
is an example I found with a quick grep, but perhaps not
coded in the cleanest way!  So take the idea, not necessarily
the implementation from there. 

Jonathan


> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index fbcf6bb87acc..40ed1ee5ac58 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -840,6 +840,7 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bmi270_data *data = iio_priv(indio_dev);
> +	s64 timestamp = iio_get_time_ns(indio_dev);
>  	int ret;
>  
>  	guard(mutex)(&data->mutex);
> @@ -852,7 +853,7 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
>  		goto done;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> -					   pf->timestamp);
> +					   timestamp);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  	return IRQ_HANDLED;
> @@ -1630,8 +1631,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					      iio_pollfunc_store_time,
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>  					      bmi270_trigger_handler, NULL);
>  	if (ret)
>  		return ret;
> 
> ---
> base-commit: 09f742b49cb2728086d78be2b0b35e4d1d71fc85
> change-id: 20261028-bmi270-fix-timestamp-48a194b69db1
> 
> Best regards,
> --  
> Liu Yufei <lyf98405@gmail.com>
> 

