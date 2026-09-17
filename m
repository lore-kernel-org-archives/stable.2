Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935030EF8F;
	Thu, 17 Sep 2026 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604770; cv=none; b=ndHTQ2km1bUsk7D/mC5EreYASz1Bvbre4nmQwh3eVX+XeUhY8LFgrLwFq83wNQ1H8hl0eOl6kdCgFuCFvgpdFXhdAyVKpimm56T+M6mvUzSU0Z6BlQIlpDyjiWQg88PIxgcAckrg5r+csdV1gCUWKqmf1gnuup+gyrW+bqw9sjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604770; c=relaxed/simple;
	bh=N6mqyraNxHbKjeiFEqD7bbVJa7TEbcbvlDyI/boVG5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZNDZU8fZ4od4JkuTx+cNqq4BNTjz6yf2jwdjqVquSSuIuha4ZryFTxQWJPorsoQlB+ezXg3Ovhk7d60v6zZwYvyGgue3m7ZDMF44J+c3UuvO0qIPrVwBAhE4zz6qNka8uiFRoUqKLPmr8MkCQUe/iRlUoqhFGqm5MuYN2DIGlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaQkSw44; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaQkSw44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24181F0089B;
	Thu, 17 Sep 2026 00:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604768;
	bh=xwAw7d6XTK6a2AZ2uS5qMiHyqkeHdQwEp29Kgf3/IdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DaQkSw44gNs9lFiXTUN/71Xm6EyiZ2KFVNN+R8xFy/Avv9D+8RtzeNW/XfZXrIyoS
	 qAXRCRS4IspKvPficdevVANSAWc6aBOKYWct7FUqmhJ+7xUIoYRIZpKYNpPCBS/PUU
	 XzlZiaHU+nEO1mI5HnWF1DKEkDueRPTRxCuqsgY8JSjCXvgaI6q4lL7DugJSkglj/P
	 V5HKLSnmsXqXxHh065KABnqT7wkjYQEfJgrjSR5CUetb2WK/gRFRKo+VhqOw7rcDbF
	 TioV+DuJxQaitlEbSq9Gz08GUd93qdkPj0sgrsq9nw26yqHS0/BcpKMCaT3/QAsSLf
	 dRXw6/ZWHJnAQ==
Date: Thu, 17 Sep 2026 01:26:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, dlechner@baylibre.com,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, stefan.popa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606: Fix trigger reference leak in
 ad7606_probe()
Message-ID: <20260917012605.690b430e@jic23-hlaptop>
In-Reply-To: <20260916161454.2082753-1-vulab@iscas.ac.cn>
References: <20260916161454.2082753-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:14:54 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
> devm_request_threaded_irq() or triggered buffer setup fails, probe
> returns before the mode is set and the trigger reference leaks. Move
> the iio_trigger_get() after those setup steps succeed.
> 
> Fixes: cc49bd1652a4 ("staging: iio: adc: ad7606: Add support for threaded irq")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
As in bma220 though slightly different reasoning.

No to this as too magic to rely on ordering. Needs a better fix with
the registration state transitions handle in the iio core. There
should be no such ordering constraint.

Jonathan

> ---
>  drivers/iio/adc/ad7606.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index d9271894f091..2deef474001b 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -1638,8 +1638,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		if (ret)
>  			return ret;
>  
> -		indio_dev->trig = iio_trigger_get(st->trig);
> -
>  		ret = devm_request_threaded_irq(dev, irq, NULL, &ad7606_interrupt,
>  						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  						chip_info->name, indio_dev);
> @@ -1652,6 +1650,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  						      &ad7606_buffer_ops);
>  		if (ret)
>  			return ret;
> +
> +		indio_dev->trig = iio_trigger_get(st->trig);
>  	}
>  
>  	st->write_scale = ad7606_write_scale_hw;

