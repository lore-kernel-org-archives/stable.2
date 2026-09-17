Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A5A31D757;
	Thu, 17 Sep 2026 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604943; cv=none; b=FPp6yK6VvQvQMj0MYdykWxqG1d+xiUBlr7Qqyteo0oA7a3Y0QmkNmPWMy9xsjQxr8KBcnT+k1sKtPEC16RSJ0eAvHC5q5NeeBJAmTIQhtEhDigx+DyfkGgjeXttZht/nrdrDhak4EtVdRPfe+XAIG2Jt+ant3+l/ObctAD6s7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604943; c=relaxed/simple;
	bh=TRy1PUNasRVwkYSlTt5qk4x3l7cIh7uCYR0Mde1zmoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEuQX8ixIfl9U78lcF/bcsuXvaikncjyKSfdtZ4sPZIdHuhzr/y7DoMKpGsYwZgs/cfdFGVVMwyRJEXZxJFiSSPErx4zjdJiVzJk2eHbTjdqhVu7d0LgJSXomksJvrvNyQiCjnvKNrefYO47QtT4Yhpxe5SKE14N/+z3jrevCGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZopQAukQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZopQAukQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497DD1F00893;
	Thu, 17 Sep 2026 00:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604942;
	bh=WBql50X31UgWUtE6mUeLjrojGnxYgb8fl4fWJqipAGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZopQAukQP1yDl6FOpaPcv56Votdc6Zi6j6nP/CGFD7xn+iLqDdY79abKpCtp3N+9K
	 eJrY0Ct1J4UyYzjWFPhKAT9/T/5X8QWno3VbpIfwj00EmXa3b1+0TTW4/x4bAzYd6v
	 ohkF5Iz6WH0JgUOLb6iF33c4wdlRc2WBRUoEV7o7BHFoLb+GI39Kad9VuYg79Mzxg1
	 2gJQks70cfpov/dfxcalHm9KxVPcYM5AxsVxNinp+moOZqpIGy8KvcEUsLqQFfpa+g
	 J0L22vK+xjjeieFIh7WakQf7LIv9uEwTOo2+VngcTc+h4Nps+wgO+UEj2xhlfliQa8
	 XoX1JWdRhN5+g==
Date: Thu, 17 Sep 2026 01:28:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Michael.Hennerich@analog.com, andy@kernel.org,
 cosmin.tanislav@analog.com, dlechner@baylibre.com, lars@metafoo.de,
 linusw@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: addac: ad74413r: Fix trigger reference leak in
 ad74413r_probe()
Message-ID: <20260917012859.4007a80b@jic23-hlaptop>
In-Reply-To: <20260916162251.2083286-1-vulab@iscas.ac.cn>
References: <20260916162251.2083286-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:22:51 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Every failure
> between trigger registration and the triggered buffer setup returns
> before that mode is set and leaks the reference acquired for
> indio_dev->trig. Move the iio_trigger_get() after the buffer setup
> succeeds.
> 
> Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Not this solution.  For anyone interested see other replies to similar patches.

> ---
>  drivers/iio/addac/ad74413r.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index fe930ce5ee30..380900bf6772 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -1397,7 +1397,6 @@ static int ad74413r_probe(struct spi_device *spi)
>  	indio_dev->name = st->chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &ad74413r_info;
> -	indio_dev->trig = iio_trigger_get(st->trig);
>  
>  	ret = ad74413r_reset(st);
>  	if (ret)
> @@ -1467,6 +1466,8 @@ static int ad74413r_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
>  	return devm_iio_device_register(st->dev, indio_dev);
>  }
>  

