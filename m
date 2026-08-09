Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D0A222565;
	Sun,  9 Aug 2026 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786318094; cv=none; b=nrmw6MdtMPtXC/oljRHUVsn/7LFNcZTsccDzk5QKfm5j2gSmK2IYQl8uTIGpWmwKx/L3ayUIFaRjJmOhP1pBXgOGLSn3TAwumO8yl+mroxY7ZHrWeSENAT/pvvFBxPsLwnwBqvWdpXwSaNCk6j5nEa5y9fVJ7nsv08s4JCJSbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786318094; c=relaxed/simple;
	bh=UgfDfv/MSaEeDErIQFn5rtYlb08X5OdCexAgdOUNTWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkUaMwcnTrH7zlNhK0HBfrcHh3OSAOW0H5Vmw3nCIVIxRv9n1wNn9ApYAs9vyPcmP/7p6Z9SbaLqe6+o+pXVy2dFwq7qu3xAKxJNqK3XvdyRPy13b53VG5plcd7khDO+QKHpgkAsRnRuUeUavEuVFoS0g3azohnzLPq38ovU2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvDL/Ome; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvDL/Ome"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0211F000E9;
	Sun,  9 Aug 2026 23:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786318093;
	bh=/RncMP6M85Qmbz1TeuX/uNlmy2ZKLguz76lvniqrQcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AvDL/OmecrWsh6Ff4AirabWiIW+Yysnxe2V8bHTBNAcSWLOt9Z7CgUSR8IzAoWa5c
	 G/Z1GOndcR0t8cXH36MErHrLPdPFjrHDxQW0KzhaP4d7T+XEtHNjW85RT5TSFbRrxU
	 hm1bZ2ypBeC8ZWj8bf4HOTnjk7m1MPPbgz/SZo/m3MQrkQrtz6zMuirn787lWPZagz
	 RiH6wCPqJhVTY52E4YZNqnkUqABc8jIf7GyJshRi0+Stabt+GuImNvddrQ1nB3bn2h
	 ttKm845/UCFqD+dCWFTAMx7X7jBe5XWpnFjQXKP9f2sEtsjMmBjqrxsuNkRmU07wxi
	 LNf/2u3suYLQw==
Date: Mon, 10 Aug 2026 00:28:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Ramona Gradinariu"
 <ramona.gradinariu@analog.com>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: adxl380: clamp FIFO sample count
Message-ID: <20260810002808.76ffd95a@jic23-huawei>
In-Reply-To: <20260809-adxl380-fifo-clamp-v1-1-780d86ef25eb@cherr.cc>
References: <20260809-adxl380-fifo-clamp-v1-1-780d86ef25eb@cherr.cc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 09 Aug 2026 06:18:51 +0800
"Shengzhuo Wei" <me@cherr.cc> wrote:

> The FIFO entry count is a 9-bit device-reported value and can therefore
> be as large as 511. fifo_buf[], however, only has room for
> ADXL380_FIFO_SAMPLES (315) entries.
> 
> After rounding the count down to a multiple of fifo_set_size,
> adxl380_irq_handler() uses it directly as the length of a bulk FIFO
> read. If the reported count exceeds ADXL380_FIFO_SAMPLES, this can
> overflow fifo_buf.
> 
> Clamp the reported entry count to the size of fifo_buf before rounding
> it down.
> 
> Fixes: df36de13677a ("iio: accel: add ADXL380 driver")

In my opinion at least, these are not fixes. In general we don't expect
drivers to be hardened against broken hardware returning out of spec
values.  I don't mind taking simple cases though that don't complicate
the code much and if anything make it a little easier to follow,
but I don't currently see any reason to mark them as a fix.

So drop that tag for v2.

> Cc: stable@vger.kernel.org
> Assisted-by: GLM:5.2
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
>  drivers/iio/accel/adxl380.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index 7dca5523091fc4c6a3c3bf7e388d5d0d507bee19..8a9d82e1d882aa45721013590ecbd86b083a15a6 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -966,6 +966,7 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
>  	if (ret)
>  		return IRQ_HANDLED;
>  
> +	fifo_entries = min(fifo_entries, ADXL380_FIFO_SAMPLES);

This is papering over what we think is a hardware failure. Unless I am
missing something the device is returning garbage, otherwise we are in
range and this has no affect. We have no idea how much data there is
if we get a value outside the expected range. 

As such I'd expect an error print and probably no attempt to carry
on reading as we have no idea what happened.

>  	fifo_entries = rounddown(fifo_entries, st->fifo_set_size);
>  	ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA, &st->fifo_buf,
>  				sizeof(*st->fifo_buf) * fifo_entries);
> 
> ---
> base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
> change-id: 20260809-adxl380-fifo-clamp-f07a570d96b1
> 
> Best regards,

