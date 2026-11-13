Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536521;
	b=4cVYe8BgkwGWWi3qIsRDf+IzAtJ1nCnvG9H24WR8xthRsdPLYL5YlVK5RPkfSDCHXaDZ
	 dmLiIFOLroK50WrtSYyJPjBxUOkuUQ/0ZxGypiy8PUTl6ZSjO6PU1QisQ5Kp3MCu08Qes
	 xy9I/Ha5UDUWD+e3PzLog6nlyPECUmmowYSXKvHirPWEd2ArVFU1U7Y6f/sVQDGfOwW7v
	 voKVot7WU2V4U3sHnzuV4yDdx0VuQOH/mR018GmcLYuKUxDwFlPof20c8M2s+jtrFqqW6
	 m4jJ/ckop05Ibw/w7QolSE0GHIqzeihQeyaIJRDhZo25oFlVKOkxpcBHDmH/BeCBaVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536521;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1e8Zov3aIUvbqlTHnCV5QfqsM4RMN8sn9PqG4yCFyy8=;
	b=xfvBdT9bWs4TRHrXzPbagNN4VFKjT4GybMsAw3umarnD62sabBulkqGlwNi4vX/uPh0/
	 85GLl5DE2jq5HeM5m+nn3pr22zgDocgKmv8+rLyL/hYndWdM4CcY5cQXmEbcUVcwk4s7C
	 d9plou4YRk3I3UKwW6lW+AGSBEUYKv69mer8DKyAVZrAwKNIQl+zVegFtS9WIkT1q7eki
	 6aD1L9fAoDusW9bnfZuTLzSBxRzDuPgp3NEmcNRAJn+sUYWyhsSwQ/licOJQhovi3a6HX
	 5P87zjsVKfJct3EV+aDtM7KQYMlRIp+IJqL85f5+xlFMJ+uO06lmFP/TVWPY2G7nZ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVGbk9a7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3310F606A31C;
	Fri, 13 Nov 2026 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVGbk9a7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C09C1F000C4;
	Fri, 13 Nov 2026 02:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794536520;
	bh=1e8Zov3aIUvbqlTHnCV5QfqsM4RMN8sn9PqG4yCFyy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NVGbk9a7SZ6LNOs7VeeCV6jFglmrl5Q9ybXiIdX7ALRKshWpZ4jQPsUcl9vbsaJRK
	 Y3Cx+ODsIjqrLoVZZ27Z7ptov73B9+KTNSd4HvZdkqMiuzUuFB32eAhOgenw+pH9YC
	 VUrb7gVT6pJFPnecIhXTwuBNzsCaWUw9Ik27EaOvVqXPdXJ5UdRgDBz2aJnIRmi5H/
	 2UAJOFiAJaOtRLP7ghqQo4YG+qm45vK6FKODKQJLvLqISFpm8o0/hYkJlk5t7vQlUd
	 nKvzIcmTqZEmlEeX7+yyThGiwntlR9viGrZZvCkZ0UMW97XQ1uNG/yYWhsyjSUQ8h4
	 2/HGg3w5YylAg==
Date: Fri, 13 Nov 2026 02:21:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: raoxu <raoxu@uniontech.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 luiz.von.dentz@intel.com, pengpeng@iscas.ac.cn, pmenzel@molgen.mpg.de,
 brgl@kernel.org, u.kleine-koenig@baylibre.com, lars@metafoo.de,
 mike.looijmans@topic.nl, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Joshua Crofts
 <crofts@kernel.org>
Subject: Re: [PATCH v3] iio: adc: ltc2471: Fix LTC2473 differential offset
Message-ID: <20261113022153.445fdcb7@jic23-hlaptop>
In-Reply-To: <B29B7229F9C3B748+20261110122414.373459-1-raoxu@uniontech.com>
References: <B29B7229F9C3B748+20261110122414.373459-1-raoxu@uniontech.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2026 20:24:14 +0800
raoxu <raoxu@uniontech.com> wrote:

> From: Xu Rao <raoxu@uniontech.com>
>=20
> The LTC2473 reports its differential conversion result as an unsigned
> 16-bit value spanning -VREF to +VREF. The IIO scale is consequently
> reported as 2 * VREF divided by 2^16.
>=20
> IIO offsets are expressed in raw codes, but the driver currently returns
> -LTC2471_VREF, which is a millivolt value. This makes the processed
> reading incorrect: with a 1.25 V reference, the midpoint raw code is
> shifted by 1250 instead of 32768 codes.
>=20
> Return the raw-code offset so that the midpoint maps to 0 mV and the
> endpoints map to -VREF and +VREF as intended. The single-ended LTC2471
> does not expose the offset attribute and is unaffected.
>=20
> Fixes: 1d3eacbfa644 ("iio: Add LTC2471/LTC2473 driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joshua Crofts <crofts@kernel.org>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
Applied to the fixes-togreg branch of iio.git

Thanks

Jonathan

> ---
> Changes in v3:
> - Add Reviewed-by tags from Nuno S=C3=A1 and Joshua Crofts.
> - Move the AI assistance disclosure out of the commit message.
> - No code changes from v2.
>=20
> Changes in v2:
> - Replace the raw -32768 literal with the named LTC2473_DIFF_OFFSET
>   macro.
>=20
> The supplied fix was reviewed and this commit message prepared with
> OpenCode AI assistance.
>=20
>  drivers/iio/adc/ltc2471.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
> index 369af700969f..eb418c0fa732 100644
> --- a/drivers/iio/adc/ltc2471.c
> +++ b/drivers/iio/adc/ltc2471.c
> @@ -25,6 +25,7 @@ struct ltc2471_data {
>=20
>  /* Reference voltage is 1.25V */
>  #define LTC2471_VREF 1250
> +#define LTC2473_DIFF_OFFSET (-32768)
>=20
>  /* Read two bytes from the I2C bus to obtain the ADC result */
>  static int ltc2471_get_value(struct i2c_client *client)
> @@ -69,7 +70,7 @@ static int ltc2471_read_raw(struct iio_dev *indio_dev,
>=20
>  	case IIO_CHAN_INFO_OFFSET:
>  		/* Only differential chip has this property */
> -		*val =3D -LTC2471_VREF;
> +		*val =3D LTC2473_DIFF_OFFSET;
>  		return IIO_VAL_INT;
>=20
>  	default:
> --
> 2.50.1

