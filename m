Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D031E85B;
	Thu, 17 Sep 2026 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604895; cv=none; b=epkt+k41XJIJprA5hwKpCjzt0IIGnxwT4vpEdVIoqiE6Idu+lKRLB5tMK7sxpz1ZzVVFuLkdrYerpZODxehSz7SkdtpoQOrBvUaF2qb4hi3tZqd0U/Em4BkxYDqfGxoAmwYzpOHYWyqTu1/d1JnUvNaHItvLPK1Afdre0Bw0xU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604895; c=relaxed/simple;
	bh=n9Jl++NUYjVk/8CAYUqzLCtOcczDVKSvBoXXviYrOn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOEy9ZPzntaeTEnNapyT2EGZO7yw9D5H+W0doh06/6q9StV4pWKyYvINyXalDS8kkdr9XpkPz+6EfPqfZn7gjeLI6fW8jC8MGi6QHIqW0QA3LHTuqOI8jTCpVqopp1FL8uYL9vRWmzGknsjGECNfCZIdFmg69rIQNlfjzgq+J8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqoH13q0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqoH13q0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502C71F000FF;
	Thu, 17 Sep 2026 00:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604891;
	bh=InfGZMppnShVM6fj4TBSU8aG+A5gwXJyj3QjRlZH4bA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PqoH13q0IFjHgbjNGA8hO1W6M2WKQ6iu/BroNDROB00IjMwgKhqNjSZFcn1sVs8Ka
	 9uJn6fzU5APA06GFe4DVWqYYogj04W4dCgQKCW9xKIc+lccvzVrLfVQRv6xyXlJRMZ
	 Y7l+WLkvhq+biYAhlHGsM4s6apQdiEFSXd0+FnUnK2nThd+JXfeazXCZU4dvbePvar
	 4A0T6W0Wo0Oty+MWEXojU+J3W5MqiKDI1+menmIKEq3TQkHHWyRP+VKqBx0rNZ78Gq
	 lTJoWVi+iFOvl5214Vl63JCDXVV/zEQGMG3bNlzfu8DcNU4QSMma3Dfc4b86KwNdAV
	 1h0Hx2kGkMRIw==
Date: Thu, 17 Sep 2026 01:28:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, dlechner@baylibre.com,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, ramona.nechita@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7779: Fix trigger reference leak in
 ad7779_setup_without_backend()
Message-ID: <20260917012809.77af8721@jic23-hlaptop>
In-Reply-To: <20260916161917.2083043-1-vulab@iscas.ac.cn>
References: <20260916161917.2083043-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:19:17 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. If
> devm_iio_triggered_buffer_setup() fails before setting that mode, the
> reference acquired for indio_dev->trig leaks. Move the
> iio_trigger_get() after the buffer setup succeeds.
> 
> Fixes: c9a3f8c7bfcb ("drivers: iio: adc: add support for ad777x family")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Same again.  Not this solution. Note I'm replying to all these patches
simply because others may open just one of them and not see the earlier
replies.

This is why you send one test patch (or at least put similar changes in a
series).

When something has been obviously wrong for a while in the world of LLM
review, it is worth checking earlier discussions to see why.

Jonathan

> ---
>  drivers/iio/adc/ad7779.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> index 695cc79e78da..76834275b1ca 100644
> --- a/drivers/iio/adc/ad7779.c
> +++ b/drivers/iio/adc/ad7779.c
> @@ -850,8 +850,6 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
>  	if (ret)
>  		return ret;
>  
> -	indio_dev->trig = iio_trigger_get(st->trig);
> -
>  	init_completion(&st->completion);
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> @@ -861,6 +859,8 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
>  	if (ret)
>  		return ret;
>  
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
>  	return ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
>  				     AD7779_DCLK_CLK_DIV_MSK,
>  				     FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));

