Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39FB34DCCD;
	Fri, 21 Aug 2026 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787277074; cv=none; b=KphLPeZkS/ezWjc7wIR+HMjtUqbt8SvyBTohcokC22mOSsDiv1z2PiXPpB0Emhm8bH7kU6dCFfAO/bRcENu5iSfay3Ld7zVUGGczbBzXYPzPsrgQD1+Vsj5v4glt0rcAOVtgMN/uVN0KnfQNq7zmgXQRYXTZkiKiPtT4nz78rtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787277074; c=relaxed/simple;
	bh=4P6Hg0lYppW1y1uK7ZrF9StMejO5kWNUvyRAIAbJIkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIwWenL8jmc61adc6hJWMCDKXMErBbK5e4tpNKyyOSYA59CWzyVoNE0cvu1cuFREG1ZZDRnihbb8/J3oqr0u2GvnfyWjpZhtfO9z5+llPO84SnmftsSJQEUXrgBSUIZpgcwcE4DCM2uSAd19RthZ0g8HIA8eCXOauYfr8FdMDSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJVVlEQJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJVVlEQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8DA1F000E9;
	Fri, 21 Aug 2026 01:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787277072;
	bh=tGVDCqoa4y3n4kLVwNMULhjqCUA6KLa+MCUMGI70yUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cJVVlEQJNbb6njOpnaIanmbBv2VSmW9plsfGePcUWASCBY0jVLw7xLMtpFmjQpLAd
	 Przu61OvyjEkh0hjx0KEOeTspETMGlZOCm9RjYpBVqKEPscPumCymtWC79KJSsho3R
	 d9hEBIvrqgTD+Rdgplh/auewvQMAsW8yiRAhEdil+McAr6arw3A1JzjIqtMoZrTo+2
	 eTRbkD6fSEnonr8OwHoGd9aGDuvSDbhT004o8dWweQb6iR+q9QvPDeQ5OYyj31snPf
	 uCfQuWnrNQwjyAbyaGaxWAK/Uv+jNriwvbgQqpdUQkXwEaiPBNjc+xUhgXtNhQMlBT
	 kpG13jNPVWzPg==
Date: Fri, 21 Aug 2026 02:51:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: Remi Buisson <remi.buisson@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm45600: clamp FIFO packet count to
 buffer size
Message-ID: <20260821025105.4739d76b@jic23-huawei>
In-Reply-To: <20260820070208.3891851-1-gonglinkai@kylinos.cn>
References: <20260820070208.3891851-1-gonglinkai@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 15:02:08 +0800
Linkai Gong <gonglinkai@kylinos.cn> wrote:

> The IRQ path calls inv_icm45600_buffer_fifo_read(st, 0), so the raw
> 16-bit FIFO count sizes the read into st->fifo.data (8K). Cap the
> packet count so the transfer cannot exceed that buffer.
> 
> Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

I believe this is fixed in the iio tree (and shortly upstream), though
in a slightly different way.

Fwiw I don't consider these fixes because the hardware doesn't return
out of range values - rather they are hardening against a potential problem.

A few other things inline.


> ---
>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> index 2b9ea317385c..62e9e138bc89 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
> @@ -419,8 +419,10 @@ int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
>  	fifo_nb = le16_to_cpup(raw_fifo_count);
>  	if (fifo_nb == 0)
>  		return 0;
> -	if (max > 0 && fifo_nb > max)
> -		fifo_nb = max;
> +	if (max > 0)
> +		fifo_nb = min(fifo_nb, (size_t)max);

This looks like an unrelated change. min is pretty flexible on inputs anyway
so perhaps this is fine without that cast.

> +	fifo_nb = min_t(size_t, fifo_nb,
> +			INV_ICM45600_FIFO_SIZE_MAX / packet_size);

Why is min_t needed?  It very rarely is given how min handles mixed types.

Maybe I'm missing something here but I'm not going to chase
it down given we already have a fix in place

Thanks,

Jonathan


>  
>  	/* Try to read all FIFO data in internal buffer. */
>  	st->fifo.count = fifo_nb * packet_size;

