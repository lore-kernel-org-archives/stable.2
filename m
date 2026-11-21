Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795300036;
	b=aShs77/vBmN4hMPkwFA5Q2OfEh+Kp+tnJjFt6yddiYkYkrmFR8S52+iHUpclH9tVJHQS
	 APnM6j1IyUIbbW5/6b2p1D22fDRvUpa0aUd+bQaSOt67Zdoi9q6QJIRVSZ94NEVn10I0y
	 2HpfeDabFvQgqN4Db67pilnlIxEf8PhJ3ydfNyZWuxmAwbwSL52Tv8nH/pP7rsWwe0MIs
	 t0e45EUthYPC/sArU91oCgZRC4aWKWW9cfJBWZJmsrJw9mjFWRdGUxgtB98gzb09qOqEW
	 EXqNrchbmwMFkbumNAswoCpArJDGaID9aLqtp1A495snLL0PJKQOwhZroU0veDuz+jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300036;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RihvPniou5txOaDj4hAYiWUZ+Z2yb/g8oclv99Iy3FY=;
	b=MH5XxJ5Rdko5Q6jKvpxAULlHdGNkcWrP2tIZ3E9YSm9k9CMDjROY/dUQ3hyilphV6hDc
	 LhfKXPy8hdqVOI+of3Fi39vK6Xcu9ry9SghsHXKPhss+PBkvB7MOG8qrygJ3B18wlsVU+
	 cEAjOeJyffaxRTy5PyORfCAAkq76z49OGp+IjI19Y91JfQf7hlivZRqubwGE1uHF8zHiA
	 PX4W9YCODzSA+3lN+fI3P5Y70It3tSyB6/NYTYAk71SaeZNThzM/+3HmmK+hONPNNz4cZ
	 YmvvS6CwyFRgSnDb66c0fOdvMl/ge5zgHD/MVn3eREhwFxLnLFHjl/N/VeF7MfyT9aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6OMninS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B3E606A32C;
	Sat, 21 Nov 2026 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6OMninS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7911F000C0;
	Sat, 21 Nov 2026 22:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300036;
	bh=RihvPniou5txOaDj4hAYiWUZ+Z2yb/g8oclv99Iy3FY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g6OMninSwCoR6jkb1GkIRhlcgZVmxqKKUce4bho4GuuSWyck+4OI+7ftwIeR4kIUS
	 DN3WGCNc21CGaKviBKv7Btxbu7COOaK8PAynqnpmRzJ7svJVV0ZsIdiG87NsG7j5q4
	 G9C/SyO2KEgHuSAem11BRtd+WEB70dWliYTGfp/jJmMo0BvnbI7iy4U9RgQsAkFUJc
	 lHZOa1F74zRLwzvz+fcCiNC621GmZNPxmdU514BvMF8cqP4uf5GYyEE7vkgPItmoTd
	 yVkeFnG7RT9vRj5Vt9t9kD+y/mLLbpS9iof22BTNpM1WnsijzI65WGdmhh22HWjjE0
	 LGRUS/q8Fwsfw==
Date: Sat, 21 Nov 2026 22:27:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux@analog.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
Subject: Re: [PATCH 01/10] iio: imu: adis: Clear pointers after freeing in
 adis_update_scan_mode()
Message-ID: <20261121222710.526017ac@jic23-hlaptop>
In-Reply-To: <20261119153151.1397003-2-lee@kernel.org>
References: <20261119153151.1397003-1-lee@kernel.org>
	<20261119153151.1397003-2-lee@kernel.org>
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

On Thu, 19 Nov 2026 15:30:34 +0000
Lee Jones <lee@kernel.org> wrote:

> adis_update_scan_mode() frees both adis->xfer and adis->buffer at the
> start of a scan mode update without clearing either pointer to NULL.
> 
> In both adis_update_scan_mode_burst() and the non-burst path, adis->xfer
> is allocated before adis->buffer.  If the adis->xfer allocation fails,
> the function returns -ENOMEM while adis->buffer still holds the freed
> pointer from the previous scan configuration, causing a double-free on
> the next scan mode update or during device teardown in
> adis_buffer_cleanup().
> 
> Clear both pointers immediately after freeing them.
> 
> Fixes: aacff892cbd5 ("staging:iio:adis: Preallocate transfer message")
> Closes: https://sashiko.dev/#/bug/linux-966f0cd4-488a-4d69-b8a5-449c751365d2
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Seems good to me. Given Radu has a bunch of work in flight on around
the adis drivers and lib. +CC Radu to take a look before I pick this up.

> ---
>  drivers/iio/imu/adis_buffer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 501da4eaef69..9d317b627eba 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -74,7 +74,9 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
>  	__be16 *tx, *rx;
>  
>  	kfree(adis->xfer);
> +	adis->xfer = NULL;
>  	kfree(adis->buffer);
> +	adis->buffer = NULL;
>  
>  	if (adis->data->burst_len)
>  		return adis_update_scan_mode_burst(indio_dev, scan_mask);

