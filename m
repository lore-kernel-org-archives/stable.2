Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09A70808;
	Thu, 17 Sep 2026 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604251; cv=none; b=PV/l8J5A5FdJmi2F80xRk5NKJYzpKxcWVT9hrQ96i8cygquCxc78ZF73naMBfoYs1JqwO+6mCMAQ5kN8CBKFrtggITLFvKz7JFb9aBUIkjdaejcZhmB27tvT6/UxZ37e/M88HE7g31QEyT5k8+WD+bRXFVtT5J9Cbx66uh+VUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604251; c=relaxed/simple;
	bh=mzPuA1fQV5qkl/8c0cAk2YzEESSuS4I3hM6MWCSGOxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ws64fKmH/JcJAyaMsUy+Fb3tXkrJKDAQZDnt/CoFh/z6v++O3xAcOa5utogO8N4SlYRTQcGPbJUDcua9tMQIQ47ixF8Q7ZkOxDrmyxJgor34F4RvtUt0fcJ8gN+f/IRhN4c+PbFhZMInIJPW/B3Ftgv6JA70FgetlphPr50DkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egUi2bb1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egUi2bb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5274C1F000FF;
	Thu, 17 Sep 2026 00:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604249;
	bh=DqxzG1L6JEMezUFwzmXkStm8cvVR3CprkPjx3kJQQVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=egUi2bb1MiUujsb53PkIikzSn6gOqBB5yJ/8GS+NqW7nUPf6HvIXwHxFKMrBm4QC6
	 63jWqcWkfJwT0YEYBkjlYQM5CnBvPdF9jDzB46Jnnwkj0QkXG51CZSk8OPDQdqig1t
	 5wmntZFVyR71uh1WzANlXEeDAvfCo6h5BNpmJkeVQho/QjHJ8eV4N5ikQbscAVEM8M
	 RUb6VtTZKjLQ/bPeT93ocFmNOZvEp1bwvA+R5xk6mHr92CW5sh8IuOQywYu3HgJVFW
	 OI2r79NN25FJ5io7XSLIF2jd0LZ6a5/yPoCA8BbutWQt7YzRgerC0ciEerCmR7Xtim
	 zdi4dZ/S5TH6Q==
Date: Thu, 17 Sep 2026 01:17:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dan@dlrobertson.com, dlechner@baylibre.com,
 jagathjog1996@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bma400: Fix trigger reference leak in
 bma400_probe()
Message-ID: <20260917011724.1b0f181a@jic23-hlaptop>
In-Reply-To: <20260916160825.2082355-1-vulab@iscas.ac.cn>
References: <20260916160825.2082355-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:08:25 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> Move indio_dev->trig = iio_trigger_get(data->trig) after the
> devm_request_threaded_irq() and triggered buffer setup succeed. If
> either fails before INDIO_BUFFER_TRIGGERED is set, the IIO core does
> not put the trigger reference in iio_dev_release(), leaking it.
> 
> Fixes: ffe0ab6a9698 ("iio: accel: bma400: Add triggered buffer support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
See reply to bma220 similar patch.

Not the way to fix this.  A comprehensive fix is needed and that
requires some fiddly changes in the IIO core.

Also, this doesn't even fix it...

> ---
>  drivers/iio/accel/bma400_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 05f72707f830..a5889b67585e 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -1783,7 +1783,6 @@ int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
>  			return dev_err_probe(data->dev, ret,
>  					     "iio trigger register fail\n");
>  
> -		indio_dev->trig = iio_trigger_get(data->trig);
>  		ret = devm_request_threaded_irq(dev, irq, NULL,
>  						&bma400_interrupt,
>  						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> @@ -1799,6 +1798,9 @@ int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
>  		return dev_err_probe(data->dev, ret,
>  				     "iio triggered buffer setup failed\n");
>  
> +	if (irq > 0)
> +		indio_dev->trig = iio_trigger_get(data->trig);
> +
>  	return devm_iio_device_register(dev, indio_dev);

What happens if this last call fails?  Still leaks the reference.

>  }
>  EXPORT_SYMBOL_NS(bma400_probe, "IIO_BMA400");

