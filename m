Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7532C08D0;
	Sun,  9 Aug 2026 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786318266; cv=none; b=TUyRMZn09moctiW3nSLFfoc5gtcrt+NJ6sU1J/b838Fof/TpLZu/O6o6hOEifeY0YoL8a8PKlSfY7thCTzA52GZl9WyMxsTWOJN8H+rpvOlkCMkjUYNnq3Xhrx6uFGoMWyKUOty7J3wK84Vkakj7XUhktXXeI9uMNZ+O4qkLivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786318266; c=relaxed/simple;
	bh=IM7+SYk+rGmWqE1qhkY/SeZ8qpgEV3KwaUHAx+kY1hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhahCH/PCYyiG4qyGRY0QxQEss1jmDGFyDhQT9gKcdACKgV34YUIN0ObIhNG/ecMUmzWZ8UyxzPGV90CMwT2jF8bymEGleAsUUCXrGkycoIMuS+lFsE9UgjF11rfjS5DX4ZxAlU1/1hOjF415U8gNR+RjZegWEyMu8/xr+Tnq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHbyfhQ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHbyfhQ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539771F000E9;
	Sun,  9 Aug 2026 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786318265;
	bh=WFm50zDkKXzJOqAKehKXwJtF9ALEWVpbeQsvmVeNkG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iHbyfhQ86X81uoofC5S4207G0TtPYxzuTj4hEEG/QO/OVZji26P1cGx5PPm6/MQmS
	 K1rdH/HdQuBbm6zdsVMn/XeneJVk9SKWjD6DFDumL0wcBBIuf7fw0IsEp0K3RaixR6
	 KoNUbCMXfWrW2kN+jIWFFvaJxFLi1DEhmmBy18k0i/Q6qJXNcVCwPdoXbYgPubXcYk
	 tIxewM9mKqpBvkxYHgzTtxnen+9CIw66a0jzLekQ4MWmrdsyBZuNo2MlxhavMub1iC
	 0sZUD1xzpaTy8ddyr4qd/yuRD1o2vollhYSaPVCM14XM14dBcQDL0bfnTLnhqCGYIb
	 0Gdfpfmzuiqyg==
Date: Mon, 10 Aug 2026 00:31:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: "David Lechner" <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Sean Nyekjaer"
 <sean@geanix.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Joshua Crofts"
 <joshua.crofts1@gmail.com>
Subject: Re: [PATCH RESEND v2] iio: accel: fxls8962af: clamp FIFO sample
 count
Message-ID: <20260810003101.3a2d1967@jic23-huawei>
In-Reply-To: <20260809-fxls8962af-fifo-v2-1-80ff1be1f1f2@cherr.cc>
References: <20260809-fxls8962af-fifo-v2-1-80ff1be1f1f2@cherr.cc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 09 Aug 2026 05:04:41 +0800
"Shengzhuo Wei" <me@cherr.cc> wrote:

> fxls8962af_fifo_flush() copies the number of samples the device reports
> in its FIFO status register into an on-stack buffer
> 
> 	u16 buffer[FXLS8962AF_FIFO_LENGTH * 3];
> 
> which is sized for at most FXLS8962AF_FIFO_LENGTH (32) samples. The
> sample count is read from the BUF_STATUS register and only masked to its
> 6 valid bits (0..63), with no clamp to the buffer size. The watermark
> path caps the count on the write side (fxls8962af_set_watermark) but
> the read path does not, so a malfunctioning or malicious device
> reporting BUF_CNT > 32 overflows the buffer.
> 
> Clamp count to FXLS8962AF_FIFO_LENGTH, mirroring the watermark clamp.
> 
> Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")

Same comments as similar patches.
- Not a fix, but rather hardening against buggy hardware.
- Don't hide the problem by clamping.  If this happens in the wild
  we want to know about it!


> Cc: stable@vger.kernel.org
> Assisted-by: GLM:5.2
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
> The transfer reads count * 6 bytes through regmap, so a device reporting
> up to 63 samples writes up to 378 bytes into the 192-byte buffer,
> clobbering the stack canary, saved registers and the return address.
> This mirrors the bmc150 fix (ce0e1cae2609). A well-formed flush reports
> at most FXLS8962AF_FIFO_LENGTH samples, so legitimate devices are
> unaffected.
> ---
> Changes in v2:
> - Use min() instead of min_t() as suggested by Andy Shevchenko.
> - Link to v1: https://lore.kernel.org/r/20260806-fxls8962af-fifo-v1-1-bd9d27047fee@cherr.cc
> ---
>  drivers/iio/accel/fxls8962af-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index d0c2a8daef0db964134ad10b25782b9f5752613d..18d7b09bddd2b4f506c3348bf4e8cf94ce1c554a 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -969,6 +969,8 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
>  	if (!count)
>  		return 0;
>  
> +	count = min(count, FXLS8962AF_FIFO_LENGTH);
> +
>  	data->old_timestamp = data->timestamp;
>  	data->timestamp = iio_get_time_ns(indio_dev);
>  
> 
> ---
> base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
> change-id: 20260806-fxls8962af-fifo-c3812fd02eeb
> 
> Best regards,

