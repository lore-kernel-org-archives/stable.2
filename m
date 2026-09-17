Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631731E821;
	Thu, 17 Sep 2026 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604809; cv=none; b=JIcRqML7vc+ptMiYe29iX9r4kb4b25G+BcTA3DDhPSkoymiSH+2dqiT7r0LtFtK9kpdJWoaRYPVVuIm7v8+HcIW6hPpUs+VJ+f/AtNnNnsodMFNW8x/HnZQg1aB2+8+vGTKm5thBtNNKck/ZxeZQo1fRFyUGpEKGMr2Tn7Zu5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604809; c=relaxed/simple;
	bh=h9TJwS8nCx7kV1MVGinU0lu576oVq4GWrB1rstQ3wvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwQIHLNXu5Dl2SC1dClDJMEfWNiZ0VaMKhs+bg7GXcSvWG1i0/c5Of8DmoTjqqJvc8ZSR7Eiwl1TTVRDcjb9l7RBFbm62fIzmRI0ethfSByguMnirOKiMvFZk0Ro5MbA9l2RI9cazbLVAbQJzNweQQMip5CWRrIyEd8+NfPAk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkFLbOFO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkFLbOFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C3B1F000FF;
	Thu, 17 Sep 2026 00:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604804;
	bh=hfy7vbr8JPQdnK5NfEjArmN3kPCBqvkh2IJ+7bAbpWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IkFLbOFODORGyRfM/O1bcKWlOd606LdHL//mhxGmx4kbeme5s5TXeS06E4YudCmac
	 4IrlujpM1Eza49dED1Y/NlsoXz670lJ+aDLLBbxN/j1V8u570PvLE6F1ne70iNdYH4
	 z0Fx7REQFSMM8+CNFtJfmWvPKAaYFxZuMaF/6nv832WuGnQjn5pqEx5GUFtM631N33
	 801txWlt+V0LEf8/JsOan8SMbiX5PLhX6yPfw+CsJ8eWUFol21VaQhOqfnwRc4FF3j
	 Xf/tMUnjDh70yls5PeKcGatGlh0p4ykTanZ33csKQxC+52Eg6AbovE6qTjVD6eGpiv
	 6g7Qh2gQByr1w==
Date: Thu, 17 Sep 2026 01:26:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, dlechner@baylibre.com,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, stefan.popa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7768-1: Fix trigger reference leak in
 ad7768_triggered_buffer_alloc()
Message-ID: <20260917012641.282a948e@jic23-hlaptop>
In-Reply-To: <20260916161726.2082904-1-vulab@iscas.ac.cn>
References: <20260916161726.2082904-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:17:26 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
> devm_iio_triggered_buffer_setup() fails before setting that mode, the
> reference acquired for indio_dev->trig leaks. Move the
> iio_trigger_get() after the buffer setup succeeds.
> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Not this solution. Same reasoning...

> ---
>  drivers/iio/adc/ad7768-1.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 73fb734d06b2..94e746c78cd8 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -1505,12 +1505,16 @@ static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &ad7768_trigger_handler,
> +					      &ad7768_buffer_ops);
> +	if (ret)
> +		return ret;
> +
>  	indio_dev->trig = iio_trigger_get(st->trig);
>  
> -	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> -					       &iio_pollfunc_store_time,
> -					       &ad7768_trigger_handler,
> -					       &ad7768_buffer_ops);
> +	return 0;
>  }
>  
>  static int ad7768_vcm_enable(struct regulator_dev *rdev)

