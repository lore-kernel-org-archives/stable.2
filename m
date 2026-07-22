Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72673248873;
	Wed, 22 Jul 2026 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784685852; cv=none; b=tjo59goKu5W4eYsDclGPljlvQ2CkMwuZOwIngoVHnnA1NiRHkYWrV22UtMVahmVsV7u3ASNlI0v+TJYfwsvn4PkGb0N9OA/PttywA6F0ZajZlgE11safVA4Q/Gx8rBOhJj8M8FyvttjGmYVSKbM7MRebGFr+70tibu/GndN1BKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784685852; c=relaxed/simple;
	bh=UnVTEwcjPVOZvCwX9K03GRjB3gCHNi9RWsdXLoLBpV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cb1nmH/OoLXO4LUD5I10CBIRvRgQT7zpqas4GiztcWSk29BKgbzQp9q8LNfbpN4uK7OXB0MH7rUqyVL0Ic7rwPUwmlMoLpmcGvNDiN+Rln1jH5begXyvHQoh9sLcS02SLwInAQtP+Qn2oT9V5WVwE1YC/ncvzQwoB6etv/FoD/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHRFTlAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHRFTlAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F801F000E9;
	Wed, 22 Jul 2026 02:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784685851;
	bh=c4v2DAi58BS+p+L62H1QuPTRuXHKwUs/iomsNJwB9JE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IHRFTlAGHg/NvThuaPrZs9E+SK/jo8X2XLMEFypcmhEjM/akBgIWyxcePkBkGBFyC
	 4YEzRP2T6804OpzB5Fynnr5EjJvIGROqhysCmACp/5FVhfPgvIPFtqPp830XYwF/HY
	 CBZQeyT4p8cMH3PxyHTy/nTD+02Txd0BaFsjEkFLNiLBQ4Mf6jdDoULO0PER+ycTYN
	 KKVHV+8ejvLNQQKT8E1JB8pSilIQv3GsdbtSTO8C7H+nYFniGiOcdL0xgZlHUhOl5r
	 5LPDgv/qGXOkhMRb+D1twN4+gA4Awj+fFaTj2yIaYgDSyQ1frqyd5LlRMNjN54SsVI
	 MGhgFvH1muwZA==
Date: Wed, 22 Jul 2026 03:04:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH] iio: chemical: atlas-sensor: fix PM reference leak in
 buffer postenable
Message-ID: <20260722030406.00fde81d@jic23-huawei>
In-Reply-To: <20260713030046.21143-1-mokshpanicker.7@gmail.com>
References: <20260713030046.21143-1-mokshpanicker.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 03:00:46 +0000
Moksh Panicker <mokshpanicker.7@gmail.com> wrote:

> atlas_buffer_postenable() acquires a runtime PM reference with
> pm_runtime_resume_and_get() but returns the result of
> atlas_set_interrupt() directly. If atlas_set_interrupt() fails,
> the runtime PM reference is leaked and the device can never
> autosuspend.
> 
> Add pm_runtime_put_autosuspend() on the error path to balance
> the reference.
> 
> Fixes: 0e4f336f50de ("iio: chemical: atlas-sensor: Balance runtime pm + pm_runtime_resume_and_get()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
Hi,

I've applied this to the fixes-togreg branch of iio.git but Linus has been
pushing back on less critical fixes late in cycle so I might shuffle things
around to queue this for the next merge window instead.

Thanks

Jonathan

> ---
>  drivers/iio/chemical/atlas-sensor.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 0e2edcff63f9..b2c1a598b3a5 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -413,7 +413,11 @@ static int atlas_buffer_postenable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	return atlas_set_interrupt(data, true);
> +	ret = atlas_set_interrupt(data, true);
> +	if (ret)
> +		pm_runtime_put_autosuspend(&data->client->dev);
> +
> +	return ret;
>  }
>  
>  static int atlas_buffer_predisable(struct iio_dev *indio_dev)

