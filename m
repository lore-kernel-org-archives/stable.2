Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214545;
	b=Fx9ZHX/Ky9FxL9mk6OMFOiLYT8Ai52HVTi1wSnHsr36aCuus+RMTqrcdoJkdPDTmrbmZ
	 8ltS2mKHdCk4ZG9EdOEyHPBpYFdvHHYFIbiG8FtWqDaKUBvWtEJAR9Y8ewb8cKKzr8+EN
	 /s2dB4p2KgrHAQqI7nUerU/zC+kxoMG5w+y/1jnbCYtxFyaP9mIRA66TtwFg8V7enxH3M
	 NQZkX1vFxRqmo1p/nTh0g7zVwOOgdIGSP0Hf+hrNp3jwpWQYuSCLr9qlsegRMhlDTlRBs
	 HctbOhiJQRvsJm+FzzaFqV8j4K5cOgKBIa+B2kpSZnNF6GbYLcdHLElejVkOySBfX8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214545;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jMJVP1EWAY7v24jepAOUKrZ36h9yAqWaq4AQNfmjYUI=;
	b=f+hH9/MAZJkdjJroKnGggtEnMBq2If3gotM/3HZaiP9KgTpSwgRyudmc/4SAALYsKKwT
	 f2thMSukkuhsuj/eCeLU34bl97DWOFYLg97XjxaaaoYPVPZbxSHpdRTG8TdmT8JWn0IHn
	 jEKFzTrkTcyfBeY3/djGSRXy/dIu2/KmOJt6DhZDUHu2yUxbQEj+3KjFBygt7pQZtNgeF
	 aXhiYZKAca0RvpAXkR94tUDf9zKKhec8DmFExCirckBfF9oCgnDFlP/UlRnm9hRmougAV
	 c2FaXb0c3t5mIAaTOTAYQxt/WqZi6z0ExpeGFsP224Io6W+VuefkkurOwt+hzsEeZYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EOpy+mq/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D1606A321;
	Mon,  9 Nov 2026 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOpy+mq/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC211F0089F;
	Mon,  9 Nov 2026 08:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794214545;
	bh=jMJVP1EWAY7v24jepAOUKrZ36h9yAqWaq4AQNfmjYUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EOpy+mq/IKsrxfBTrvBcRIu8Ks1lx/eh+zWohWk2dTnRslMyxd+hs6REMdkXFfemD
	 w4uhCY9I9IP0NR/joJb3jodN7ekQuLs1qVygXoQFSnjjbkUfCAt/xcdERb5M6aJ99h
	 O5DdB3E1e8xFzUcjPvF7ZgFfN0JQ6hexz4kJG6yiJLqzxFcy2OyLuv6v7gRLCCwbB+
	 MSpVDzKWGE0BUSS1DIDDR7KZhE3TnnvRN3JK4N410NDOBaXA6ZpxIT1kCGca35JTNZ
	 CNY7VCS+o0Mlx8TbeBAz04dgdpBL/cLdA3UWWWuduDn73mae1SKOU2TXe4plJ9fCbh
	 xebYwOhZLVFKg==
Date: Mon, 9 Nov 2026 09:55:42 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: st_uvis25: notify the current trigger when
 done
Message-ID: <avGKjh7GOtE2tPGt@lore-desk>
References: <20261109025454.1260519-1-jic23@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ocgm+6pen8YcaMRm"
Content-Disposition: inline
In-Reply-To: <20261109025454.1260519-1-jic23@kernel.org>

--Ocgm+6pen8YcaMRm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>=20
> The trigger handler calls iio_trigger_notify_done() on the driver's own
> trigger rather than on the trigger that is currently in use by the
> device. The driver does not restrict which trigger may be used, so if
> another trigger, for example an hrtimer trigger, is selected then that
> trigger's use_count is never decremented and it stops firing after the
> first sample. The driver's own trigger use_count also underflows,
> preventing it from firing later.
>=20
> Use iio_dev->trig instead.
>=20
> Fixes: 3025c8688c1e ("iio: light: add support for UVIS25 sensor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> Another LLM found one as part of refactoring how all the code around
> triggers works.  Definitely the wrong trigger. There are lots
> that access the right trigger via the wrong path (shortly to be
> cleaned up), this one manages to get the wrong one in many cases!
> ---
>  drivers/iio/light/st_uvis25_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uv=
is25_core.c
> index 94d5261b2663..5c63a68948d6 100644
> --- a/drivers/iio/light/st_uvis25_core.c
> +++ b/drivers/iio/light/st_uvis25_core.c
> @@ -248,7 +248,7 @@ static irqreturn_t st_uvis25_buffer_handler_thread(in=
t irq, void *p)
>  				    iio_get_time_ns(iio_dev));
> =20
>  out:
> -	iio_trigger_notify_done(hw->trig);
> +	iio_trigger_notify_done(iio_dev->trig);
> =20
>  	return IRQ_HANDLED;
>  }
> --=20
> 2.56.0
>=20

--Ocgm+6pen8YcaMRm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavGKjgAKCRA6cBh0uS2t
rCXOAQCiLo2C4XxO9ZhNmnNsBvC9IoMTM/b27FZdsilqWvjFKwD8Ds6EIZxik5VR
9uF9bfgCAFE3IrWddQam3c45HQdDGwQ=
=e9tg
-----END PGP SIGNATURE-----

--Ocgm+6pen8YcaMRm--
